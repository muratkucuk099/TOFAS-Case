//
//  PostsModel.swift
//  TOFAS
//
//  Created by Mac on 24.01.2024.
//

import Foundation

struct PostModel: Codable {
    let userId, id: Int
    let title, body: String
}
