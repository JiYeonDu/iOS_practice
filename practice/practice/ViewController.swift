//
//  ViewController.swift
//  practice
//
//  Created by 신지연 on 2024/03/20.
//

import UIKit

class ViewController: UIViewController {

    var number: Int = 0
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBAction func decreaseBtnTapped(_ sender: UIButton) {
        number -= 1
        self.countLabel.text = String(number)
    }
    
    @IBAction func increaseBtnTapped(_ sender: UIButton) {
        number += 1
        self.countLabel.text = String(number)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(number)
        // Do any additional setup after loading the view.
    }
    



}

