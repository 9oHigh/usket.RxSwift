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
        cityNameTextField.returnKeyType = .search
        
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
        /*
         기존코드
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
         */
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { self.cityNameTextField.text }
            .subscribe({ city in

                if let city = city.element {
                    
                    guard let city = city else { return }
                    
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city.lowercased())
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
        
        /*
         기존 코드
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
         */
        
        /*
        // MARK: - bind
         let search = URLRequest.load(resource: resource)
             .observe(on: MainScheduler.instance)
             .catchAndReturn(WeatherResult.empty)
         
         search.map { "\(String(describing: $0?.main.temp)) ℉" }
             .bind(to: self.tempLabel.rx.text)
             .disposed(by: disposeBag)
         
         search.map { "\(String(describing: $0?.main.humidity)) 💦" }
             .bind(to: self.humidityLabel.rx.text)
             .disposed(by: disposeBag)
         */
        
        
        // MARK: - drive
        // bind와 같은 기능이지만 main scheduler에서 사용
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\(String(describing: $0?.main.temp)) ℉" }
            .drive(self.tempLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\(String(describing: $0?.main.humidity)) 💦" }
            .drive(self.humidityLabel.rx.text)
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
