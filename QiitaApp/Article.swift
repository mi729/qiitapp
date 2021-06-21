//
//  Article.swift
//  QiitaApp
//
//  Created by mi729 on 2021/06/21.
//  
//

import Foundation

struct Article: Codable {
    let title: String
    var user: User
    
    struct User: Codable {
        var name: String
    }
}
