//
//  ServiceManager.swift
//  GitHubSearcher
//
//  Created by Saikiran Ealapanti on 04/10/20.
//  Copyright © 2019 Saikiran. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    func fetchSearchUsersList(userName: String, completion: @escaping((UserResponse?, Error?) -> ())){
           let urlString = "https://api.github.com/search/users?q=\(userName)+repos:%3E42+followers:%3E1000"
           var request = URLRequest(url: URL(string: urlString)!)
           request.httpMethod = "GET"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           let session = URLSession.shared
           let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
               do {
                   if let data = data {
                       let responseModel = try? JSONDecoder().decode(UserResponse.self, from: data)
                       completion(responseModel,  nil)
                   }
                   else {
                       completion(nil,  error)
                   }
               }
           })
           task.resume()
       }
       
       func fetchRepoList(url: String, completion: @escaping(([RepoModel]?, Error?) -> ())){
           let urlString = url
           var request = URLRequest(url: URL(string: urlString)!)
           request.httpMethod = "GET"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           let session = URLSession.shared
           let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
               print(response!)
               do {
                   if let data = data {
                       let responseModel = try? JSONDecoder().decode([RepoModel].self, from: data)
                       completion(responseModel,  nil)
                   }
                   else {
                       completion(nil,  error)
                   }
               }
           })
           task.resume()
       }
       
       func fetchSearchUsersFollowersAndFollowings(url: String, completion: @escaping(([UserModel]?, Error?) -> ())){
              var urlString = url
               urlString = urlString.replacingOccurrences(of: "{/other_user}", with: "")
              var request = URLRequest(url: URL(string: urlString)!)
              request.httpMethod = "GET"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
              let session = URLSession.shared
              let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                  print(response!)
                  do {
                      if let data = data {
                          let responseModel = try? JSONDecoder().decode([UserModel].self, from: data)
                          completion(responseModel,  nil)
                      }
                      else {
                          completion(nil,  error)
                      }
                  }
              })
              task.resume()
          }
}
