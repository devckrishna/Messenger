//
//  LoginViewController.swift
//  Messenger
//
//  Created by Dev C Krishna on 07/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    private let scrollView: UIScrollView  = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailFeild: UITextField = {
        let feild = UITextField()
        feild.autocorrectionType = .no
        feild.autocorrectionType = .no
        feild.returnKeyType = .continue
        feild.layer.cornerRadius = 12
        feild.layer.borderWidth = 1
        feild.layer.borderColor = UIColor.lightGray.cgColor
        feild.placeholder = "Email Address"
        feild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        feild.backgroundColor = .secondarySystemBackground
        feild.leftViewMode = .always
        return feild
    }()
    
    private let passwoordFeild: UITextField = {
        let feild = UITextField()
        feild.autocorrectionType = .no
        feild.autocorrectionType = .no
        feild.returnKeyType = .done
        feild.layer.cornerRadius = 12
        feild.layer.borderWidth = 1
        feild.layer.borderColor = UIColor.lightGray.cgColor
        feild.placeholder = "Password"
        feild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        feild.backgroundColor = .secondarySystemBackground
        feild.leftViewMode = .always
        feild.isSecureTextEntry = true
        return feild
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside )
        
        emailFeild.delegate = self
        passwoordFeild.delegate = self
        // add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailFeild)
        scrollView.addSubview(passwoordFeild)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 2
        imageView.frame =  CGRect(x: (scrollView .width - size) / 2 ,
                                  y: 20,
                                  width: size,
                                  height: size)
        emailFeild.frame =  CGRect(x: 30,
                                   y: imageView.bottom + 10,
                                   width: scrollView.width - 30,
                                   height: 52)
        passwoordFeild.frame =  CGRect(x: 30,
                                       y: emailFeild.bottom + 10,
                                       width: scrollView.width - 30,
                                       height: 52)
        loginButton.frame = CGRect(x: 30,
                                   y: passwoordFeild.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
    }
    
    
    @objc private func loginButtonTapped() {
        emailFeild.resignFirstResponder()
        passwoordFeild.resignFirstResponder()
        guard let email = emailFeild.text, let password = passwoordFeild.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        // firebase login
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to log in.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title = "Create Account "
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        if textField == emailFeild {
            passwoordFeild.becomeFirstResponder()
        }else if textField == passwoordFeild{
            loginButtonTapped()
        }
        return true
    }
}
