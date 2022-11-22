//
//  GoodNewsViewController.swift
//  usket.RxSwift
//
//  Created by Alfred on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsTableViewController: UIViewController {
    
    private let tableView = UITableView()
    private var articles = [Article]()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setConfig()
        setUI()
        setConstraint()
        populateNews()
    }
    
    private func setConfig() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
    }
    
    private func setUI() {
        view.addSubview(tableView)
    }
    
    private func setConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func populateNews() {
    
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f9dc43ce33ae4fe09478fabcab42d82b") else {
            return
        }
        
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> [Article]? in
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
            }.subscribe( onNext: { [weak self] articles in
                if let articles = articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            })
            .disposed(by: disposeBag)
                
    }
}
extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
