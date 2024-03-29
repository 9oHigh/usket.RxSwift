<H2>왜 RxSwift를 사용하는가?</H2>

- RxSwift
    - 함수형 프로그래밍인 Swift에 반응형 프로그래밍을 더해주는 라이브러리
    - 장점
        - 일관성이 없는 비동기 코드를 하나의 비동기 코드로 개발이 가능
        - 화장이 불가능했던 아키텍처 패턴을 해결할 수 있고 서로 다르게 구현한 로직을 조합하기 쉬워진다.
        - Thread 처리가 용이해짐에 따라 콜백 지옥에서 탈출 할 수 있게된다.
        - 데이터를 갱신했을 때의 처리가 쉬워지고 코드 가독성도 높일 수 있다.
    - 단점
        - 높은 러닝 커브
        - 많은 클로저 사용
            - 순환 참조 사이클이 일어날 수 있는 부분 주의

<details>
 <summary> <H2>Section 1: Introduction</H2> </summary>
 <div markdown="1">

- Introduction
    - 전체 섹션에 대한 간략한 소개
- Prerequistites
    - 강의를 진행하는데 있어서 필요한 개념 및 기술 소개
        - Swift 언어에 대한 기초적인 학습
        - MVC, MVP와 같은 간단한 아키텍처

- Exercise Files
    - 강의에 필요한 자료 다운로드하기

- What is Functional Programming?
    - Imperative Programming
        - 선언형 프로그래밍과 반대되는 개념으로 명령형 프로그래밍이라고 한다.
            
            ```swift
            var name: String = "바보"
            name = "멍청이"
            ```
            
    - Functinonal Programming
        - Funtional Programming에서 변수는 Immutable한 상태로 즉, 변경 불가능하다.
        - 따라서 다음의 예시는 Functional Programming이 아니다.
            
            ```swift
            var name: String = "바보"
            name = "멍청이"
            
            func doSomething() {
                    name = "말미잘"
            }
            print(name) // 멍청이
            doSomething()
            print(name) // 말미잘
            ```
            
    - First-Class and Higher-Order Functions
        - 일급객체와 고차함수
            - 고차함수: 함수를 인자로 전달받거나 함수를 결과로 반환하는 함수
                - Filter
                - Map
                - Reduce
    - Pure Function
        - 순수 함수
        - 주어진 입력으로 계산하는 것 이외에 프로그램의 실행에 영향을 미치지 않으며, 부수 효과(side effect)가 없는 함수
        
- RxSwift
    
    > RxSwift, in its essence, simplifies developing asynchronous programs by allowing your code to react to new data and process it in sequential, isolated manner.
    > 
    - RxSwift는 비동기 코드를 훨씬 더 간결하게 쓸 수 있게 해주는 라이브러리

- Hello, RxSwift!

</div>
 </details>

<details>
 <summary> <H2>section 2: Observable</H2> </summary>
 <div markdown="2">

- Observable
    - 비동기로 동작하는 어떠한 데이터들의 흐름, 시퀀스를 말한다.
    - next, error, completed의 3가지 타입의 이벤트를 방출한다.
    - 구독하는 옵저버들은 그 이벤트들을 받아 적절한 처리를 할 수 있다.
- onNext, onCompleted, 그리고 onError
    - **`Subscribe`** 메서드를 통해 옵저버와 Observable을 연결한다.  옵저버는 아래의 메서드를 구현하게 된다.
        - `**onNext**`
            - Observable은 새로운 항목들을 배출할 때마다 이 메서드를 호출한다. 이 메서드는 Observable이 배출하는 항목을 파라미터로 전달 받는다.
        - `**onCompleted**`
            - 오류가 발생하지 않았다면 Observable은 마지막 onNext를 호출한 후 이 메서드를 호출한다.
        - `**onError**`
            - Observable은 기대하는 데이터가 생성되지 않았거나 다른 이유로 오류가 발생할 경우 오류를 알리기 위해 이 메서드를 호출한다. 이 메서드가 호출 되면 onNext나 onCompleted는 더이상 호출되지 않는다.
            - onError 메서드는 오류 정보를 저장하고 있는 객체를 파라미터로 전달 받는다.
- Observable 사용예시
    - just
        - 단일 요소를 포함하는 관찰 가능한 시퀀스를 반환
        - 하나의 요소만 포함하는 Observable Sequence를 생성
            
            ```swift
            let observable = Observable.just(1)
            ```
            
    - of
        - 다양한 수의 요소를 가진 새로운 Observable 인스턴스를 생성
        - 여러 개의 요소를 가진 Observable 인스턴스를 생성
            
            ```swift
            let observable = Observable.of(1,2,3)
            let observable = Observable.of([1,2,3])
            ```
            
    - from
        - 배열을 관찰 가능한 시퀀스로 변환
        - 배열 형태의 Observable Sequence를 생성
            
            ```swift
            let observable = Observable.from([1,2,3,4,5])
            ```
            
    - 배열 요소
        
        ```swift
        // 첫 번째 방법
        observable.subscribe { event in
                if let element = event.element {
                        print(element)
                }
        }
        // 두 번째 방법
        observable.subscribe {onNext: { element in
                print(element)
        })
        
        ```
        

- Subscribe
    - Observable에 Observer 연결
    - 예시
        
        ```swift
        let observable = Observable.from([1,2,3,4,5])
        
        // unwrapping이 필요한 경우
        observable.subcribe { event in
                if let element = event.element {
                        print(element)
                }
        }
        
        // unwrapping이 필요하지 않은 경우
        observable.subscribe(onNext: { element in 
                print(element)
        })
        ```
        

- Dispose
    - 메모리 관리(효율성)를 위해 구독을 취소하는 메서드
    - 각각의 비동기 작업들을 DisposeBag에 담아두고 한 번에 처분하는 방식
    
    - 예시
        
        ```swift
        let disposeBag = DisposeBag()
        
        Observable.of("A", "B", "C")
                .subscribe {
                        print($0)
                }.dispoed(by: disposeBag)
        ```
        

- Create
    - 직접적인 코드 구현을 통해 옵저버 메서드를 호출하여 Observable을 생성
    - 예시
        
        ```swift
        Observable<String>.create { observer in
            observer.onNext("A")
            observer.onCompleted()
            observer.onNext("?") // Dispose된 이후, 호출 될 수 없음
            // 일회성이기 때문에 반드시 다시 생성되지 않도록 반환하기
            return Disposables.create()
        }.subscribe {
            print("subscribe is \($0)")
        } onError: {
            print("onError is \($0)")
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }
        ```
</div>
 </details>   

<details>
 <summary> <H2>Section 3: Subject</H2> </summary>
 <div markdown="3">

- 하나의 subject는 하나의 Observable을 **구독**하면서, Observable이 항목을 **배출**시키도록 동작한다. 그 결과로 인해 Cold Observable이었던 subject를 Hot Observable로 만들기도 한다.
    - Observer이면서 Observable이 될 수 있으며 이는 배출하는 데이터를 구독하는 Observer의 입장이 될 수 있고, 자체적으로 데이터를 생성할 수 있는 Observable의 역할을 할 수도 있다는 뜻.
    - Hot Observable ( Subject )
        - 생성됨과 동시에 아이템을 방출
        - 나중에 구독한 옵저버는 시퀀스의 중간부터 관찰
        - multicasting ( 여러 Observer가 공유할 수 있음 )
    - Cold Observable
        - 구독하기 전까지는 아이템을 방출하지 않고 기다림
        - 시퀀스의 전체를 관찰
        - unicasting

- 종류
    - PublishSubject
        
        ![Untitled](https://user-images.githubusercontent.com/53691249/190897285-0f86bc0f-1d47-4c8d-bf42-9a716792ffd0.png)
        
        - PublishSubject는 구독 이후에 Observable이 배출한 항목들만 옵저버에게 배출
            - 주의 할점
                - 생성 시점에서 즉시 항목을 배출하는 특성 때문에 생성되는 시점과 구독하는 시점 사이에 배출되는 항목들을 잃어버릴 수 있다는 단점이 존재한다.
                - 따라서 모든 항목의 배출을 보장해야한다면 Publish가 아닌 ReplaySubject를 사용해야한다.
        
    - BehaviorSubject
        
        ![Untitled (1)](https://user-images.githubusercontent.com/53691249/190897295-77a041f8-61dd-4fab-a543-5da92c1ff5ef.png)
        
        - 옵저버가 BehaviorSubject를 구독하기 시작하면, 옵저버는 Observable이 **가장 최근 발행한 항목**( 또는 아직 아무 값도 발행되지 않았다면 가장 **처음의 기본값**)의 발행을 시작하며 이후 Observable에 의해 발행된 항목을을 계속 발생
        
        - 초기값 / 최신값이 필요한 View를 가장 최신 데이터로 미리 채워놓는 상황에 용이
    
    - AysncSubject
        
        ![Untitled (2)](https://user-images.githubusercontent.com/53691249/190897304-70798ebc-5853-4013-827d-f1da5db4efe3.png)
        
        - Observable로부터 배출된 마지막 값을 배출하고 소스 Observable의 동작이 완료된 후에야 동작한다. ( 만약, 소스 Observable이 아무 값도 배출하지 않으면 AsyncSubject 역시 아무 값도 배출하지 않는다. )
        
    - ReplaySubject
        
        ![Untitled (3)](https://user-images.githubusercontent.com/53691249/190897322-e27b3366-6088-4a81-9c13-7ced3edf3d9a.png)
        
        - 옵저버가 구독을 시작한 시점과 관계없이  Observable이 배출한 모든 항목들을 모든 옵저버에게 배출
        - 생성자 오버로드를 제공하는데 이를 통해, 재생 버퍼의 크기가 특정 이상일 경우 오래된 항목들을 제거할 수 있다.
        - 주의 사항
            - onNext 또는 on과 같은 메서드는 사용하지 않도록 주의해야한다.

- 간단한 예제
    - PublishSubject
        - Subscribe한 이후부터 발생하는 이벤트를 처리
            
            ```swift
            let subject = PublishSubject<String>()
            
            subject.onNext("Event number 1") // 아직 구독 이전이라 출력되지 않음
            
            subject.subscribe { event in
                    print(event)
            }
            
            subject.onNext("Event number 2") // Event number 2
            subject.onCompleted() 
            subject.dispose()
            
            subject.onNext("Event number 3") // dispose되서 출력되지 않음
            ```
            
    
    - BehaviorSubject
        - 초기값을 가지고 생성
        - 구독 전 이벤트 중 최신 이벤트만 전달받음
            
            ```swift
            let subject = BehaviorSubject<String>(value: "Init")
            
            subject.onNext("Event number 1") // Event number 2가 가장 최신
            subject.onNext("Event number 2")
            
            subject.subscribe { event in
                    print(event) // Event number 2
            }
            
            subject.onNext("Event number 3") // Event number 3
            ```
            
    
    - ReplaySubject
        - 버퍼의 크기만큼 구독 전 최신 이벤트를 저장하고 있을 수 있음
            
            ```swift
            let subject = ReplaySubject<String>.create(bufferSize: 2)
            
            subject.onNext("Event number 1") // 버퍼의 크기가 2이므로 이벤트 발생 될 수 없음
            subject.onNext("Event number 2")
            subject.onNext("Event number 2")
            
            subject.subscribe { event in
                    print(event) 
            }
            // Event number 2
            // Event number 3
            ```
</div>
 </details>      

### ※ 참고

- Observable과 Subject의 차이점
    - Subject는 Observable과 observer의 역할을 모두 할 수 있는 bridge/proxy observable이다. 따라서 Observable과 Subject 모두 Subscribe할 수 있다.
    - 다만, subscribe의 차이가 있다면 Subject는 multicast 방식이기 떄문에 여러개의 Observable을 subscribe할 수 있다. 단순 Observable은 unicast 방식이기 때문에 Observer 하나만을 subscribe 할 수 있다.
    - 또한, Subject는 관찰자 세부 정보를 저장하고 코드를 한 번만 실행하고 모든 관찰자에게 결과를 제공한다.
    - 반면, Observable은 단지 하나의 함수이기 때문에 어떤 상태도 가지지 않으므로 모든 새로운 Observer에 대해 관찰 가능한 create 코드를 반복해서 실행한다. (Observable에서 Subscribe를 하면 이벤트로 전달되는 것은 항상 새로운것)
    - 코드는 각 관찰자에 대해 실행되므로 Http 호출인 경우 각 관찰자에 대해 호출된다. 이로 인해 주요 버그와 비효율이 발생한다.
    
    
</div>
 </details>

<details>
 <summary> <H2>section 5: Filtering Operator</H2> </summary>
 <div markdown="4">
 
- ignoreElements
    - 방출되는 요소는 무시하고, Observable의 종료 이벤트(`onError`, `onCompleted`)만 허용한다.
        
        ```swift
        // MARK: - IgnoreElements
        strikes
            .ignoreElements()
            .subscribe({ _ in
                print("[Subscription is called]")
            })
            .disposed(by: disposeBag)
        
        strikes.onNext("A")
        strikes.onNext("B")
        strikes.onNext("C")
        
        strikes.onCompleted()
        
        // print : [Subscription is called]
        ```
        
- elementAt → element(at: N)
    - 요소중에서 N번째에 해당하는 요소만 방출합니다.
        
        ```swift
        // MARK: - ElementAt
        
        strikes2.element(at: 2)
            .subscribe(onNext: { _ in
                print("is called!")
            })
            .disposed(by: disposeBag)
        
        strikes2.onNext("X") // 무시
        strikes2.onNext("X") // print : is called!
        strikes2.onNext("X") // 무시
        ```
        
- filter
    - 해당 요소들 중에 필터의 조건에 부합하는 요소를 방출한다.
        
        ```swift
        // MARK: - Filter
        
        Observable.of(1,2,3,4,5,6,7,8,9)
            .filter { $0 % 2 == 0 }
            .subscribe({ number in
                print("number", number)
            })
            .disposed(by: disposeBag)
        
        // print : 2, 4, 5, 6, 8
        ```
        
- skip
    - 처음 N개의 요소들은 스킵하고 그 이후의 요소들만 방출한다.
        
        ```swift
        // MARK: - Skip
        
        Observable.of("A", "B", "C", "D", "E", "F")
            .skip(2)
            .subscribe({ item in
                print("item", item)
            })
            .disposed(by: disposeBag)
        
        /*
        print
        item next(C)
        item next(D)
        item next(E)
        item next(F)
        */
        ```
        
    
- skip(until: )
    - 특정한 시퀀스에서 이벤트가 발생하기 전까지 모든 이벤트가 스킵된다.
        
        ```swift
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
        
        // print : C
        ```
        

- take
    - skip과는 반대로 N번째까지의 요소만 방출한다.
        
        ```swift
        // MARK: - take
        
        Observable.of(1,2,3,4,5)
            .take(3)
            .subscribe({ item in
                print("take Item", item)
            })
            .disposed(by: disposeBag)
        
        // print : 1, 2, 3
        ```
        
    
- take(while:)
    - while 내부의 조건이 false일 때까지 반복하여 방출합니다.
        
        ```swift
        // MARK: - take while
        
        Observable<Int>.of(2,4,5,6,7) // 타입명시 확실하게
            .take(while: { $0 % 2 == 0 })
            .subscribe({ item in
                print("take while Item", item)
            })
            .disposed(by: disposeBag)
        
        //print : 2, 4
        ```
        

- take(until:)
    - 특정한 시퀀스에서 이벤트가 발생한 이후 이벤트는 무시한다.
        
        ```swift
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
        trigger.onNext("X") // 트리거
        takeUntilSubject.onNext("C")
        
        /*
        print
        take until Item next(A)
        take until Item next(B)
        */
        ```

 </div>
</details>


<details>
 <summary> <H2>section 7: Transforming Operator</H2> </summary>
 <div markdown="5">
 
 - toArray
    - 들어오는 요소들을 배열로 변환해주는 오퍼레이터이다.
        
        ```swift
        // MARK: - toArray
        
        Observable.of(1,2,3,4,5)
            .toArray()
            .subscribe({
                print($0)
            })
            .disposed(by: disposeBag)
        
        // print : success([1, 2, 3, 4, 5])
        ```
        
- map
    - 요소들에 변형을 주어 방출하는 오퍼레이터이다.
        
        ```swift
        // MARK: - map
        
        Observable.of(1,2,3,4,5)
            .map { $0 * 2 }
            .subscribe({
                print($0)
            })
            .disposed(by: disposeBag)
        
        // print : 2, 4, 6, 8, 10
        ```
        
- flatMap
    - 각각의 하나의 시퀀스에서 이벤트에 대해 시퀀스를 만든 이후에 하나의 시퀀스로 만들어주는 오퍼레이터이다.
        
        ```swift
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
        
        stuedent.onNext(john)    // print : 90
        john.score.accept(100)   // print : 90 100 
        
        stuedent.onNext(mary)    // print : 90 100 90
        mary.score.accept(80)    // print : 90 100 90 80
        
        john.score.accept(43)    // print : 90 100 90 80 43
        ```
        
- flatMapLatest
    - 가장 최근에 만들어진 시퀀스만 방출한다.
        
        ```swift
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
        
        /*
        90
        100
        90
        20
        */
        ```
 
</div>
 </details>
 
 <details>
 <summary> <H2>section 9: Combining Operator</H2> </summary>
 <div markdown="6">
 
- startWith
    - 기존의 시퀀스에서 첫 번째에 요소를 추가할 수 있는 오퍼레이터이다.
        
        ```swift
        // MARK: startWith
        
        private let numbers = Observable.of(2,3,4)
        
        private let observable = numbers.startWith(1)
        
        observable.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        // print : 1,2,3,4
        ```
        

- concat
    - 특정한 시퀀스에 다른 시퀀스의 요소들을 앞 혹은 뒤에 추가할 수 있게 해주는 오퍼레이터이다.
        
        ```swift
        // MARK: concat
        
        private let first = Observable.of(1,2,3)
        private let second = Observable.of(4,5,6)
        
        private let concatObservable = Observable.concat([first, second])
        
        concatObservable.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        // print : 1,2,3,4,5,6
        ```
        

- merge
    - 시퀀스를 합쳐주는 오퍼레이터로 여러개의 시퀀스를 동시에 구독한다.
    - 내부의 시퀀스가 complete되는 시점은 모두 독립적이다
    - 내부의 시퀀스가 error를 방출하면 merge 시퀀스도 에러를 방출하며 구독이 종료된다.
    - 내부의 시퀀스가 종료되면 merge 시퀀스도 종료된다.
        
        ```swift
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
        
        // print : 5, 3, 2, 1, 99
        ```
        

- combineLatest
    - 두개의 시퀀스를 하나로 합쳐주는 오퍼레이터이다.
    - 최초에 서브 시퀀스 어느 하나라도 방출하는 요소가 없다면 방출하지 않는다.
    - left를 기준으로 right이 나중에 오면 left에서의 최신 값과 순서대로 매칭된다.
        
        ```swift
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
        /*
        print
        45 1
        30 1
        30 1
        30 2
        */
        ```
        

- withLatestFrom
    - 특정한 트리거가 방출되었을 경우, 최신 값을 얻기 위해서 사용하는 오퍼레이터이다.
        
        ```swift
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
        
        /*
        Swif
        Swift Rocks!
        */
        ```
        

- reduce
    - 시퀀스내에서의 요소들간의 결합을 위해 사용하는 오퍼레이터이다.
    - 아래의 예시는 모든 내부 요소의 합을 원할 경우이다.
        
        ```swift
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
        
        /*
        6
        6
        */
        ```
        
- scan
    - reduce의 경우 결합이 완료된 후 값을 방출한다면 scan은 연산을 할 때마다 값을 방출하게 된다.
        
        ```swift
        // MARK: scan
        
        private let scanSource = Observable.of(1, 2, 3)
        
        scanSource.scan(0, accumulator: +)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        /*
        1
        3
        6
        */
        ```
 </div>
 </details>
 
 <details>
 <summary> <H2>Section 12: Error Handling</H2> </summary>
 <div markdown="12">
 
 - throw
    
    ```swift
    // MARK: - Throwing Error
    
    // 기존 코드
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
             
       return Observable.from([resource.url])
           .flatMap { url -> Observable<Data> in
               let request = URLRequest(url: url)
               return URLSession.shared.rx.data(request: request)
           }.map { data -> T? in
               return try? JSONDecoder().decode(T.self, from: data)
           }.asObservable()
    }
    // 200 < StatusCode < 300 에서 벗어난 값이 온다면 Throw
    // map의 리턴값은 Observable이 아님. 사이드이펙트 처리 시 throw를 리턴하여 처리
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T?> {
            
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> T in
                if 200 ..< 300 ~= response.statusCode {
                    return try JSONDecoder().decode(T.self, from: data)
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
        
    }
    ```
    

- chatchError → catch로 변경( 사용중인 버전 - 6.5.0)
    - throw된 에러를 받아 처리할 수 있게 해주는 Operator
        
        ```swift
        // MARK: - Handle Errors with Catch
        
        // 기존 코드
        let search = URLRequest.load(resource: resource)
                     .observe(on: MainScheduler.instance)
                     .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        // catch
        
        let search = URLRequest.load(resource: resource)
                     .observe(on: MainScheduler.instance)
                     .catch { error in
                         print(error.localizedDescription)
                         return Observable.just(WeatherResult.empty)
                     }.asDriver(onErrorJustReturn: WeatherResult.empty)
        ```
        

- retry
    - Error가 발생했을 경우 재시도할 수 있게 해주는 Operator로 최대 시도 횟수를 지정할 수 있다.
        
        ```swift
        let search = URLRequest.load(resource: resource)
                    .observe(on: MainScheduler.instance)
                    .retry(3)
                    .catch { error in
                        print(error.localizedDescription)
                        return Observable.just(WeatherResult.empty)
                    }.asDriver(onErrorJustReturn: WeatherResult.empty)
        ```
 
  </div>
 </details>
