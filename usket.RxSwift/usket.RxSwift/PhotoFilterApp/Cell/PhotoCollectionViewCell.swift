//
//  PhotoCollectionViewCell.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/09/20.
//

import UIKit
import Photos

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraint() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
}
