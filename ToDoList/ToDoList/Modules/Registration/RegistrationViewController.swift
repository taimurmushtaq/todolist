//
//  RegistrationViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var nameTextField: BindingTextField!
    @IBOutlet weak var emailTextField: BindingTextField!
    @IBOutlet weak var passwordTextField: BindingTextField!
    @IBOutlet weak var confirmPasswordTextField: BindingTextField!
    @IBOutlet weak var registerButton: BindingButton!
    
    //MARK: - Properties
    var viewModel:RegisterationViewModel
    
    //MARK: - Init
    init(viewModel: RegisterationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RegistrationViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()
        bindViews()
    }
}

extension RegistrationViewController {
    func updateUI() {
        title = "SIGN UP"
        
        nameTextField.isEnabled = true
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        confirmPasswordTextField.isEnabled = true
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.isEnabled = false
        registerButton.theme = .filled
    }
    
    func bindViews() {
        nameTextField.bind { [weak self] value in
            self?.viewModel.name.value = value
            self?.viewModel.performValidation()
        }
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
            
        }
        
        viewModel.name.bind { [weak self] value in
            self?.nameTextField.text = value
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
    }
}
