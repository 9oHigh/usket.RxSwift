//
//  TodoListViewController.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/10/18.
//

import UIKit

final class TaskListViewController: BaseViewController {
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["All", "Low", "Medium", "High"]
       let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setUI()
        setConstraint()
    }
    
    private func setConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addTask))
    }
    
    private func setUI() {
        view.addSubview(segmentControl)
        view.addSubview(tableView)
    }
    
    private func setConstraint() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc
    func addTask() {
        let viewController = AddTaskViewController()
        let rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController.modalPresentationStyle = .fullScreen
        
        self.present(rootViewController, animated: true)
    }
}
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
