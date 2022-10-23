//
//  TaskTableViewCell.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/10/18.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "TaskTableViewCell"
    private let todoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfig()
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfig() {
        todoLabel.textAlignment = .left
    }
    
    private func setUI() {
        addSubview(todoLabel)
    }
    
    private func setConstraint() {
        todoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.greaterThanOrEqualTo(30)
            make.leading.equalTo(16)
        }
    }
    
    func setTitle(title: String) {
        todoLabel.text = title
    }
}
