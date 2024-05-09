//
//  CoreDataManager.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    
    // MARK: - properties
    // singleton
    static let shared = CoreDataManager()
    private init() { }
    
    // AppDelegate에 접근하기 위한 프로퍼티
    private var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate is not accessible.")
        }
        return appDelegate
    }
    
    // CoreData의 관리 객체 컨텍스트
    private var managedContext: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: - methods
    func fetchLastSearch() -> [NSManagedObject]{
        do {
            let fetchRequest: NSFetchRequest<LastSearchBook> = LastSearchBook.fetchRequest()
            let products = try managedContext.fetch(fetchRequest)
            return products
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
    
    func createLastSearch(title: String, thumbnail: String, completion: @escaping (Bool) -> Void){
        guard let entity = NSEntityDescription.entity(forEntityName: "LastSearchBook", in: managedContext)
        else { return }
        if let lastSearchBook: LastSearchBook = NSManagedObject(entity: entity, insertInto: managedContext) as? LastSearchBook {
            lastSearchBook.title = title
            lastSearchBook.imageURL = thumbnail
            do {
                try managedContext.save()
                completion(true)
            } catch {
                print("저장안됨")
                completion(false)
            }
        }
    }
    
    func deleteAllLastSearch(completion: @escaping (Bool) -> Void){
        let request = LastSearchBook.fetchRequest()
        
        do {
            let lastSearchBooks = try managedContext.fetch(request)
            
            for lastSearchBook in lastSearchBooks {
                managedContext.delete(lastSearchBook)
            }
            try managedContext.save()
            completion(true)
        } catch {
            print("모든 책 데이터를 삭제할 수 없습니다.")
            completion(false)
        }
    }
    
    func fetchCart()  -> [NSManagedObject]{
        do {
            let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
            let products = try managedContext.fetch(fetchRequest)
            return products
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
    
    func addCartList(title: String, author: String, price: Int, completion: @escaping (Bool) -> Void){
        guard let entity = NSEntityDescription.entity(forEntityName: "Cart", in: managedContext)
        else { return }
        if let cart: Cart = NSManagedObject(entity: entity, insertInto: managedContext) as? Cart {
            cart.author = author
            cart.title = title
            cart.price = Int32(price)
            do {
                try managedContext.save()
                completion(true)
            } catch {
                print("저장안됨")
                completion(false)
            }
        }
    }
    
    func delAllCartData(completion: @escaping (Bool) -> Void) {
        let request = Cart.fetchRequest()
        
        do {
            let carts = try managedContext.fetch(request)
            
            for cart in carts {
                managedContext.delete(cart)
            }
            
            try managedContext.save()
            completion(true)
        } catch {
            print("모든 카트 데이터를 삭제할 수 없습니다.")
            completion(false)
        }

    }
}
