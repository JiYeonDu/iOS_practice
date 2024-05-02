//
//  NetworkManager.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import Foundation

final class NetworkManager {
    
    // MARK: - properties
    // singleton
    static let shared = NetworkViewModel()
    private init() { }
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    private let url = "https://dapi.kakao.com/v3/search/book"

    // MARK: - methods
    
}
