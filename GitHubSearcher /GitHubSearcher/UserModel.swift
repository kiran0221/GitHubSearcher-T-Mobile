//
//  UserModel.swift
//  GitHubSearcher
//
//  Created by Saikiran Ealapanti on 04/10/20.
//  Copyright © 2019 Saikiran. All rights reserved.
//

import Foundation
struct UserResponse: Codable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [UserModel]?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total_count = try container.decodeIfPresent(Int.self, forKey: .total_count)
        incomplete_results = try container.decodeIfPresent(Bool.self, forKey: .incomplete_results)
        items = try container.decodeIfPresent([UserModel].self, forKey: .items)
    }
}

struct UserModel: Codable {
    var login: String?
    var id: Int?
    var node_id: String?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool?
    var score: Double?
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decodeIfPresent(String.self, forKey: .login)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        node_id = try container.decodeIfPresent(String.self, forKey: .node_id)
        avatar_url = try container.decodeIfPresent(String.self, forKey: .avatar_url)
        gravatar_id = try container.decodeIfPresent(String.self, forKey: .gravatar_id)
        url =  try container.decodeIfPresent(String.self, forKey: .url)
        html_url =  try container.decodeIfPresent(String.self, forKey: .html_url)
        followers_url =  try container.decodeIfPresent(String.self, forKey: .followers_url)
        following_url =  try container.decodeIfPresent(String.self, forKey: .following_url)
        gists_url = try container.decodeIfPresent(String.self, forKey: .gists_url)
        starred_url = try container.decodeIfPresent(String.self, forKey: .starred_url)
        subscriptions_url = try container.decodeIfPresent(String.self, forKey: .subscriptions_url)
        organizations_url =  try container.decodeIfPresent(String.self, forKey: .organizations_url)
        repos_url =  try container.decodeIfPresent(String.self, forKey: .repos_url)
        events_url =  try container.decodeIfPresent(String.self, forKey: .events_url)
        received_events_url =  try container.decodeIfPresent(String.self, forKey: .received_events_url)
        type =  try container.decodeIfPresent(String.self, forKey: .type)
        site_admin =  try container.decodeIfPresent(Bool.self, forKey: .site_admin)
        score =  try container.decodeIfPresent(Double.self, forKey: .score)
    }
}


struct RepoModel: Codable {
    var id: Int?
    var node_id: String?
    var name: String?
    var full_name: String?
    var owner: UserModel?
    var forks_count: Int?
    var stargazers_count: Int?
    var created_at: String?
    var description: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        node_id = try container.decodeIfPresent(String.self, forKey: .node_id)
        full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        owner = try container.decodeIfPresent(UserModel.self, forKey: .owner)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        stargazers_count = try container.decodeIfPresent(Int.self, forKey: .stargazers_count)
        forks_count = try container.decodeIfPresent(Int.self, forKey: .forks_count)
        description = try container.decodeIfPresent(String.self, forKey: .description)

    }
}
