//
//  TaskTableViewCell.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/10/18.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "TaskTableViewCell" 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
