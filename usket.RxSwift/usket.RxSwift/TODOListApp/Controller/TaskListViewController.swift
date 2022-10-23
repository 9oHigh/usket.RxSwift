//
//  TodoListViewController.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/10/18.
//

import UIKit
import RxSwift
import RxRelay

final class TaskListViewController: BaseViewController {
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["All", "Low", "Medium", "High"]
       let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
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
        self.segmentControl.addTarget(self, action: #selector(priorityValueChanged), for: .valueChanged)
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
    func priorityValueChanged(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: segmentControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc
    func addTask() {
        let viewController = AddTaskViewController()
        let rootViewController = UINavigationController(rootViewController: viewController)
        
        viewController.taskSubject.subscribe { item in
            guard let item = item.element else { return }
            let prioriy = Priority(rawValue: self.segmentControl.selectedSegmentIndex - 1)
            
            var existingTasks = self.tasks.value
            existingTasks.append(item)
            self.tasks.accept(existingTasks)
            
            self.filterTasks(by: prioriy)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        .disposed(by: disposeBag)
        
         rootViewController.modalPresentationStyle = .fullScreen
        
        self.present(rootViewController, animated: true)
    }
    
    private func filterTasks(by priority: Priority?) {
        guard let priority = priority else {
            self.filteredTasks = self.tasks.value
            return
        }
        self.tasks.map { task in
            return task.filter { $0.priority == priority }
        }.subscribe(onNext:{ [weak self] task in
            self?.filteredTasks = task
        })
        .disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setTitle(title: filteredTasks[indexPath.row].title)
        
        return cell
    }
}
