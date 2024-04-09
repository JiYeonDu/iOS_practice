//
//  ViewController.swift
//  githubProfile
//
//  Created by 신지연 on 2024/04/04.
//

import UIKit
import Alamofire
import Kingfisher


struct Profile: Codable {
    let login: String
    let followers: Int
    let following: Int
    let public_repos: Int
    let bio: String
    let avatar_url: String
    let repos_url: String
}

struct Repo: Codable {
    let language: String?
    let name: String
    let description: String?
}

class ViewController: UIViewController {

    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var lessBtn: UIButton!
    
    var reposCount: Int = 0
    var page: Int = 1
    
    let refreshControll: UIRefreshControl = UIRefreshControl()
    
    func setUI () {
        imageView.layer.cornerRadius = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(refreshFunction), for: .valueChanged)
        lessBtn.isEnabled = false
        
        callProfileAPI{ countries in
            if let countries = countries {
                print(countries)
                self.idLabel.text = countries.login
                self.bioLabel.text = countries.bio
                self.followersLabel.text = String(countries.followers)
                self.followingLabel.text = String(countries.following)
                self.reposLabel.text = String(countries.public_repos)
                self.reposCount = countries.public_repos
                guard let url = URL(string: countries.avatar_url) else {return}
                self.imageView.kf.setImage(with: url)
            } else {
                print("API 호출 실패")
            }
        }
    }
    
    @objc func refreshFunction(){
        repoTableView.reloadData()
    }
    
    @IBAction func moreBtnTapped(_ sender: UIButton) {
        self.page += 1
        self.repoTableView.reloadData()
        
        if page * 5 > reposCount {
            moreBtn.isEnabled = false
        } else {
            moreBtn.isEnabled = true
        }
    }
    
    @IBAction func lessBtnTapped(_ sender: UIButton) {
        self.page -= 1
        self.repoTableView.reloadData()
        if page < 2 {
            lessBtn.isEnabled = false
        } else {
            lessBtn.isEnabled = true
        }
    }
    
    func callProfileAPI(completion: @escaping (Profile?) -> Void) {
        let url = "https://api.github.com/users/jiyeondu"
        let param = ["auth" : "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"]
        AF.request(url, method: .get, parameters: param).responseDecodable(of: Profile.self){
            (response) in
            switch response.result {
            case .success(let value):
                print(value)
                completion(value)
            case .failure(let error):
                print("ProfileError: \(error)")
            }
        }
    }
    
    func callRepoAPI(completion: @escaping ([Repo?]) -> Void) {
        var url = "https://api.github.com/users/jiyeondu/repos?per_page=5"
        let pageUrl = "&page=\(page)"
        url = url + pageUrl
        let param = ["auth" : "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"]
        AF.request(url, method: .get, parameters: param).responseDecodable(of: [Repo].self){
            (response) in
            switch response.result {
            case .success(let value):
                print(value)
                completion(value)
            case .failure(let error):
                print("RepoError: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repoTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        callRepoAPI{ countries in
            cell.descriptionView.text = countries[indexPath.row]?.description
            cell.nameLabel.text = countries[indexPath.row]?.name
            cell.langView.text = countries[indexPath.row]?.language
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

