//
//  UserCell.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import UIKit
import Kingfisher

final class UserCell: UITableViewCell, Reusable, Configurable, NibLoadableView {
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var repoCountLabel: UILabel!
    
    func configure(with viewModel: UserDetailsServerModel) {
        userNameLabel.text = viewModel.userName
        repoCountLabel.text = "Repo: \(viewModel.publicReposCount)"
        
        if let avatarURL = viewModel.avatarURL {
            userImageView.kf.setImage(with: URL(string: avatarURL))
        }
    }
}
