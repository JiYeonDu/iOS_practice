//
//  NetworkManager.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - properties
    // singleton
    static let shared = NetworkManager()
    private init() { }
    
    // header
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    // url
    private let url = "https://dapi.kakao.com/v3/search/book"
    
    // 쿼리 파라미터
    private let size = 10
    private let target = ""
    private let sort = ""
    
    
    
    // MARK: - methods
    func fetchSearchResult(keyword: String, page: Int,  completion: @escaping ((Result<[Response], Error>) -> Void)) {
        let param = ["query": keyword, "data": "AP01"]
        AF.request(url,
                   method: .get,
                   parameters: param).responseDecodable(of: [Response].self) { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsondata = try JSONSerialization.data(withJSONObject: value)
                    let decoder = JSONDecoder()
                    let data = try decoder.decode([Response].self, from: jsondata)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}
