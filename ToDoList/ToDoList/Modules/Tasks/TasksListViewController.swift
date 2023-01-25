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
        updateUI()
        bindViews()
    }
}

extension TasksListViewController {
    func configureNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.logout,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logoutUser))
    }
    
    func updateUI() {
        title = "To-Do List"
    }
    
    func bindViews() {
        viewModel.successfullySignOut.bind { [weak self] _ in
            self?.router.routToLogin()
        }
    }
}

extension TasksListViewController {
    @objc func logoutUser() {
        viewModel.performLogut()
    }
}
