import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: - PublishSubject

let publishSubject = PublishSubject<String>()

publishSubject.onNext("Issue 1")

publishSubject.subscribe { event in
    print(event)
}

publishSubject.onNext("Issue 2")
publishSubject.onNext("Issue 3")
publishSubject.onCompleted()
publishSubject.onNext("Issue 4") // 출력되지 않음!

// MARK: - BehaviorSubject

let behaviorSubject = BehaviorSubject(value: "Initial Value")

behaviorSubject.onNext("Last Issue")

behaviorSubject.subscribe { event in
    print(event)
}

behaviorSubject.onNext("Issue 1")


// MARK: - Replay Subject

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("Issue 1")
replaySubject.onNext("Issue 2")
replaySubject.onNext("Issue 3")

print("[Subscription 1]")
replaySubject.subscribe {
    print($0)
}

replaySubject.onNext("Issue 4")
replaySubject.onNext("Issue 5")
replaySubject.onNext("Issue 6")

print("[Subscription 2]")
replaySubject.subscribe {
    print($0)
}

// MARK: - Behavior Relay, RxCocoa

let behaviorRelay1 = BehaviorRelay(value: "behaviorRelay1 Initial Value")


behaviorRelay1.asObservable()
    .subscribe {
        print($0)
    }
// behaviorRelay.value - Just Read
behaviorRelay1.accept("Hello world")

let behaviorRelay2 = BehaviorRelay(value: ["behaviorRelay2 Item 1"])

behaviorRelay2.asObservable()
    .subscribe {
        print($0)
    }
behaviorRelay2.accept(["Item 2"])
behaviorRelay2.accept( behaviorRelay2.value + ["Item 3"] )

let behaviorRelay3 = BehaviorRelay(value: ["behaviorRelay3 Item 1"])

var value = behaviorRelay3.value
value.append("Item 2")
value.append("Item 3")

behaviorRelay3.accept(value)
behaviorRelay3.asObservable()
    .subscribe {
        print($0)
    }
