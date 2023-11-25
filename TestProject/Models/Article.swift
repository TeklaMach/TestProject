//
//  Article.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation
// Article here is Decodable but the News was not Decodable, so I made News type Decodable and it worked
struct Article: Decodable {
    let articles: [News]
}



