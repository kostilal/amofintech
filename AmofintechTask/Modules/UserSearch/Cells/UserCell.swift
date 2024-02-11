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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func configure(with viewModel: UserServerModel) {
        userImageView.kf.setImage(with: URL(string: viewModel.avatarURL))
        userNameLabel.text = viewModel.userName
        repoCountLabel.text = "Repo: \(viewModel.reposCount)"
    }
}

private extension UserCell {
    func setup() {
        
    }
}
