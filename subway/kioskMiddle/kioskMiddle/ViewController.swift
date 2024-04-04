//
//  ViewController.swift
//  kioskMiddle
//
//  Created by 최진문 on 2024/04/01.
//

import UIKit

class ViewController: UIViewController {
    
    let menuList: [String] = ["에그마요", "폴드포크", "쉬림프", "이탈리안비엘티", "스파이시이탈리안비엘티", "k바베큐", "스테이크앤치즈"]

    @IBOutlet weak var tabbarTop: UICollectionView!
    
    func setTabbarTop(){
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumLineSpacing = 15
        flowlayout.sectionInset = UIEdgeInsets(top:0, left:0, bottom: 0, right: 0)
        tabbarTop.collectionViewLayout = flowlayout
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarTop.dataSource = self
        tabbarTop.delegate = self
        setTabbarTop()
        
        let advNib = UINib(nibName: "TabbarlCollectionViewCell", bundle: nil)
        tabbarTop.register(advNib, forCellWithReuseIdentifier: "TabbarlCollectionViewCell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabbarlCollectionViewCell", for: indexPath) as? TabbarlCollectionViewCell else{ return UICollectionViewCell()}
        cell.tabbarLabel.text = menuList[indexPath.row]
        cell.tabbarLabel.textColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = menuList[indexPath.row]
        let font = UIFont.systemFont(ofSize: 20)
        let textWidth = text.size(withAttributes: [NSAttributedString.Key.font: font]).width
        let cellWidth = textWidth + 20
        return CGSize(width: cellWidth, height: 60)
    }
    
}
