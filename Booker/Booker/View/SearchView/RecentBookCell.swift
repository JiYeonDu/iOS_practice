//
//  RecentBookCell.swift
//  Booker
//
//  Created by 신지연 on 2024/05/07.
//

import Foundation
import UIKit

class RecentBookCell: UICollectionViewCell {
    
    let bookImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .systemGray5
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: "")
    }
    
    func prepare(text: String) {
        self.label.text = text
    }
    
    func setUI(){
        self.contentView.addSubview(self.bookImage)
        bookImage.snp.makeConstraints { make in
            make.centerX.width.top.equalToSuperview()
            make.height.equalTo(130)
        }
        self.contentView.addSubview(self.label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(bookImage)
            make.top.equalTo(bookImage.snp.bottom).offset(5)
        }
    }
    
}
