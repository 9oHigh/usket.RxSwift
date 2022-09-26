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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setUI()
        setConstraint()
        bind()
    }
    
    private func setConfig() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(toAddPhotoFilterView))
        
        filterButton.setTitle("필터적용", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.backgroundColor = .black
        filterButton.layer.cornerRadius = 5
        filterButton.isHidden = true
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
    
    private func bind() {
        
        filterButton.rx.tap.subscribe({ _ in
            guard let sourceImage = self.imageView.image else {
                return
            }
            /* 기존 코드
             FilterService().applyFilter(to: sourceImage) { filteredImage in
                 DispatchQueue.main.async {
                     self.imageView.image = filteredImage
                 }
             }
             */
            FilterService().applyFIlter(to: sourceImage)
                .subscribe(onNext: {[weak self] filteredImage in
                    DispatchQueue.main.async {
                        self?.imageView.image = filteredImage
                    }
                })
                .disposed(by: self.disposeBag)
        })
        .disposed(by: disposeBag)
    }
    
    @objc
    private func toAddPhotoFilterView() {
        let viewController = PhotoCollectionViewController()
        viewController.title = "Filter"
        viewController.seletedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        })
        .disposed(by: disposeBag)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func updateUI(with image: UIImage) {
        self.imageView.image = image
        self.filterButton.isHidden = false
    }
}
