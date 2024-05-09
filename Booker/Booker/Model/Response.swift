//
//  Response.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import Foundation

struct Response: Codable {
    let meta: Meta
    let documents: [Document]
}

struct Meta: Codable {
    let is_end: Bool
    let pageable_count: Int
    let total_count: Int
    
    init(total_count: Int, pageable_count: Int, is_end: Bool) {
        self.total_count = total_count
        self.pageable_count = pageable_count
        self.is_end = is_end
    }
}

struct Document: Codable {
    let title: String
    let contents: String
    let url: String
    //let isbn: String
    let authors: [String]
    let publisher: String
    //let translators: [String]
    let price: Int
    //let sale_price: Int
    let thumbnail: String
    //let status: String
}
