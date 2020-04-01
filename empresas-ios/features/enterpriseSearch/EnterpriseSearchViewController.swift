//
//  EnterpriseSearchViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol EnterpriseSearchViewModelProtocol {
    
    var enterprises: Driver<[Enterprise]> { get }
    var searchTextSubject: PublishSubject<String> { get }
    var searchMessage: Driver<String?> { get }
}

final class EnterpriseSearchViewController: UITableViewController {
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.placeholder = "Pesquise por empresa"
        searchController.searchBar.searchTextField.backgroundColor = .white
        return searchController
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubikLight(size: 18)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyLayout()
    }
    
    private func applyLayout() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(named: "lauch_screen_background")!, for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = false
            navigationBar.tintColor = .primary
            navigationBar.backgroundColor = UIColor(patternImage: UIImage(named: "lauch_screen_background")!)
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.register(EnterpriseTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = messageLabel
        
        tableView.addConstraints([
            messageLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
    
    private func bind() {
        
        viewModel.searchMessage
            .drive(messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.enterprises
            .drive(onNext: { [weak self] (enterprises) in
                self?.enterprises = enterprises
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] (text) in
                guard let text = text, !text.isEmpty else { return }
                self?.viewModel.searchTextSubject.onNext(text)
        }
        .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension EnterpriseSearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        enterprises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = enterprises[indexPath.row].enterpriseName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let enterpriseDetailsViewController = EnterpriseDetailsViewController(viewModel: EnterpriseDetailsViewModel())
        navigationController?.pushViewController(enterpriseDetailsViewController, animated: true)
    }
}
