//
//  UIViewController + Extension.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/09/20.
//

import UIKit

extension UIViewController {
    
    func setDefaultNavigationBar() {
        guard let navigationController = navigationController else { return }
        
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController.navigationBar.tintColor = .black
    }
}
