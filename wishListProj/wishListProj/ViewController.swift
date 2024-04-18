//
//  ViewController.swift
//  wishListProj
//
//  Created by 신지연 on 2024/04/18.
//

import UIKit
import CoreData


struct RemoteProduct: Decodable {
    let id: Int16
    let title: String
    let description: String
    let price: Int16
    let thumbnail: String
}

class ViewController: UIViewController {
    
    var productID = 1
    
    var productNow: RemoteProduct!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var descriptView: UILabel!
    
    @IBOutlet weak var putCartBtn: UIButton!
    
    @IBOutlet weak var nextProdBtn: UIButton!
    
    @IBOutlet weak var showCartBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setUI()
        
    }
    
    @IBAction func putCartBtnTapped(_ sender: UIButton) {
        //앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        //관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext

        //빈 관리 객체 생성하고 컨텍스트 객체에 등록
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)

        if let entity = entity {
           let product = NSManagedObject(entity: entity, insertInto: context)
           //값 설정
            product.setValue(productNow!.title, forKey: "title")
            product.setValue(productNow!.price, forKey: "price")
            product.setValue(productNow!.id, forKey: "id")
           
           //영구저장소에 커밋
            do {
                try context.save()
            } catch {
                context.rollback()
            }
            
            do {
                let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
                let products = try context.fetch(fetchRequest)
                    products.forEach {
                        print($0.title, $0.price, $0.id)
                    }
               } catch {
                       print("Error fetching data: \(error)")
                }
        }
    }
    
    @IBAction func nextProdBtnTapped(_ sender: UIButton) {
        productID = (productID + 1) % 100
        fetchData()
    }
    
    func setUI(){
        putCartBtn.layer.cornerRadius = 10
        nextProdBtn.layer.cornerRadius = 10
        showCartBtn.layer.cornerRadius = 10
    }
    
    func fetchData() {
        let session = URLSession.shared
        if let url = URL(string: "https://dummyjson.com/products/\(productID)"){
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let product = try JSONDecoder().decode(RemoteProduct.self, from: data)
                        self.productNow = product
                        
                        DispatchQueue.main.async {
                            self.titleView.text = product.title
                            self.priceView.text = String(product.price)
                            self.descriptView.text = product.description
                            if let imageURL = URL(string: product.thumbnail) {
                                URLSession.shared.dataTask(with: imageURL){ (imageData, _, _) in
                                    if let imageData = imageData {
                                        // 이미지 데이터를 UIImage로 변환하여 UIImageView에 설정
                                        DispatchQueue.main.async {
                                            self.imageView.image = UIImage(data: imageData)
                                        }
                                        
                                    }
                                }.resume()
                            }
                        }
                    } catch {
                        print("decode error: \(error)")
                    }
                }
            }
            task.resume()
        }
    }


}

