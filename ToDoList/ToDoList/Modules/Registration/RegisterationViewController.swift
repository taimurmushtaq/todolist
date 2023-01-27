//
//  RegisterationViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class RegisterationViewController: BaseViewController {
    
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
        title = AppStrings.controllerTitles.signup.rawValue
        
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        confirmPasswordTextField.isEnabled = true
        
        registerButton.setTitle(AppStrings.buttonTitles.register.rawValue, for: .normal)
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
            guard let strongSelf = self else { return }
            
            AppLoader.instance.show(inView: strongSelf.view)
            strongSelf.viewModel.performRegisteration()
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
        
        viewModel.registrationSuccessful.bind { [weak self] _ in
            AppLoader.instance.hide()
            self?.router.routToTasks()
        }
        
        viewModel.registrationFailed.bind { message in
            AppLoader.instance.hide()
            ToastManager.showMessage(message)
        }
    }
}
