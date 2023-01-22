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
        setConfig()
        setUI()
        setConstraint()
        setNavBar()
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
    
    private func setNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(displayP3Red: 47/255, green: 54/255, blue: 64/255, alpha: 1.0)
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.orange]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.orange]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func populateNews() {
    
        
        /*
         기존 코드
         guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-12-22&sortBy=publishedAt&apiKey=f9dc43ce33ae4fe09478fabcab42d82b") else {
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
         */
        
        // 리팩토링 코드
        // 1. ArticleList의 Static property를 이용해 url 사용
        // 2. URLRequest의 Static func로 load 
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                
                if let result = result {
                    
                    self?.articles = result.articles
                    
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
        return self.articles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        let article = self.articles[indexPath.row]
        
        cell.setContent(article: article)
        
        return cell
    }
}
