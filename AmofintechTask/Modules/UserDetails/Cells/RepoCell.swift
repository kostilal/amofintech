//
//  RepoCell.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 11.02.2024.
//

import UIKit

final class RepoCell: UITableViewCell, Reusable, Configurable, NibLoadableView {
    @IBOutlet weak private var repoNameLabel: UILabel!
    @IBOutlet weak private var forksLabel: UILabel!
    @IBOutlet weak private var starsLabel: UILabel!
    
    func configure(with viewModel: GithubRepo) {
        repoNameLabel.text = viewModel.repositoryName
        forksLabel.text = "\(viewModel.forksCount) Forks"
        starsLabel.text = "\(viewModel.starsCount) Stars"
    }
}
