//
//  APIClient.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import Foundation

final class APIClient {
    
    private let baseURL = URL(string: "https://empresas.ioasys.com.br/api/v1")!
    
    private lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func send<T: CodableModel>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: self.baseURL)
            print(request)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                do {
                    let model: T = try self.jsonDecoder.decode(T.self, from: data ?? Data())
                    if let response = response as? HTTPURLResponse {
                        if model is User {
                            self.updateSession(response: response)
                        } else if response.statusCode == 401 {
                            SessionManager.shared.removeSession()
                        }
                    }
                    
                    if let errors = model.errors {
                        observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errors.joined(separator: ", ")]))
                    } else {
                        observer.onNext(model)
                    }
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func updateSession(response: HTTPURLResponse) {
        let allHeaderFields = response.allHeaderFields
        
        if let client = allHeaderFields["client"] as? String, let accessToken = allHeaderFields["access-token"] as? String, let uid = allHeaderFields["uid"] as? String {
            SessionManager.shared.updateSession(UserSession(client: client, accessToken: accessToken, uid: uid))
        }
    }
}
