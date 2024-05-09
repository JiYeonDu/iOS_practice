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
    func fetchSearchResult(keyword: String, page: Int, completion: @escaping ((Result<Response, Error>) -> Void)) {
        print(keyword)
        guard let url = URL(string: "\(url)?query=\(keyword)&page=\(page)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
            } else if let data = data {
                do {
                    let product = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(product))
                } catch {
                    completion(.failure(error))
                    print("Decode Error: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    
    //        AF.request(url,
    //                   method: .get,
    //                   parameters: param,
    //                   headers: headers).responseDecodable(of: Response.self) { response in
    //            switch response.result {
    //            case .success(let value):
    //                completion(.success(value))
    //            case .failure(let error):
    //                print("===============\(error)================")
    //                completion(.failure(error))
    //            }
    //        }
    
}



