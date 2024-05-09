//
//  CartViewController.swift
//  Booker
//
//  Created by 신지연 on 2024/05/07.
//

import UIKit

class CartViewController: UIViewController {
    
    private var cartList: [[String]] = []
    private let viewModel = ViewModel()

    // MARK: - View
    //Top
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    private lazy var intro: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var delBtn: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(delBtnTapped), for: .touchUpInside)
        return button
    }()
    
    //Body
    private lazy var listView: UITableView = {
        let list = UITableView()
        list.backgroundColor = .systemGray5
        list.delegate = self
        list.dataSource = self
        list.register(CartViewCell.self, forCellReuseIdentifier: "CartViewCell")
        return list
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopUI()
        setData()
    }
    
    @objc func didTappedCartView(_ notification: Notification){
        DispatchQueue.main.async {
            self.cartList = self.viewModel.fetchCartList()
            self.listView.reloadData()
        }
    }
    
    @objc func delBtnTapped() {
        let alertController = UIAlertController(title: "카트를 삭제하시겠습니까?", message: "삭제 클릭시 카트목록이 삭제됩니다.", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            viewModel.delAllCartList()
            cartList.removeAll()
            listView.reloadData()
        }
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func setData(){
        cartList = viewModel.fetchCartList()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didTappedCartView(_:)),
            name: NSNotification.Name("DismissDetailView"),
            object: nil
        )
    }
    
    
    func setTopUI(){
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        topView.addSubview(intro)
        intro.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(topView.snp.bottom).offset(-20)
        }
        
        topView.addSubview(delBtn)
        delBtn.snp.makeConstraints { make in
            make.centerY.equalTo(intro.snp.centerY)
            make.leading.equalTo(topView.snp.leading).offset(20)
        }
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }


}

// MARK: - Extension
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as? CartViewCell else { return UITableViewCell() }
        cell.bookTitle.text = cartList[indexPath.row][0]
        cell.author.text = cartList[indexPath.row][1]
        cell.price.text = "\(cartList[indexPath.row][2])원"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
