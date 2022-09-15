import UIKit
import RxSwift

// MARK: - Observable

// 단일 요소를 포함하는 관찰가능한 시퀀스
let observable = Observable.just(1)

// 여러 수의 요소
let observable2 = Observable.of(1,2,3)

// 여러개의 요소
let observable3 = Observable.of([1,2,3])

// 배열을 관찰가능한 시퀀스로 변환
let observable4 = Observable.from([1,2,3,4,5])

// MARK: - Subscribe

// Subscribe
observable4.subscribe { event in
    if let element = event.element {
        print(element)
    }
}

observable3.subscribe { event in
    if let element = event.element {
        print(element)
    }
}

// MARK: -  Dispose

// Type 1
let subscription4 = observable4.subscribe (onNext: { element in
    print(element)
})
subscription4.dispose()


// Type 2
let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe {
     print($0)
    }
    .disposed(by: disposeBag)

// MARK: - Create

Observable<String>.create { observable in
    observable.onNext("A")
    observable.onCompleted()
    observable.onNext("?")
    return Disposables.create()
}.subscribe {
    print("Answer:",$0)
} onError: {
    print($0)
} onCompleted: {
    print("Completed")
} onDisposed: {
    print("Disposed")
}
