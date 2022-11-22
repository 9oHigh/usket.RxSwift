//
//  NewsListTableViewCell.swift
//  usket.RxSwift
//
//  Created by Alfred on 2022/11/10.
//

import UIKit

final class NewsListTableViewCell: UITableViewCell {
    
    static let identifier = "NewsListTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
