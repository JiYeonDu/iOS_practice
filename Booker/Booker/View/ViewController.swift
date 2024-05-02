//
//  ViewController.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    

    //Top
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "책을 검색해보세요"
        search.searchTextField.borderStyle = .none
        search.searchBarStyle = .minimal
        search.layer.cornerRadius = 25
        search.layer.backgroundColor = UIColor.white.cgColor
        search.delegate = self
        return search
    }()
    
    //Body
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    private lazy var cardView: UICollectionView = {
       let collection = UICollectionView()
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    
    // MARK : - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopUI()
        setBodyUI()
    }
    
    func setTopUI() {
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(topView)
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    func setBodyUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }


}

extension ViewController: UISearchBarDelegate {
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
    
}
