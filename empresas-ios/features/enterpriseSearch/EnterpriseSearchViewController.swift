//
//  EnterpriseSearchViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 01/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol EnterpriseSearchViewModelProtocol {
    
    var enterprises: Driver<[Enterprise]> { get }
    var searchTextSubject: PublishSubject<String?> { get }
    var searchMessage: Driver<String?> { get }
    var resultsFoundMessage: Driver<String?> { get }
}

final class EnterpriseSearchViewController: UIViewController {
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultsFoundLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel(frame: tableView.bounds)
        label.font = .rubikLight(size: 18)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private var enterprises: [Enterprise] = []
    private let viewModel: EnterpriseSearchViewModelProtocol
    private let cellIdentifier = "cellIdentifier"
    private let disposeBag = DisposeBag()
    
    init(viewModel: EnterpriseSearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
    deinit {
        print(self.description)
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.delegate = self
        setupTableView()
        applyLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        tableView.endEditing(true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(EnterpriseTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func applyLayout() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        searchBar.searchTextField.backgroundColor = .backgroundGray
        searchBar.searchTextField.font = .rubikLight(size: 18)
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.leftView?.tintColor = .gray
        searchBar.barTintColor = .backgroundGray
        searchBar.layer.cornerRadius = 4
        searchBar.layer.masksToBounds = true
        
        resultsFoundLabel.font = .rubikLight(size: 14)
        resultsFoundLabel.textColor = .gray
        resultsFoundLabel.text = nil
    }
    
    private func bind() {
        
        viewModel.resultsFoundMessage
            .drive(resultsFoundLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.searchMessage
            .drive(messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.enterprises
            .drive(onNext: { [weak self] (enterprises) in
                self?.enterprises = enterprises
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .debug()
//            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchTextSubject)
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension EnterpriseSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        enterprises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = enterprises[indexPath.row].enterpriseName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let enterpriseDetailsViewController = EnterpriseDetailsViewController(viewModel: EnterpriseDetailsViewModel(enterprise: enterprises[indexPath.row]))
        navigationController?.pushViewController(enterpriseDetailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        messageLabel
    }
}

// MARK: UITextFieldDelegate
extension EnterpriseSearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.headerViewHeightConstraint.constant = 150
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.headerViewHeightConstraint.constant = 250
        })
    }
}
