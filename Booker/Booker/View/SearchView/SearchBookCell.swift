//
//  SearchBookCell.swift
//  Booker
//
//  Created by 신지연 on 2024/05/07.
//

import UIKit

class SearchBookCell: UICollectionViewCell {
    
    let bookImage: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage.checkmark
        image.clipsToBounds = true
        image.backgroundColor = .systemGray5
        return image
    }()
    
    let bookTitle: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let author: UILabel = {
        let label = UILabel()
        label.text = "작가"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let publisher: UILabel = {
        let label = UILabel()
        label.text = "출판사"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(bookTitle)
        stack.addArrangedSubview(author)
        stack.addArrangedSubview(publisher)
        return stack
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.text = "5000원"
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
        self.bookTitle.text = text
    }
    
    func setUI(){
        self.contentView.addSubview(self.bookImage)
        bookImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(120)
            make.width.equalTo(80)
        }
        self.contentView.addSubview(self.stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.width.equalTo(150)
        }
        self.contentView.addSubview(self.price)
        price.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(stackView.snp.trailing).offset(10)
        }
    }
}
