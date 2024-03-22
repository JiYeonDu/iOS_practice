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

class ViewController: UIViewController{
    
    var idForTodo: Int = 3
    public var todoList: [Todo] = [Todo(id: 0, title: "title1", isCompleted: true),
                            Todo(id: 1, title: "title2", isCompleted: true),
                            Todo(id: 2, title: "title3", isCompleted: true)]
    

    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var addTodoBtn: UIButton!
    
    @IBAction func tappedAddTodoBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "alert", message: "입력하시오.", preferredStyle: .alert)
        alert.addTextField()
        
        //취소 버튼 추가
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        //추가 버튼 추가
        let confirm = UIAlertAction(title: "추가", style: .default, handler: { _ in
           if let input = alert.textFields {
                self.todoList.append(Todo(id: self.idForTodo, title: (input.first?.text)!, isCompleted: false))
                self.idForTodo += 1
            }
            self.todoTableView.reloadData()
            
        } )
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func switchDidChange(_ sender: UISwitch) {
        if todoList[sender.tag].isCompleted {
            todoList[sender.tag].isCompleted = false
            self.todoTableView.reloadData()
        } else {
            todoList[sender.tag].isCompleted = true
            self.todoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
        todoTableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TableViewCell
        
        //데이터 셀에 뿌리기
        let todo = todoList[indexPath.row]
        if todo.isCompleted {
            cell.titleLabel.attributedText = todo.title.strikeThrough()
            cell.switchLabel?.setOn(true, animated: true)
        } else {
            cell.titleLabel.attributedText = NSAttributedString(string: todo.title)
            cell.switchLabel?.setOn(false, animated: true)
        }
        cell.switchLabel.tag = indexPath.row
        cell.switchLabel.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        todoList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    func removeStrikethroughText() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}


