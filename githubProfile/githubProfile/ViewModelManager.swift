//
//  ViewModelManager.swift
//  githubProfile
//
//  Created by 신지연 on 2024/04/06.
//

import Foundation
import Alamofire

class ViewModelManager {
    
    struct Profile: Codable {
        let login: String
        let followers: Int
        let following: Int
        let public_repos: Int
        let bio: String?
        let avatar_url: String
        let repos_url: String
    }
    
    struct Repo: Codable {
        let language: String
        let name: String
        let description: String?
        let public_repos: Int
    }

    public func callProfileAPI(completion: @escaping (Profile?) -> Void) {
        let url = "https://api.github.com/users/jiyeondu"
        let param = ["auth" : "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"]
        AF.request(url, method: .get, parameters: param).responseDecodable(of: Profile.self){
            (response) in
            switch response.result {
            case .success(let value):
                // 성공적으로 문자열로 변환된 응답을 처리
                    //throwable한 함수
                print(value)
                    
                    //let jsondata = try JSONSerialization.data(withJSONObject: value)
                    //let decoder = JSONDecoder()
                    //let data = try decoder.decode(Array<Country>.self, from: jsondata )
                completion(value)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func callRepoAPI(completion: @escaping (Repo?) -> Void) {
        let url = "https://api.github.com/users/jiyeondu/repos"
        let param = ["auth" : "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"]
        AF.request(url, method: .get, parameters: param).responseDecodable(of: Repo.self){
            (response) in
            switch response.result {
            case .success(let value):
                // 성공적으로 문자열로 변환된 응답을 처리
                    //throwable한 함수
                print(value)
                    
                    //let jsondata = try JSONSerialization.data(withJSONObject: value)
                    //let decoder = JSONDecoder()
                    //let data = try decoder.decode(Array<Country>.self, from: jsondata )
                completion(value)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}


