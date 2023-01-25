//
//  WeatherViewController.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2023/01/24.
//

import UIKit
import RxCocoa
import RxSwift

final class WeatherViewController: UIViewController {
    
    private let cityNameTextField = UITextField()
    private let tempLabel = UILabel()
    private let humidityLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setNavBar()
        setBind()
        setUI()
        setConstraint()
    }
    
    private func setConfig() {
        
        view.backgroundColor = .white
        
        cityNameTextField.borderStyle = .roundedRect
        
        tempLabel.font = UIFont.boldSystemFont(ofSize: 40)
        humidityLabel.font = UIFont.systemFont(ofSize: 34)
        
        tempLabel.textColor = .black
        humidityLabel.textColor = .gray
        
        tempLabel.textAlignment = .center
        humidityLabel.textAlignment = .center
    }
    
    private func setUI() {
        view.addSubview(cityNameTextField)
        view.addSubview(tempLabel)
        view.addSubview(humidityLabel)
    }
    
    private func setConstraint() {
        cityNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(48)
            make.leading.equalTo(48)
            make.trailing.equalTo(-48)
            make.height.equalTo(48)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(120)
            make.bottom.equalTo(-180)
            make.leading.trailing.equalToSuperview()
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
    
    private func setBind() {
        
        self.cityNameTextField.rx.text
            .subscribe({ city in
                if let city = city.element {
                    if city!.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city!.lowercased())
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchWeather(by city: String) {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else {
            return
        }
        
        let resource = Resource<WeatherResult>(url: url)
        
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
            .subscribe({ [weak self] result in
                
                if let result = result.element, let main = result?.main {
                    DispatchQueue.main.async {
                        self?.displayWeather(main)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        
        if let weather = weather {
            self.tempLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.tempLabel.text = "🐒"
            self.humidityLabel.text = "⍉"
        }
    }
}
