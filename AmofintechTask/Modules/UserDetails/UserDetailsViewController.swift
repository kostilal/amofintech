//
//  UserDetailsViewController.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import UIKit

final class UserDetailsViewController: BaseViewController {
    @IBOutlet weak private var userName: UILabel!
    @IBOutlet weak private var email: UILabel!
    @IBOutlet weak private var location: UILabel!
    @IBOutlet weak private var joinDate: UILabel!
    @IBOutlet weak private var followers: UILabel!
    @IBOutlet weak private var following: UILabel!
    @IBOutlet weak private var bio: UILabel!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var avatarImageView: UIImageView!
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, GithubRepo> = {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model in
            let cell: RepoCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: model)
            return cell
        }
    }()
    
    var output: UserDetailsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        output.viewDidLoad()
    }
}

extension UserDetailsViewController: UserDetailsViewInput {
    func setUserModel(userModel: UserDetailsServerModel) {
        title = userModel.userName
        
        userName.text = userModel.userName
        email.text = userModel.email
        location.text = userModel.location
        joinDate.text = userModel.createdAt
        followers.text = "Folowers \(userModel.followersCount)"
        following.text = "\(userModel.followingCount) Folowing"
        bio.text = userModel.bio
        
        let date = Date(dateString: userModel.createdAt)
        joinDate.text = UserDateFormatter().string(from: date)
        
        if let avatarURL = userModel.avatarURL {
            avatarImageView.kf.setImage(with: URL(string: avatarURL))
        }
    }
    
    func updateDataSource(with repos: [GithubRepo]) {
        if repos.isEmpty {
            tableView.setEmptyMessage("No Repos found")
        } else {
            tableView.restore()
            var snapshot = NSDiffableDataSourceSnapshot<Int, GithubRepo>()
            snapshot.appendSections([.zero])
            snapshot.appendItems(repos, toSection: .zero)
            
            dataSource.applySnapshotUsingReloadData(snapshot)
        }
    }
}

private extension UserDetailsViewController {
    func configure() {
        searchBar.delegate = self
        searchBar.placeholder = "Search repo"
        
        tableView.delegate = self
        tableView.register(cell: RepoCell.self)
        tableView.dataSource = dataSource
        tableView.rowHeight = 60.0
    }
}

extension UserDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.viewDidChangeSearchText(searchText)
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectRepo(index: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

