//
//  TodoTableViewCell.swift
//  practice
//
//  Created by 신지연 on 2024/03/27.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
