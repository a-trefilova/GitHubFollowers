//
//  Follower.swift
//  GHFollowers
//
//  Created by Alyona Sabitskaya  on 14.06.2021.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
