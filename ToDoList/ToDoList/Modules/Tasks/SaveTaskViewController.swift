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
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.timeZone = TimeZone.current
        picker.locale = Locale.current
        picker.minimumDate = Date()
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.sizeToFit()
        return picker
    }()
    
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
        title = viewModel.isEditing ? AppStrings.controllerTitles.updateTask.rawValue : AppStrings.controllerTitles.addTask.rawValue
        
        titleTextField.isEnabled = true
        dateTimeTextField.isEnabled = true
        
        saveButton.setTitle(viewModel.isEditing ? AppStrings.buttonTitles.update.rawValue : AppStrings.buttonTitles.add.rawValue, for: .normal)
        saveButton.enableTheme = true
        saveButton.isEnabled = false
        saveButton.theme = .filled
        
        dateTimeTextField.inputView = datePicker
    }
    
    func bindViews() {
        titleTextField.bind { [weak self] value in
            self?.viewModel.title.value = value
            self?.viewModel.performValidation()
        }
        
        dateTimeTextField.bindEndEditing { [weak self] in
            guard let strongSelf = self else { return }
            
            let date = strongSelf.datePicker.date
            let dateString = date.convertToString(withFormat: DateFormats.taskTimerFormat.rawValue)
            
            strongSelf.dateTimeTextField.text = dateString
            strongSelf.viewModel.dateTime.value = date.timeIntervalSince1970
            strongSelf.viewModel.performValidation()
        }
        
        saveButton.bind { [weak self] in
            guard let strongSelf = self else { return }
            
            AppLoader.instance.show(inView: strongSelf.view)
            strongSelf.viewModel.saveTask()
        }
        
        viewModel.title.bind { [weak self] value in
            self?.titleTextField.text = value
        }
        viewModel.dateTime.bind { [weak self] value in
            self?.dateTimeTextField.text = Date(timeIntervalSince1970: value).convertToString(withFormat: DateFormats.taskTimerFormat.rawValue)
        }
        viewModel.validateFields.bind { [weak self] isValidated in
            self?.saveButton.isEnabled = isValidated
        }
        viewModel.taskUpdated.bind { [weak self] _ in
            AppLoader.instance.hide()
            self?.router.goBack()
        }
        viewModel.taskUpdateFailed.bind { errorMessage in
            AppLoader.instance.hide()
            ToastManager.showMessage(errorMessage)
        }
    }
}
