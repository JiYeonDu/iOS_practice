//
//  ViewController.swift
//  pickerView
//
//  Created by 신지연 on 2024/04/03.
//

import UIKit

class ViewController: UIViewController {
    
    let example: [String] = ["one", "two", "three", "four", "five", "six"]
    let example2: [String] = ["1", "2", "3", "4", "5"]
    
    var picker: UIPickerView = {
        let view = UIPickerView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(picker)
        
        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 피커뷰의 휠의 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
        //return 2
    }
    
    // 피커뷰에 나타나는 목록의 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return example.count
        
//        if component == 0 {    //  첫번째휠
//            return example.count
//        } else {               //  두번째휠
//            return example2.count
//        }
         
    }
    
    // 피커뷰의 목록들에 정보 뿌리기
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return example[row]
        
//        if component == 0 {    //  첫번째휠
//            return example[row]
//        } else {               //  두번째휠
//            return example2[row]
//        }
         
    }
    
    // 사용자가 선택한 피커 목록의 index를 row로 반환
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("현재 \(example[row])를 선택.")
    }
}

