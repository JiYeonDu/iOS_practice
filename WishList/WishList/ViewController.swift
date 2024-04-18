//
//  ViewController.swift
//  WishList
//
//  Created by 신지연 on 2024/04/17.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        //빈 관리 객체 생성하고 컨텍스트 객체에 등록
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        //값 설정
        if let entity = entity {
            let product = NSManagedObject(entity: entity, insertInto: context)
            product.setValue("아이폰", forKey: "title")
            product.setValue(123, forKey: "price")
            
            //영구저장소에 커밋
            do {
                try context.save()
                
            } catch {
                context.rollback()
            }
        }
        
        do {
                    let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
                    let products = try context.fetch(fetchRequest)
                    products.forEach {
                        print($0.title ?? "No Title", $0.price)
                    }
                } catch {
                    print("Error fetching data: \(error)")
                }
    
        
        
        
    }


}

