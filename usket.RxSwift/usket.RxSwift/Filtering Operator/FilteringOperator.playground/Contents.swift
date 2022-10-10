import UIKit
import RxSwift
import PlaygroundSupport

let strikes1 = PublishSubject<String>()
let strikes2 = PublishSubject<String>()
let disposeBag = DisposeBag()

// MARK: - IgnoreElements
strikes1
    .ignoreElements()
    .subscribe({ _ in
        print("[Subscription is called]")
    })
    .disposed(by: disposeBag)

strikes1.onNext("A")
strikes1.onNext("B")
strikes1.onNext("C")

strikes1.onCompleted()

// MARK: - ElementAt

strikes2.element(at: 2)
    .subscribe(onNext: { _ in
        print("Your Out!")
    })
    .disposed(by: disposeBag)

strikes2.onNext("X")
strikes2.onNext("X")
strikes2.onNext("X")
