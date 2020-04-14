//
//  RepoTableViewCell.swift
//  GitHubSearcher
//
//  Created by Saikiran Ealapanti on 04/10/20.
//  Copyright © 2019 Saikiran. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    @IBOutlet var starsAndForksDisplayLabel: UILabel!
    @IBOutlet var repoNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(_ repo: RepoModel) {
        if let name = repo.name {
            repoNameLabel.text = name
        }
        var str = ""
        if let forksCount = repo.forks_count {
            str = "\(forksCount) Forks \n"
        }
        if let starCount = repo.stargazers_count {
            str = str + "\(starCount) Stars"
        }
        starsAndForksDisplayLabel.text = str

    }
}
