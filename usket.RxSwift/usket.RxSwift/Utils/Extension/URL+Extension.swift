//
//  URL+Extension.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2023/01/25.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city )&appid=11e1a77c6c02fb3daff62f196c500616")
    }
}
