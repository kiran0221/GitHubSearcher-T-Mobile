//
//  ReposViewController.swift
//  GitHubSearcher
//
//  Created by Saikiran Ealapanti on 04/10/20.
//  Copyright © 2019 Saikiran. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {
 var repoUrlStr: String!
    var searchStr = ""
    var follwerCount = 0
    var followingCount = 0
    @IBOutlet var tblView: UITableView!
    @IBOutlet var aImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var followersCountLabel: UILabel!
    @IBOutlet var followingCountLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    var user: UserModel!
    var repoList = [RepoModel]()
    var list = [RepoModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.estimatedRowHeight = 50
        tblView.rowHeight = UITableView.automaticDimension
        followersCountLabel.text = "\(follwerCount) Followers"
        followingCountLabel.text = "\(followingCount) Following"
        nameLabel.text = user.login
       
        DispatchQueue.main.async {
            if let urlString = self.user.avatar_url, let url = URL(string: urlString) {
                self.aImageView.load(url: url)
            }
        }
        ServiceManager().fetchRepoList(url: repoUrlStr) { response, error in
            if let responseObj = response {
                self.repoList = responseObj
                self.list = responseObj
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ReposViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "RepoTableViewCell", for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
          }
        if let user = list[indexPath.row] as? RepoModel {
            cell.updateCell(user)
        }
         return cell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = list[indexPath.row]
        if let urlStr = user.owner?.repos_url {
            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
        }
    }
}

extension ReposViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if let text = searchBar.text, !text.isEmpty {
             list = repoList.filter{($0.name?.contains(text) ?? false)}
        }
        else {
            list = repoList
        }
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list = repoList
       DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let stringRange = Range(range, in: searchStr) else { return false }
           searchStr = searchStr.replacingCharacters(in: stringRange, with: text)
        if !searchStr.isEmpty {
          list = repoList.filter{($0.name?.contains(text) ?? false)}
        }
        else {
            list = repoList
        }
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        return true
    }
}
