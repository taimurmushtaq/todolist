//
//  TasksListViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class TasksListViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.handleAuthState()
        viewModel.fetchTasks()
    }
}

extension TasksListViewController {
    func configureTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .accentColor
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        tableView.allowsSelectionDuringEditing = false
        tableView.refreshControl = refreshControl
        tableView.register(UINib.init(nibName: TaskTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    func configureNavigationItems() {
        let logoutButton = UIBarButtonItem(image: Images.logout,
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutUser))
        
        logoutButton.tintColor = .white
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    func updateUI() {
        title = "To-Do List"
    }
    
    func bindViews() {
        viewModel.successfullySignOut.bind { [weak self] _ in
            self?.router.routToLogin()
        }
        
        viewModel.refreshTasks.bind { [weak self] _ in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
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
    
    @objc func handleRefresh() {
        viewModel.fetchTasks()
    }
}

//MARK: - UITableViewDataSource
extension TasksListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskViewModel = viewModel.item(atIndex: indexPath)!
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        cell.configureCell(withViewModel: taskViewModel)
        cell.checkButton.bind { [weak self] in
            if taskViewModel.isTaskComplete {
                self?.showUndoTaskCompletionAlert { self?.viewModel.changeTaskStatus(indexPath: indexPath) }
            } else {
                self?.showConfirmTaskCompletionAlert { self?.viewModel.changeTaskStatus(indexPath: indexPath) }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.canEditRow(atIndex: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteTaskAlert { [weak self] in self?.viewModel.deleteTask(indexPath: indexPath) }
        }
    }
}

//MARK: - UITableViewDelegate
extension TasksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ToastManager.showMessage("TaskCell Selected")
    }
}

//MARK: - Alerts and sheets
extension TasksListViewController {
    func showLogoutAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "No", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showConfirmTaskCompletionAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: "Complete Task", message: "Are you sure you want to mark this task complete?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "No", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showUndoTaskCompletionAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: "Undo Task Completion", message: "Are you sure you want to mark this task incomplete?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "No", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showDeleteTaskAlert(_ onComplete: @escaping ()-> Void) {
        let alertController = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { action in
            onComplete()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "No", style: .cancel))
        
        present(alertController, animated: true)
    }
}
