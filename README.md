# Mastering RxSwift in iOS
> **Udemy의 Mastering RxSwift in iOS 강의를 통해 RxSwift..! 
드디어 시작합니다 👀**
> 

## Section 1: Introduction

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

## section 2: Observable

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
