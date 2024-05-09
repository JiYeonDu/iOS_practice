//
//  CartViewCell.swift
//  Booker
//
//  Created by 신지연 on 2024/05/07.
//

import UIKit

class CartViewCell: UITableViewCell {
    
    var bookTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var author: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var price: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.backgroundColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUI()
        // Configure the view for the selected state
    }
    
    func setUI(){
        
        self.contentView.addSubview(price)
        price.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
        }
        
        self.contentView.addSubview(author)
        author.snp.makeConstraints { make in
            make.trailing.equalTo(price.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        
        self.contentView.addSubview(bookTitle)
        bookTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(author.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
        }
        
    }

}
