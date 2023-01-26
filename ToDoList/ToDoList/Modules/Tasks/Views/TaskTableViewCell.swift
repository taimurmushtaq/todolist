//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    //MARK: - Static
    static let identifier = "TaskTableViewCell"

    //MARK: - IBOutlet
    @IBOutlet weak var checkButton: BindingButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
}

//MARK: - Helper Methods
extension TaskTableViewCell {
    func configureCell(withViewModel viewModel: TaskViewModel) {
        checkButton.isSelected = viewModel.isTaskComplete
        titleLabel.text = viewModel.taskTitle
        dateTimeLabel.text = viewModel.taskDateTimeString
    }
}
