import UIKit
import RxSwift
import RxCocoa

private let disposeBag = DisposeBag()

// MARK: - toArray

Observable.of(1,2,3,4,5)
    .toArray()
    .subscribe({
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - map

Observable.of(1,2,3,4,5)
    .map { $0 * 2 }
    .subscribe({
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - flatMap

struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 90))
let mary = Student(score: BehaviorRelay(value: 90))

let stuedent = PublishSubject<Student>()
let flatMapLatestStudent = PublishSubject<Student>()

stuedent.asObserver()
    .flatMap{ $0.score.asObservable() }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

stuedent.onNext(john)
john.score.accept(100)

stuedent.onNext(mary)
mary.score.accept(80)

john.score.accept(43)

// MARK: - flatMapLatest

flatMapLatestStudent.asObserver()
    .flatMapLatest { $0.score.asObservable() }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

flatMapLatestStudent.onNext(john)
john.score.accept(100)

flatMapLatestStudent.onNext(mary)
mary.score.accept(20)
