//
//  Response.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import Foundation

struct Response: Decodable {
    let meta: Meta
    let documents: [Document]
}

struct Meta: Decodable {
    let total_count: Int
    let pageable_count: Int
    let is_end: Bool
}

struct Document: Decodable {
    let title: String
    let contents: String
    let url: String
    let isbn: String
    let datetime: Date
    let authors: [String]
    let publisher: String
    let translators: [String]
    let price: Int
    let sale_price: Int
    let thumbnail: String
    let status: String
}
