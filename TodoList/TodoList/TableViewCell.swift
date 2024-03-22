//
//  TableViewCell.swift
//  TodoList
//
//  Created by 신지연 on 2024/03/22.
//

import UIKit

protocol TableViewCellDelegate {
    func tappedSwitchBtn(for index: Int, like: Bool)
}


class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchLabel: UISwitch!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
