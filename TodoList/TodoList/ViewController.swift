//
//  ViewController.swift
//  TodoList
//
//  Created by 신지연 on 2024/03/20.
//

import UIKit

struct Todo {
    var id: Int
    var title: String
    var isCompleted: Bool
}

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
        todoTableView.delegate = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
