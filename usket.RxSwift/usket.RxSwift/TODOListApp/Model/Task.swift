//
//  Task.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2022/10/19.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
