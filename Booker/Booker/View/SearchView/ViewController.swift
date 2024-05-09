//
//  ViewController.swift
//  Booker
//
//  Created by 신지연 on 2024/05/02.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var searchResponse: Response?
    private var searchMeta: Meta = Meta(total_count: 0, pageable_count: 0, is_end: true)
    private var searchDocu: [Document] = []
    private var searchKeyword: String = ""
    private var currentPage: Int = 1
    var lastSearch: [[String:String]] = []
    
    // MARK: - View
    //Top
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "책을 검색해보세요"
        search.searchTextField.borderStyle = .none
        search.searchBarStyle = .minimal
        search.searchTextField.autocorrectionType = .no
        search.searchTextField.spellCheckingType = .no
        search.layer.cornerRadius = 25
        search.layer.backgroundColor = UIColor.white.cgColor
        search.delegate = self
        return search
    }()
    
    //Body
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    private lazy var cardView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.isScrollEnabled = true
        view.layer.cornerRadius = 30
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(RecentBookCell.self, forCellWithReuseIdentifier: "RecentBookCell")
        view.register(SearchBookCell.self, forCellWithReuseIdentifier: "SearchBookCell")
        view.register(HeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionIndex {
            case 0:
                let spacing = CGFloat(10)
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(110.0), heightDimension: .absolute(160.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120.0), heightDimension: .absolute(160.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                group.interItemSpacing = .fixed(spacing)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = spacing
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
                
                // header
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60.0))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            default:
                // Item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(160.0)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // header
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
        return layout
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setTopUI()
        setBodyUI()
    }
    
    // MARK: - Function
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.lastSearch = self.viewModel.fetchLastSearch().reversed()
            self.cardView.reloadData()
            //self.setDelButton()
        }
    }
    
    @objc func delBtnDidTapped() {
        viewModel.delAllLastSearch()
        setData()
        self.cardView.reloadData()
    }
    
    func setData(){
        lastSearch = viewModel.fetchLastSearch().reversed()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("DismissDetailView"),
            object: nil
        )
    }
    
    func setTopUI() {
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        topView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerX.equalTo(topView)
            make.bottom.equalTo(topView.snp.bottom).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
        }
    }
    
    func setBodyUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalToSuperview().offset(30)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        
    }

    
    func loadMore() {
        if !searchMeta.is_end {
            currentPage += 1
            viewModel.searchResult(word: searchKeyword, page: currentPage) { result in
                switch result {
                case .success(let res):
                    DispatchQueue.main.async {
                        self.searchResponse = res
                        self.searchDocu += res.documents
                        self.searchMeta = res.meta
                        self.cardView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

// MARK: - Extension
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText ============= \(searchText)")
        searchKeyword = searchText
        viewModel.searchResult(word: searchKeyword, page: currentPage) { result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self.searchResponse = res
                    self.searchDocu = res.documents
                    self.searchMeta = res.meta
                    self.cardView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText ============= \(searchBar.text!)")
        if let searchword = searchBar.text{
            searchKeyword = searchword
            viewModel.searchResult(word: searchKeyword, page: currentPage) { result in
                switch result {
                case .success(let res):
                    DispatchQueue.main.async {
                        self.searchResponse = res
                        self.searchDocu = res.documents
                        self.searchMeta = res.meta
                        self.cardView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchDocu = []
        searchBar.text = ""
    }
    
    func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return lastSearch.count
        default:
            return searchDocu.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBookCell", for: indexPath) as! RecentBookCell
            let item = lastSearch[indexPath.row]
            if let title = item["title"], let url = item["imageURL"]{
                let url = URL(string: url)
                cell.bookImage.kf.setImage(with: url)
                cell.label.text = title
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBookCell", for: indexPath) as! SearchBookCell
            let url = URL(string: searchDocu[indexPath.row].thumbnail)
            cell.bookImage.kf.setImage(with: url)
            cell.bookTitle.text = searchDocu[indexPath.row].title
            var authors = ""
            for author in searchDocu[indexPath.row].authors {
                authors += "\(author) "
            }
            cell.author.text = authors
            cell.publisher.text = searchDocu[indexPath.row].publisher
            cell.price.text = "\(String(searchDocu[indexPath.row].price))원"
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            switch indexPath.section {
            case 0:
                header.prepare(text: "최근 찾아본 책")
                header.addDelBtn()
                header.delBtn.addTarget(self, action: #selector(delBtnDidTapped), for: .touchUpInside)
            default:
                header.prepare(text: "검색결과")
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let selected = lastSearch[indexPath.row]
            self.searchBar.text = selected["title"]
            self.searchBar.reloadInputViews()
            self.searchBar.becomeFirstResponder()
        } else {
            let detailVC = DetailViewController()
            detailVC.detailedDocument = searchDocu[indexPath.row]
            present(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == searchDocu.count - 1{
            loadMore()
        }
    }
}
