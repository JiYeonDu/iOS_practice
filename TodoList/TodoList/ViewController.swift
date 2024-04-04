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
    var memo: String
    var isExpended: Bool
}

class ViewController: UIViewController{
    
    var idForTodo: Int = 3
    var expandedIndexPath: IndexPath?
    public var todoList: [Todo] = [Todo(id: 0, title: "title1", isCompleted: true, memo: "hello", isExpended: false),
                            Todo(id: 1, title: "title2", isCompleted: true, memo: "hello", isExpended: false),
                            Todo(id: 2, title: "title3", isCompleted: true, memo: "The sun dipped below the horizon, painting the sky in hues of orange and pink. A gentle breeze rustled through the trees, carrying the scent of blooming flowers. Birds chirped their evening song as they returned to their nests. In the distance, the silhouette of mountains stood against the fading light. As twilight descended, the world seemed to hold its breath in anticipation of the night.", isExpended: false)]
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var addTodoBtn: UIButton!
    
    @IBAction func tappedAddTodoBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "alert", message: "입력하시오.", preferredStyle: .alert)
        
        //입력필드 추가
        alert.addTextField{ (myTextField) in         myTextField.placeholder = "해야할 일을 입력하세요!"
        }
        
        //입력필드 추가
        alert.addTextField{ (myTextField) in         myTextField.placeholder = "세부사항을 입력하세요!"
        }
        
        //취소 버튼 추가
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        //추가 버튼 추가
        let confirm = UIAlertAction(title: "추가", style: .default, handler: { _ in
            if let input = alert.textFields?.first, let inputText = input.text {
                var memoText: String?
                if let memo = alert.textFields?[1] {
                    memoText = memo.text
                }
                self.todoList.append(Todo(id: self.idForTodo, title: inputText, isCompleted: false, memo: memoText ?? "", isExpended: false))
                self.idForTodo += 1
            }
            self.todoTableView.reloadData()
            
        } )
        alert.addAction(confirm)
        
        //
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
        
        //print(indexPath.row)
        //데이터 셀에 뿌리기
        let todo = todoList[indexPath.row]
        if todo.isCompleted {
            cell.titleLabel.attributedText = todo.title.strikeThrough()
        } else {
            cell.titleLabel.attributedText = NSAttributedString(string: todo.title)
        }
        cell.switchLabel.isOn = todo.isCompleted
        cell.switchLabel.tag = indexPath.row
        cell.switchLabel.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        cell.memoLabel.text = todo.memo
        print(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let expandedIndexPath = expandedIndexPath, expandedIndexPath == indexPath {
            return UITableView.automaticDimension
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if todoList[indexPath.row].memo.count > 20 {
            if expandedIndexPath == indexPath {
                expandedIndexPath = nil
            } else {
                expandedIndexPath = indexPath
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
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
}


