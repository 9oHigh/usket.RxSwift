//
//  AddTaskViewController.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/10/18.
//

import UIKit

final class AddTaskViewController: BaseViewController {
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["Low", "Medium", "High"]
       let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    private let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
        setConfig()
        setUI()
        setConstraint()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setConfig() {
        textField.borderStyle = .roundedRect
    }
    
    private func setUI() {
        view.addSubview(segmentControl)
        view.addSubview(textField)
    }
    
    private func setConstraint() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    @objc
    func saveTask() {
        
    }
}
