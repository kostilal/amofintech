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
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, UserDetailsServerModel> = {
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
    func updateDataSource(with users: [UserDetailsServerModel]) {
        tableView.restore()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, UserDetailsServerModel>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(users, toSection: .zero)
        
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

private extension UserSearchViewController {
    func configure() {
        title = "Github Searcher"
        
        searchBar.delegate = self
        searchBar.placeholder = "Search user"
        
        tableView.delegate = self
        tableView.register(cell: UserCell.self)
        tableView.dataSource = dataSource
        tableView.rowHeight = 70.0
        tableView.setEmptyMessage("Search Github user")
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.viewDidChangeSearchText(searchText)
    }
}

extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectUser(index: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
