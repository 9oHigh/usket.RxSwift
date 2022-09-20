//
//  MainViewController.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/09/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PhotoFilterViewController: BaseViewController {
    
    private let imageView = UIImageView()
    private let filterButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setUI()
        setConstraint()
    }
    
    private func setConfig() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(toAddPhotoFilterView))
        
        filterButton.setTitle("필터적용", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.backgroundColor = .black
        filterButton.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Camera Filter"
    }
    
    private func setUI() {
        view.addSubview(imageView)
        view.addSubview(filterButton)
    }
    
    private func setConstraint() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        filterButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func toAddPhotoFilterView() {
        let viewController = PhotoCollectionViewController()
        viewController.title = "Filter"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
