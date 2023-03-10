//
//  TasksListViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class TasksListViewController: BaseViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: BindingButton!
    
    //MARK: - Properties
    var viewModel:TasksListViewModel
    var router:RouterProtocol!
    
    //MARK: - Init
    init(viewModel: TasksListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "TasksListViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        configureTableView()
        updateUI()
        bindViews()
        
        viewModel.handleAuthState()
        viewModel.observeTasks()
    }
}

extension TasksListViewController {
    func configureTableView() {
        tableView.accessibilityIdentifier = "taskListTableView"
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 128, right: 0)
        tableView.allowsSelectionDuringEditing = false
        tableView.register(UINib.init(nibName: TaskTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    func configureNavigationItems() {
        let logoutButton = UIBarButtonItem(image: Images.logout,
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutUser))
        logoutButton.accessibilityIdentifier = "logoutButton"
        
        logoutButton.tintColor = .white
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    func updateUI() {
        title = AppStrings.controllerTitles.toDoList.rawValue
        
        addTaskButton.setTitle(AppStrings.buttonTitles.addTask.rawValue, for: .normal)
        addTaskButton.enableTheme = true
        addTaskButton.isEnabled = true
        addTaskButton.theme = .filled
        addTaskButton.addShadow()
    }
    
    func bindViews() {
        addTaskButton.bind { [weak self] in
            self?.router.routToSaveTasks(nil)
        }
        
        viewModel.successfullySignOut.bind { [weak self] _ in
            self?.router.routToLogin()
        }
        
        viewModel.refreshTasks.bind { [weak self] message in
            if !message.isEmpty {
                ToastManager.showMessage(message)
            }
            self?.tableView.reloadData()
        }
        
        viewModel.taskUpdate.bind { [weak self] value in
            AppLoader.instance.hide()
            
            if value.isEmpty {
                self?.tableView.reloadData()
            } else {
                ToastManager.showMessage(value)
            }
        }
    }
}

//MARK: - Selectros
extension TasksListViewController {
    @objc func logoutUser() {
        showLogoutAlert { [weak self] in
            self?.viewModel.performLogut()
        }
    }
}

//MARK: - UITableViewDataSource
extension TasksListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = viewModel.numberOfRows(inSection: section)
        
        if numberOfRows == 0 {
            tableView.setEmptyMessage(AppStrings.labelText.noTaskFound.rawValue)
        } else {
            tableView.restore()
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskViewModel = viewModel.item(atIndex: indexPath)!
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        cell.accessibilityIdentifier = "\(TaskTableViewCell.identifier)_\(indexPath.section)_\(indexPath.row)"
        cell.configureCell(withViewModel: taskViewModel)
        cell.checkButton.bind { [weak self] in
            if taskViewModel.isTaskComplete {
                self?.showUndoTaskCompletionAlert {
                    guard let strongSelf = self else { return }
                    
                    AppLoader.instance.show(inView: strongSelf.view)
                    strongSelf.viewModel.changeTaskStatus(indexPath: indexPath)
                }
            } else {
                self?.showConfirmTaskCompletionAlert {
                    guard let strongSelf = self else { return }
                    
                    AppLoader.instance.show(inView: strongSelf.view)
                    self?.viewModel.changeTaskStatus(indexPath: indexPath)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.canEditRow(atIndex: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteTaskAlert { [weak self] in
                guard let strongSelf = self else { return }
                
                AppLoader.instance.show(inView: strongSelf.view)
                self?.viewModel.deleteTask(indexPath: indexPath)
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension TasksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = viewModel.item(atIndex: indexPath) {
            router.routToSaveTasks(task)
        }
    }
}

//MARK: - Alerts and sheets
extension TasksListViewController {
    func showLogoutAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: AppStrings.alertTitle.logout.rawValue,
                                                message: AppStrings.alertMessages.logoutConfirmation.rawValue, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.yes.rawValue, style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.no.rawValue, style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showConfirmTaskCompletionAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: AppStrings.alertTitle.completeTask.rawValue,
                                                message: AppStrings.alertMessages.taskCompletionConfirmation.rawValue, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.yes.rawValue, style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.no.rawValue, style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showUndoTaskCompletionAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: AppStrings.alertTitle.unDoTaskCompletion.rawValue,
                                                message: AppStrings.alertMessages.undoTaskCompletionConfirmation.rawValue, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.yes.rawValue, style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.no.rawValue, style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showDeleteTaskAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: AppStrings.alertTitle.deleteTask.rawValue,
                                                message: AppStrings.alertMessages.taskDeletionConfirmation.rawValue, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.yes.rawValue, style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: AppStrings.buttonTitles.no.rawValue, style: .cancel))
        
        present(alertController, animated: true)
    }
}
