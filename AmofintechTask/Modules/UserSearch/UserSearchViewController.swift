//
//  UserSearchViewController.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import UIKit

final class UserSearchViewController: BaseViewController {
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, UserServerModel> = {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model in
            let cell: UserCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: model)
            return cell
        }
    }()
    
    var output: UserSearchViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension UserSearchViewController: UserSearchViewInput {
    func updateDataSource(with users: [UserServerModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UserServerModel>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(users, toSection: .zero)
        
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

private extension UserSearchViewController {
    func configure() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 71.0
        tableView.register(UserCell.self)
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.viewDidChangeSearchText(searchText)
    }
}

extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
