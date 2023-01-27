//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class LoginViewController: BaseViewController {
    
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
        
        //#if DEBUG
        //        viewModel.email.value = "taimur.1989@gmail.com"
        //        viewModel.password.value = "Password"
        //        viewModel.performValidation()
        //#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension LoginViewController {
    func updateUI() {
        logoImageView.roundCorners(radius: 8, borderWidth: 0, borderColor: .accentColor)
        
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        
        loginButton.setTitle(AppStrings.buttonTitles.login.rawValue, for: .normal)
        loginButton.theme = .filled
        loginButton.isEnabled = false
        loginButton.enableTheme = true
        
        registerButton.setTitle(AppStrings.buttonTitles.register.rawValue, for: .normal)
        registerButton.theme = .empty
        registerButton.isEnabled = true
        registerButton.enableTheme = true
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
            guard let strongSelf = self else { return }
            
            AppLoader.instance.show(inView: strongSelf.view)
            strongSelf.viewModel.performLogin()
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
        
        viewModel.signInSuccessFul.bind { [weak self] _ in
            AppLoader.instance.hide()
            self?.router.routToTasks()
        }
        viewModel.signInFailed.bind { message in
            AppLoader.instance.hide()
            ToastManager.showMessage(message)
        }
    }
}
