//
//  WishListViewController.swift
//  wishListProj
//
//  Created by 신지연 on 2024/04/18.
//

import UIKit
import CoreData

class WishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var dataList: [NSManagedObject] = []
    
    let refreshControll : UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var wishListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishListTableView.dataSource = self
        wishListTableView.delegate = self
        dataList = fetchData()
        wishListTableView.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(self.refreshFunction), for: .valueChanged)
        
    }
    
    @objc func refreshFunction() {
        wishListTableView.reloadData()
        refreshControll.endRefreshing()
    }
    
    func fetchData() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            let products = try context.fetch(fetchRequest)
            return products
           } catch {
               print("Error fetching data: \(error)")
               return []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = self.dataList[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let total = record.value(forKey: "id") as? Int
        let price = record.value(forKey: "price") as? Int
        
        let cell = wishListTableView.dequeueReusableCell(withIdentifier: "wishListTableViewCell", for: indexPath) as! wishListTableViewCell
        cell.cellTitleLabel.text = title
        cell.cellPriceLabel.text = "$\(price!)"
        cell.cellTotalLabel.text = "[\(total!)]"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishListTableView.beginUpdates()
            
            let object = self.dataList[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(object)
            do {
                try context.save()
               } catch {
                   context.rollback()
            }
            
            self.dataList.remove(at: indexPath.row)
            wishListTableView.deleteRows(at: [indexPath], with: .fade)
            
            wishListTableView.endUpdates()
        }
    }
    
  

}

class wishListTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellPriceLabel: UILabel!
    @IBOutlet weak var cellTotalLabel: UILabel!
}
