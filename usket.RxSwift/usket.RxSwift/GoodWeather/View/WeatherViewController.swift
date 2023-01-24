//
//  WeatherViewController.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2023/01/24.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let countryTextField = UITextField()
    private let tempLabel = UILabel()
    private let humidityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setUI()
        setConstraint()
    }
    
    private func setConfig() {
        
        countryTextField.borderStyle = .roundedRect
        
        tempLabel.font = UIFont.boldSystemFont(ofSize: 20)
        humidityLabel.font = UIFont.systemFont(ofSize: 17)
        
        tempLabel.textColor = .black
        humidityLabel.textColor = .gray
        
        tempLabel.textAlignment = .center
        humidityLabel.textAlignment = .center
    }
    
    private func setUI() {
        view.addSubview(countryTextField)
        view.addSubview(tempLabel)
        view.addSubview(humidityLabel)
    }
    
    private func setConstraint() {
        countryTextField.snp.makeConstraints { make in
            make.top.equalTo(48)
            make.leading.equalTo(48)
            make.trailing.equalTo(-48)
            make.height.equalTo(48)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(24)
            make.bottom.equalTo(-48)
            make.leading.trailing.equalToSuperview()
        }
    }
    // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid=11e1a77c6c02fb3daff62f196c500616
}
