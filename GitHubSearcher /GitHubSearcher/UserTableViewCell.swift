//
//  UserTableViewCell.swift
//  GitHubSearcher
//
//  Created by Saikiran Ealapanti on 04/10/20.
//  Copyright © 2019 Saikiran. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var repositaryDisplayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.gray.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateCell(_ user: UserModel) {
        if let urlString = user.avatar_url, let url = URL(string: urlString) {
            imageIcon.load(url: url)
        }
        if let userName = user.login {
            userNameLbl.text = userName
        }
        if let repo = user.repos_url {
            repositaryDisplayLabel.text = repo
        }
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
