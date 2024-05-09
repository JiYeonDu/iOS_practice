//
//  DetailViewController.swift
//  Booker
//
//  Created by 신지연 on 2024/05/07.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var detailedDocument: Document = Document(title: "", contents: "", url: "", authors: [], publisher: "", price: 0, thumbnail: "")
    private let viewModel = ViewModel()
    
    private let bodyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let contentLayoutGuide = UILayoutGuide()
    
    private lazy var bookImage: UIImageView = {
        let image = UIImageView()
        let url = URL(string: detailedDocument.thumbnail)
        image.kf.setImage(with: url)
        image.clipsToBounds = true
        image.backgroundColor = .systemGray4
        return image
    }()
    
    private lazy var bookTitle: UILabel = {
        let label = UILabel()
        label.text = detailedDocument.title
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorAndPublisher: UILabel = {
        let label = UILabel()
        var txt = ""
        for author in detailedDocument.authors {
            txt.append("\(author) ")
        }
        label.text = txt + "| \(detailedDocument.publisher)"
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var content: UILabel = {
        let label = UILabel()
        label.text = detailedDocument.contents
        label.textColor = .darkGray
        label.textAlignment = .natural
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var price: UILabel = {
        let label = UILabel()
        label.text = "\(detailedDocument.price)원"
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var xBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray4
        button.setTitle("X", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(xBtnDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cartBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(cartBtnDidTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        saveInRecentBook()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissDetailView"), object: nil, userInfo: nil)
    }
    
    func setUI(){
        self.view.backgroundColor = .systemGray6
        
        self.view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(120)
        }
        
        self.footerView.addSubview(xBtn)
        xBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        self.footerView.addSubview(cartBtn)
        cartBtn.snp.makeConstraints { make in
            make.centerY.height.equalTo(xBtn)
            make.leading.equalTo(xBtn.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        
        self.scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        
        self.scrollContentView.addSubview(self.bookTitle)
        bookTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.equalToSuperview().offset(-40)
        }
        
        self.scrollContentView.addSubview(self.authorAndPublisher)
        authorAndPublisher.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bookTitle.snp.bottom).offset(20)
            make.width.equalTo(300)
        }
        
        self.scrollContentView.addSubview(self.bookImage)
        bookImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(authorAndPublisher.snp.bottom).offset(30)
            make.height.equalTo(270)
            make.width.equalTo(180)
        }
        
        self.scrollContentView.addSubview(self.price)
        price.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bookImage.snp.bottom).offset(30)
        }
        
        self.scrollContentView.addSubview(self.content)
        content.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.top.equalTo(price.snp.bottom).offset(30)
            make.width.equalTo(300)
        }
        
    }
    
    //코어데이터 recentbook에 저장
    func saveInRecentBook(){
        viewModel.addLastSearch(book: detailedDocument)
    }
    
    @objc func xBtnDidTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func cartBtnDidTapped(){
        self.dismiss(animated: true)
        viewModel.saveIn(book: detailedDocument)
        
    }
}


