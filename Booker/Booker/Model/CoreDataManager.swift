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
    
    
    // MARK: - methods
    func fetchLastSearch(completion: @escaping ([NSManagedObject]) -> Void){
        
    }
    
    func createLastSearch(completion: @escaping (Bool) -> Void){
        guard let entity = NSEntityDescription.entity(forEntityName: "LastSearchBook", in: managedContext)
                else { return }
    }
    
    func deleteLastSearch(completion: @escaping (Bool) -> Void){
        
    }
    
    

    
}
