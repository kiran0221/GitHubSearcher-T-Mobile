//
//  UsersViewController.swift
//  GitHubSearcher
//
//  Created by Saikiran Ealapanti on 04/10/20.
//  Copyright © 2019 Saikiran. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    var userResponse: UserResponse? = nil
    @IBOutlet var tblView: UITableView!
    var searchStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.estimatedRowHeight = 100
        tblView.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResponse?.items?.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
          }
        if let user = userResponse?.items?[indexPath.row] {
            cell.updateCell(user)
        }
         return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = userResponse?.items?[indexPath.row], let repoUrl = user.repos_url {
            var followersCount = 0
            var followingCount = 0
            ServiceManager().fetchSearchUsersFollowersAndFollowings(url: user.followers_url ?? "") { followers, error in
                 followersCount = followers?.count ?? 0
                ServiceManager().fetchSearchUsersFollowersAndFollowings(url: user.following_url ?? "") { followers, error in
                    followingCount = followers?.count ?? 0
                    DispatchQueue.main.async {
                        if #available(iOS 13.0, *) {
                           guard let vc = self.storyboard?.instantiateViewController(identifier: "ReposViewController") as? ReposViewController else { return }
                           vc.repoUrlStr = repoUrl
                            vc.follwerCount = followersCount
                            vc.followingCount = followingCount
                            vc.user = user
                           self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                           guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReposViewController") as? ReposViewController else { return }
                           vc.repoUrlStr = repoUrl
                            vc.follwerCount = followersCount
                            vc.followingCount = followingCount
                            vc.user = user
                           self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }
            }
        }
    }
    
    
}


extension UsersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if let text = searchBar.text, !text.isEmpty {
            ServiceManager().fetchSearchUsersList(userName: text) { response, error in
                if let responseObj = response {
                    self.userResponse = responseObj
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                }
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let stringRange = Range(range, in: searchStr) else { return false }
        searchStr = searchStr.replacingCharacters(in: stringRange, with: text)
        if !searchStr.isEmpty {
            ServiceManager().fetchSearchUsersList(userName: searchStr) { response, error in
                if let responseObj = response {
                    self.userResponse = responseObj
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                }
            }
        }
        return true
    }
}
