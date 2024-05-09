//
//  ViewController.swift
//  kakaoLogin
//
//  Created by 신지연 on 2024/05/03.
//

import UIKit
import KakaoSDKUser


class ViewController: UIViewController {
    
    private let loginWithKakaoTalkBtn: UIButton = {
        let button = UIButton()
        button.setImage(.kakao, for: .normal)
        button.addTarget(self, action: #selector(loginWithKakaoTalkBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let loginWithKakaoAccountBtn: UIButton = {
        let button = UIButton()
        button.setImage(.kakao, for: .normal)
        button.addTarget(self, action: #selector(loginWithKakaoAccountBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let userImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private let userName: UILabel = {
        let image = UILabel()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginWithKakaoTalkBtn)
        view.addSubview(loginWithKakaoAccountBtn)
        view.addSubview(userImage)
        view.addSubview(userName)
        loginWithKakaoTalkBtn.translatesAutoresizingMaskIntoConstraints = false
        loginWithKakaoAccountBtn.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginWithKakaoTalkBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithKakaoTalkBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            loginWithKakaoTalkBtn.widthAnchor.constraint(equalToConstant: 183),
            loginWithKakaoTalkBtn.heightAnchor.constraint(equalToConstant: 45)
        ])
        NSLayoutConstraint.activate([
            loginWithKakaoAccountBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithKakaoAccountBtn.topAnchor.constraint(equalTo: loginWithKakaoTalkBtn.bottomAnchor, constant: 200),
            loginWithKakaoAccountBtn.widthAnchor.constraint(equalToConstant: 183),
            loginWithKakaoAccountBtn.heightAnchor.constraint(equalToConstant: 45)
        ])
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.topAnchor.constraint(equalTo: loginWithKakaoAccountBtn.bottomAnchor, constant: 100),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            userName.widthAnchor.constraint(equalToConstant: 50),
            userName.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    func loginWithKakaoTalkBtnTapped() {
        print("loginKakao() called.")
        //카카오톡 설치여부확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카카오톡 로그인.
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
     
                    let accessToken = oauthToken?.accessToken
                    
                }
            }
        }
        else {
            print("카카오톡 미설치")
        }
    }
    
    @objc
    func loginWithKakaoAccountBtnTapped() {
        //웹 브라우저를 통한 카카오 계정으로 로그인
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
        }
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("error1")
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // oauthToken 저장가능하다
                    // _ = oauthToken
                    self.setUserInfo()
                }
            }
        }
    }
    
    private func setUserInfo() {
          UserApi.shared.me() {(user, error) in
              if let error = error {
                  print("error2")
                  print(error)
              }
              else {
                  print("me() success.")
                  //do something
                  _ = user
                  self.userName.text = user?.kakaoAccount?.profile?.nickname
                  
                  if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                      let data = try? Data(contentsOf: url) {
                      self.userImage.image = UIImage(data: data)
                  }
              }
          }
      }
    
    
}

