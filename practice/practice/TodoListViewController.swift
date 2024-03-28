//
//  TodoListViewController.swift
//  practice
//
//  Created by 신지연 on 2024/03/27.
//

import UIKit

struct Todo {
    var id: Int
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
}

class TodoListViewController: UIViewController {
    
    var todoList: [Todo] = []
    var idForTodo: Int = 0

    @IBOutlet weak var todoTable: UITableView!
    
    @IBAction func tappedAddBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Todo 추가하기", message: "할 일을 입력하시오.", preferredStyle: .alert)
        
        //입력필드 추가
        alert.addTextField{ (myTextField) in myTextField.placeholder = "해야할 일을 입력하세요!"}
        
        //취소 버튼 추가
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        //추가 버튼 추가
        let confirm = UIAlertAction(title: "추가", style: .default, handler: { _ in
            if let input = alert.textFields?.first, let inputText = input.text {
                self.todoList.append(Todo(id: self.idForTodo, title: inputText, isCompleted: false))
                self.idForTodo += 1
            }
            self.todoTable.reloadData()
        } )
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedEditBtn(_ sender: UIButton) {
        let shouldBeEdited = !todoTable.isEditing
        todoTable.setEditing(shouldBeEdited, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTable.dataSource = self
        todoTable.delegate = self
        
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTable.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        //데이터 뿌리기
        let todo = todoList[indexPath.row]
        //cell.todoTitle.text = todo.title
        if todo.isCompleted {
            cell.todoTitle.attributedText = todo.title.strikeThrough()
            cell.todoSwitch.setOn(true, animated: true)
        } else {
            cell.todoTitle.attributedText = NSAttributedString(string: todo.title)
            cell.todoSwitch.setOn(false, animated: true)
        }
        
        //switchLabel 액션 전달
        cell.todoSwitch.tag = indexPath.row
        cell.todoSwitch.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)

        return cell
    }
    
    @objc func switchDidChange(_ sender: UISwitch) {
        if todoList[sender.tag].isCompleted {
            todoList[sender.tag].isCompleted = false
            self.todoTable.reloadData()
        } else {
            todoList[sender.tag].isCompleted = true
            self.todoTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
}
