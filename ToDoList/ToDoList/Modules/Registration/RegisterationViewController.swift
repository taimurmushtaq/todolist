//
//  RegisterationViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class RegisterationViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: BindingTextField!
    @IBOutlet weak var passwordTextField: BindingTextField!
    @IBOutlet weak var confirmPasswordTextField: BindingTextField!
    @IBOutlet weak var registerButton: BindingButton!
    
    //MARK: - Properties
    var viewModel:RegisterationViewModel
    var router: RouterProtocol!
    
    //MARK: - Init
    init(viewModel: RegisterationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RegisterationViewController", bundle: .main)
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
        viewModel.confirmPassword.value = "Password"
        viewModel.performValidation()
#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension RegisterationViewController {
    func updateUI() {
        title = "SIGN UP"
        
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        confirmPasswordTextField.isEnabled = true
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.isEnabled = false
        registerButton.theme = .filled
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
        confirmPasswordTextField.bind { [weak self] value in
            self?.viewModel.confirmPassword.value = value
            self?.viewModel.performValidation()
        }
        
        registerButton.bind { [weak self] in
            self?.viewModel.performRegisteration()
        }
        
        viewModel.email.bind { [weak self] value in
            self?.emailTextField.text = value
        }
        viewModel.password.bind { [weak self] value in
            self?.passwordTextField.text = value
        }
        viewModel.confirmPassword.bind { [weak self] value in
            self?.confirmPasswordTextField.text = value
        }
        viewModel.validateFields.bind { [weak self] isValidated in
            self?.registerButton.isEnabled = isValidated
        }
        
        viewModel.successfullyRegistered.bind { [weak self] _ in
            self?.router.routToTasks()
        }
    }
}
