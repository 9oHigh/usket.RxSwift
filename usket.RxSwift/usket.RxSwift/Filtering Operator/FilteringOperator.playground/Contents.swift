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

// MARK: - Filter

Observable.of(1,2,3,4,5,6,7,8,9)
    .filter { $0 % 2 == 0 }
    .subscribe({ number in
        print("number", number)
    })
    .disposed(by: disposeBag)


// MARK: - Skip

Observable.of("A", "B", "C", "D", "E", "F")
    .skip(2)
    .subscribe({ item in
        print("item", item)
    })
    .disposed(by: disposeBag)

// MARK: - skip while

Observable.of(2,2,3,4,4)
    .skip { $0 % 2 == 0 }
    .subscribe({ item in
        print("skipWhile item", item)
    })
    .disposed(by: disposeBag)


// MARK: - skip until

let skipUntilSubject = PublishSubject<String>()
let trigger = PublishSubject<String>()

skipUntilSubject.skip(until: trigger)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

skipUntilSubject.onNext("A")
skipUntilSubject.onNext("B")
trigger.onNext("X")
skipUntilSubject.onNext("C")


// MARK: - take

Observable.of(1,2,3,4,5)
    .take(3)
    .subscribe({ item in
        print("take Item", item)
    })
    .disposed(by: disposeBag)


// MARK: - take while

Observable<Int>.of(2,4,5,6,7) // 타입명시 확실하게
    .take(while: { $0 % 2 == 0 })
    .subscribe({ item in
        print("take while Item", item)
    })
    .disposed(by: disposeBag)

// MARK: - take until

let takeUntilSubject = PublishSubject<String>()

takeUntilSubject
    .take(until: trigger)
    .subscribe({ item in
        print("take until Item", item)
    })
    .disposed(by: disposeBag)

takeUntilSubject.onNext("A")
takeUntilSubject.onNext("B")
trigger.onNext("X")
takeUntilSubject.onNext("C")

    
