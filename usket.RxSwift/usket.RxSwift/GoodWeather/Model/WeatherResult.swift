//
//  WeatherResult.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2023/01/24.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let huminity: Double
}
