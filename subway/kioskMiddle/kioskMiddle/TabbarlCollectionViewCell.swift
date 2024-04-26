//
//  TabbarlCollectionViewCell.swift
//  kioskMiddle
//
//  Created by 신지연 on 2024/04/01.
//

import UIKit

class TabbarlCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tabbarLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                backView.backgroundColor = .lightGray
                tabbarLabel.textColor = .black
            }
            else {
                tabbarLabel.textColor = .gray
                backView.backgroundColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
