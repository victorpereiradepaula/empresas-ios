//
//  EnterpriseSearchViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift

final class EnterpriseSearchViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cellIdentifier = "cellIdentifier"
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for university"
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        bind()
    }

    private func configureProperties() {
        tableView.register(EnterpriseTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }

    private func bind() {
        searchController.searchBar.rx.text.asObservable()
            .map { EnterprisesRequest(name: $0 ?? "") }
            .flatMap { request -> Observable<[Enterprise]> in
                let enterpriseArray: Observable<EnterpriseArray> = self.apiClient.send(apiRequest: request)
                return enterpriseArray.map { $0.enterprises }
            }
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
                cell.textLabel?.text = model.enterpriseName
                cell.detailTextLabel?.text = model.description
                cell.textLabel?.adjustsFontSizeToFitWidth = true
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Enterprise.self)
            .map { EnterprisesRequest(id: $0.id) }
            .flatMap { request -> Observable<EnterpriseDetails> in
                return self.apiClient.send(apiRequest: request)
            }
            .bind { [weak self] (enterprise) in
                print("\(enterprise)")
            }
            .disposed(by: disposeBag)
    }
}
