//
//  ViewModel.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import Foundation
import CoreData

class ViewModel {
    
    let networkManager = NetworkManager.shared
    let coredataManager = CoreDataManager.shared
    
    
    func searchResult(word: String, page: Int, completion: @escaping (Result<Response, Error>) -> Void) {
        networkManager.fetchSearchResult(keyword: word, page: page) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveIn(book: Document){
        let docu = book
        var author = ""
        for auth in docu.authors{
            author += auth
        }
        coredataManager.addCartList(title: docu.title, author: author, price: docu.price){ [weak self] result in
            switch result {
            case true:
                print("추가 됨.")
            case false:
                print("추가 안됨.")
            }
        }
    }
    
    func fetchCartList() -> [[String]] {
        let cart = coredataManager.fetchCart()
        var cartList: [[String]] = []
        for product in cart {
            var tempList: [String] = []
            if let title = product.value(forKey: "title") as? String {
                tempList.append(title)
            }
            if let author = product.value(forKey: "author") as? String {
                tempList.append(author)
            }
            if let price = product.value(forKey: "price") as? Int32 {
                tempList.append(String(price))
            }
            cartList.append(tempList)
        }
        return cartList
    }
    
    func delAllCartList() {
        coredataManager.delAllCartData { [weak self] result in
            switch result {
            case true:
                print("삭제 됨.")
            case false:
                print("삭제 안됨.")
            }
        }
        
    }
    
    
    func addLastSearch(book: Document){
        let title = book.title
        let thumbnail = book.thumbnail
        coredataManager.createLastSearch(title: title, thumbnail: thumbnail) {[weak self] result in
            switch result {
            case true:
                print("last search 추가 됨.")
            case false:
                print("last search 추가 안됨.")
            }
        }
    }
    
    
    func fetchLastSearch() -> [[String:String]] {
        let lastSearch = coredataManager.fetchLastSearch()
        var arr:  [[String:String]] = []
        for product in lastSearch {
            var tempDic: [String:String] = [:]
            if let title = product.value(forKey: "title") as? String {
                tempDic["title"] = title
            }
            if let imageURL = product.value(forKey: "imageURL") as? String {
                tempDic["imageURL"] = imageURL
            }
            arr.append(tempDic)
        }
        return arr
    }
    
    func delAllLastSearch() {
        coredataManager.deleteAllLastSearch { [weak self] result in
            switch result {
            case true:
                print("last Search 삭제 됨.")
            case false:
                print("last Search 삭제 안됨.")
            }
        }
    }
    
    
}
