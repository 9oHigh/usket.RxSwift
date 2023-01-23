import Cocoa
import RxSwift
import RxCocoa

private let disposeBag = DisposeBag()

// MARK: startWith

private let numbers = Observable.of(2,3,4)

private let observable = numbers.startWith(1)

observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

print("\nConcat")

// MARK: concat

private let first = Observable.of(1,2,3)
private let second = Observable.of(4,5,6)

private let concatObservable = Observable.concat([first, second])

concatObservable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

print("\nMerge")

// MARK: merge

private let left = PublishSubject<Int>()
private let right = PublishSubject<Int>()

private let source = Observable.of(left.asObservable(), right.asObservable())

private let mergeObseravable = source.merge()
mergeObseravable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

left.onNext(5)
left.onNext(3)
right.onNext(2)
right.onNext(1)
left.onNext(99)

print("\nCombine Latest")

// MARK: combineLatest

private let clLeft = PublishSubject<Int>()
private let clRight = PublishSubject<Int>()

private let clObservable = Observable.combineLatest(clLeft, clRight) { lastLeft, lastRight in
    "\(lastLeft) \(lastRight)"
}

let disposable = clObservable.subscribe(onNext: {
    print($0)
})

clLeft.onNext(45)
clRight.onNext(1)
clLeft.onNext(30)
clRight.onNext(1)
clRight.onNext(2)

print("\nwithLatestFrom")

// MARK: withLatestFrom

private let button = PublishSubject<String>()
private let textField = PublishSubject<String>()

private let wlfObservable = button.withLatestFrom(textField)
private let wlfDisposable = wlfObservable.subscribe(onNext: {
    print($0)
})

textField.onNext("Sw")
textField.onNext("Swif")
button.onNext("CLICKED")
textField.onNext("Swift")
textField.onNext("Swift Rocks!")
button.onNext("CLICKED")

print("\nreduce")

// MARK: reduce

private let reduceSource = Observable.of(1,2,3)

reduceSource.reduce(0, accumulator: +)
    .subscribe({
        print($0)
    }).disposed(by: disposeBag)

reduceSource.reduce(0) { summary, newValue in
    return summary + newValue
}.subscribe({
    print($0)
}).disposed(by: disposeBag)

print("\nscan")

// MARK: scan

private let scanSource = Observable.of(1, 2, 3)

scanSource.scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

