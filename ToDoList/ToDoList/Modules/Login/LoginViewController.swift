//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: BindingTextField!
    @IBOutlet weak var passwordTextField: BindingTextField!
    @IBOutlet weak var loginButton: BindingButton!
    @IBOutlet weak var registerButton: BindingButton!
    
    //MARK: - Properties
    var viewModel:LoginViewModel
    var router:RouterProtocol!
    
    //MARK: - Init
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        bindViews()
        
#if DEBUG
        viewModel.email.value = "taimur.1989@gmail.com"
        viewModel.password.value = "Password"
        viewModel.performValidation()
#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension LoginViewController {
    func updateUI() {
        logoImageView.roundCorners(radius: 8, borderWidth: 0, borderColor: .accentColor)
        
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.theme = .filled
        loginButton.isEnabled = false
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.theme = .empty
        registerButton.isEnabled = true
    }
    
    func bindViews() {
        emailTextField.bind { [weak self] value in
            self?.viewModel.email.value = value
            self?.viewModel.performValidation()
        }
        passwordTextField.bind { [weak self] value in
            self?.viewModel.password.value = value
            self?.viewModel.performValidation()
        }
        
        loginButton.bind { [weak self] in
            self?.viewModel.performLogin()
        }
        
        registerButton.bind { [weak self] in
            self?.router.routeToRegisteration()
        }
        
        viewModel.email.bind { [weak self] value in
            self?.emailTextField.text = value
        }
        viewModel.password.bind { [weak self] value in
            self?.passwordTextField.text = value
        }
        viewModel.validateFields.bind { [weak self] isValidated in
            self?.loginButton.isEnabled = isValidated
        }
    }
}
