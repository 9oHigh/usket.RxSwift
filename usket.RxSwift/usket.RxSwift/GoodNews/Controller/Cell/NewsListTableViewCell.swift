//
//  NewsListTableViewCell.swift
//  usket.RxSwift
//
//  Created by Alfred on 2022/11/10.
//

import UIKit

final class NewsListTableViewCell: UITableViewCell {
    
    static let identifier = "NewsListTableViewCell"
    private var article: Article = Article(title: "", description: "")
    private var titleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfig()
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(article: Article) {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
    }
    
    private func setConfig() {
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        
        titleLabel.textColor = .black
        descriptionLabel.textColor = .gray
    }
    
    private func setUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setConstraint() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8).priority(252)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.bottom.equalTo(-8)
        }
    }
}
