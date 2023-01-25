//
//  SaveTaskViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class SaveTaskViewController: BaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var titleTextField: BindingTextField!
    @IBOutlet weak var dateTimeTextField: BindingTextField!
    @IBOutlet weak var saveButton: BindingButton!
    
    //MARK: - Properties
    var viewModel:SaveTaskViewModel
    var router: RouterProtocol!
    
    //MARK: - Init
    init(viewModel: SaveTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SaveTaskViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        bindViews()
        
        viewModel.updateFields()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SaveTaskViewController {
    func updateUI() {
        title = viewModel.isEditing ? "Update Task" : "Add Task"
        
        titleTextField.isEnabled = true
        dateTimeTextField.isEnabled = true
        
        saveButton.setTitle(viewModel.isEditing ? "Update" : "Add", for: .normal)
        saveButton.enableTheme = true
        saveButton.isEnabled = false
        saveButton.theme = .filled
    }
    
    func bindViews() {
        titleTextField.bind { [weak self] value in
            self?.viewModel.title.value = value
            self?.viewModel.performValidation()
        }
        dateTimeTextField.bind { [weak self] value in
            self?.viewModel.dateTime.value = value
            self?.viewModel.performValidation()
        }
        
        saveButton.bind { [weak self] in
            self?.viewModel.saveTask()
        }
        
        viewModel.title.bind { [weak self] value in
            self?.titleTextField.text = value
        }
        viewModel.dateTime.bind { [weak self] value in
            self?.dateTimeTextField.text = value
        }
        viewModel.validateFields.bind { [weak self] isValidated in
            self?.saveButton.isEnabled = isValidated
        }
        viewModel.successfullySaved.bind { [weak self] _ in
            self?.router.goBack()
        }
    }
}
