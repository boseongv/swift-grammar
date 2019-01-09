import UIKit

// 13.Closure
// 클로저는 일정한 기능을 하는 코드를 하나의 블록으로 모아놓은 것을 말한다.
// 클로저는 변수나 상수가 선언된 위치에서 참조를 획득하고 저장할 수 있습니다.
// 클로저는 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것을 말한다.


// 클로저의 몇가지 모양 중 하나가 함수이다.
// 클로저의 세가지 형태
// 1. 이름이 있으면서 어떤 값도 획득하지 않는 전역함수의 형태
// 2. 이름이 있으면서 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태
// 3. 이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성한 형태

// 클로저는 매개변수와 반환 값의 타입을 문맥을 통해 유추할 수 있기 때문에 매개변수와 반환 값의 타입을 생략할 수 있다.
// 클로저에 단 한 줄의 표현만 들어있다면 암시적으로 이를 반환 값으로 취급한다.
// 축약된 전달인자 이름을 사용할 수 있다.
// 후행 클로저 문법을 사용할 수 있다.


// 클로저의 표현 방법은 클로저가 함수의 모습이 아닌 하나의 블록의 모습으로 표현될 수 있는 방법을 의미한다.
// 클로저의 표현 방법은 클로저의 위치를 기준으로 크게 기본 클로저 표현과 후행 클로저 표현이 있다.
// 각 표현 내에서 가독성을 해치지 않는 선에서 표현을 생략하거나 축약할 수 있는 방법이 있다.

// Code. 정렬을 위한 함수 전달
let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

func backwards(first: String, second: String) -> Bool {
    print("\(first) \(second) 비교중")
    return first > second
}

//let reversed: [String] = names.sorted(by: backwards)
//print(reversed)

// backwards(first:second:) 함수 대신에 sorted(by:) 메서드의 전달인자로 클로저를 직접 전달합니다.
//let reversed: [String] = names.sorted(by: {(first: String, second: String) -> Bool in return first > second
//})
//print(reversed)

// 13.2 후행 클로저
// 클로저가 가독성이 떨어진다고 느껴질 때 사용하면 좋은 기능이다.

// 후행 클로저 표현
//let reversed1: [String] = names.sorted() { (first: String, second: String) -> Bool in return first > second
//}
//
//let reversed2: [String] = names.sorted(){ (first: String, second: String) -> Bool in return first > second }

// 13.3 클로저 표현 간소화
// 13.3.1 문맥을 이용한 타입 유추
// 메서드의 전달인자로 전달하는 클로저는 메서드에서 요구하는 형태로 전달해야 한다.
// 매개면수의 타입이나 개수, 반환 타입 등이 같아야 전달인자로서 전달할 수 있다.
// 전달인자로 전달하는 클로저를 구현할 때는 매개변수의 타입이나 반환 값의 타입을 굳이 표현해주지 않고 생략해도 문제가 되지 않는다.

// Code. 클로저의 타입 유추
// 클로저의 매개변수 타입과 반환 타입을 생략하여 표현할 수 있다.
//let reversed: [String] = names.sorted { (first, second)  in
//    return first > second
//}


// 13.3.2 단축 인자 이름
// 단축 인자 이름을 사용한 표현
//let reversed: [String] = names.sorted {
//    return $0 > $1
//}

// 13.3.3 암시적 반환 타입
// let reversed: [String] = names.sorted { $0 > $1 }

// 13.3.4 연산자 함수
// 클로저는 매개변수의 타입과 반환 타입이 연산자를 구현한 함수의 모양과 동일하다면 연산자만 표기하더라도 알아서 연산하고 반환한다.

// 13.4 값 획득
// 클로저의 값 획득이란 주변에 정의한 상수나 변수가 더 이상 존재하지 않더라도 해당 상수나 변수의 값을 자신 내부에서 참조하거나 수정할 수 있다.(클로저는 비동기 작업에 많이 사용되기 때문)
// 클로저를 통해 비동기 콜백을 작성하는 경우, 현재 상태를 미리 획득해두지 않으면, 클로저 기능을 실행하는 순간에는 주변의 상수나 변수가 이미 메모리에 존재하지 않는 경우가 발생한다.
// 중첩함수도 하나의 클로저 형태이므로, 중첩 함수 주변의 변수나 상수를 획득해 놓을 수 있다.
// 즉, 자신을 포함하는 함수의 지역변수나 지역상수를 획득할 수 있다.
// Code. makeIncrementer(forIncrement 함수)
//func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
//    var runningTotal = 0
//    func incrementer() -> Int { // 값을 증가시키는 역할을 하는 incrementer라는 중첩함수 사용.
//        runningTotal += amount
//        return runningTotal
//    }
//    return incrementer
//}
//
////// Code. incrementBy Two 상수에 함수 할당
////let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
////
////let first: Int = incrementByTwo()
////let second: Int = incrementByTwo()
////let thired: Int = incrementByTwo()
//
//
//// 13.5 클로저는 참조 타입
//// 함수나 클로저를 상수나 변수에 할당할 때마다 상수나 변수에 함수나 클로저의 참조를 설정하는 것이다.
//// 값을 할당하는 것이 아니라 해당 클로저의 참조를 할당하는 것이다.
//// 클로저의 참조를 다른 상수에 할당해준다면 이는 두 상수가 모두 같은 클로저를 가리킨다는 뜻이다.
//
//// Code. 참조 타입인 클로저
//let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
//let sameWithIncrementByTwo: (() -> Int) = incrementByTwo
//
//let first: Int = incrementByTwo()
//let second: Int = sameWithIncrementByTwo()
//
//// 13.6 탈출 클로저
//// 탈출 클로저란 함수의 전달인자로 전달한 클로저가 함수 종료 후에 호출될 때를 말한다.
//// 클로저를 매개변수로 갖는 함수를 정의할 때에는 @escaping 키워드를 사용하여 클로저가 탈출하는 것을 허용한다고 명시할 수 있다.
//// 비동기 작업으로 함수가 종료되고 난 후 작업이 끝나고 호출할 필요가 있는 클로저를 사용해야 할 때 탈출클로저가 필요하다.
//
//// Code. 탈출 클로저를 매개변수로 갖는 함수
//var completionHandlers: [() -> Void] = []
//
//func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
//    completionHandlers.append(completionHandler)
//}
//
//// Code. 함수를 탈출하는 클로저의 예
//typealias VoidVoidClosure = () -> Void
//let firstClosure: VoidVoidClosure = {
//    print("Closure A")
//}
//let secondClosure: VoidVoidClosure = {
//    print("Closure B")
//}
//
//// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될 수 있으므로 탈출 클로저이다.
//func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
//    // 전달인자로 전달받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저이다.
//    return shouldReturnFirstClosure ? first : second
//}
//
//// 함수에서 반환한 클로저가 함수 외부의 상수에 저장되었다.
//let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)
//
//returnedClosure()
//
//
//var closures: [VoidVoidClosure] = []
//
//// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저이다.
//func appendClosure(closure: @escaping VoidVoidClosure) {
//    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출합니다.
//    closures.append(closure)
//}

// Code. 클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저
typealias VoidVoidClosure = () -> Void

func functionWithNoescapeClosure(closure: VoidVoidClosure) {
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}

class SomeClass {
    var x = 10

    func runNosescapeClosure() {
        // 비탈출 클로저에서 self 키워드 사용은 선택 사항이다.
        functionWithNoescapeClosure { x = 200 }
    }
    
    func runEscapingClosure() -> VoidVoidClosure {
        // 탈출 클로저에서는 명시적으로 self를 사용해야 한다.
        return functionWithEscapingClosure { self.x = 100 }
    }
}

let instance: SomeClass = SomeClass()
instance.runNosescapeClosure()
print(instance.x)

let returnedClosure: VoidVoidClosure = instance.runEscapingClosure()
returnedClosure()
print(instance.x)
// 비탈출 클로저에서는 인스턴스의 프로퍼티인 x를 사용하기 위해 self 키워드를 생략해도 무관했지만, 탈출하는 클로저에서는 값 획득을 하기 위해 self 키워드를 사용하여 프로퍼티에 접근한다.

// 13.6.1 withoutActuallyEscaping
// Code. 오류가 발생하는 hasElements 함수
//func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//    return (array.lazy.filter { predicate($0) } .isEmpty == false)
//    // lazy 컬렉션은 비동기 작업을 할 때 사용하기 때문에 filter 메서드가 요구하는 클로저는 탈출 클로저이다. 그래서 탈출 클로저 자리에 비탈출 클로저를 전달할 수 없다는 오류가 생기게 된다.
// 함수 전체의 상황을 봤을 때에는 match 클로저가 탈출을 할 필요성이 없기 때문에, 해당 클로저를 탈출 클로저인척하여 코드의 오류가 생기지 않도록 하기 위해 withoutActuallyEscaping(_:do:) 함수를 사용한다.
//}

// Code. withoutActuallyEscaping(_:do:)함수의 응용
let numbers: [Int] = [2,4,6,8]

let evenNumberPredicate = {(number: Int) -> Bool in return number % 2 == 0}

let oddNumberPredicate = {(number: Int) -> Bool in return number % 2 != 0}

func hasElements(in array: [Int], match predicate: (Int) -> Bool)-> Bool {
    return withoutActuallyEscaping(predicate, do: {escapablePredicate in return (array.lazy.filter { escapablePredicate($0)}.isEmpty == false)
    })
}

let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)

print(hasEvenNumber)
print(hasOddNumber)

// 13.7 자동 클로저
// 함수의 전달인자로 전달하는 표현을 자동으로 변환해주는 클로저를 자동 클로저라고 한다.
// 자동 클로저는 전달 인자를 갖지 않으며, 호출 되었을 때 자신이 감싸고 있는 코드의 결과값을 반환한다.
// 자동 클로저는 클로저가 호출되기 전까지 클로저 내부의 코드가 동작하지 않기 때문에 연산을 지연시킬 수 있다.

// Code. 클로저를 이용한 연산 지연
//// 대기중인 손님들입니다.
//var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
//print(customersInLine.count)
//
//// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있습니다.
//let customerProvider: () -> String = {
//    return customersInLine.removeFirst()
//}
//print(customersInLine.count) // 클로저가 실행되기 전이므로 count 4.
//
//// 실제로 실행합니다.
//print("Now serving \(customerProvider())!") // 클로저 실행
//print(customersInLine.count) // 클로저가 실행된 이후의 count 3.

// Code. 함수의 전달인자로 전달하는 클로저
//// customersInLine is ["YoangWha", "SangYong", "SungHun", "HaMi"]
//var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
//
//func serveCustomer(_ customerProvider: () -> String) { // 매개변수가 클로저형태
//    print("Now serving \(customerProvider())!")
//}
//
//serveCustomer({customersInLine.removeFirst()}) // 암시적 반환 표현으로 return 키워드 생략. return값도 클로저

// Code. 자동 클로저의 사용
// customersInLine is ["YoangWha", "SangYong", "SungHun", "HaMi"]
//var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
//func serveCustomer(_ customerProvider: @autoclosure() -> String) { // 매개변수가 클로저지만, autoclosure속성을 주어, 자동 클로저 기능을한다.
// print("Now serving \(customerProvider())!")
//}
//
//serveCustomer(customersInLine.removeFirst()) // String값으로 전달된 전달인자가 자동으로 클로저로 변환.
// 자동클로저를 사용하면 기존의 사용 방법처럼 클로저를 전달인자로 넘겨줄 수 없다.

// 자동클로저를 사용하연 비탈출클로저 속성또한 암묵적으로 부여되기때문에, 만약 탈출 클로저로 구현하고 싶다면 @autoclosure 속성 뒤에 @escaping 속성을 덧붙여서 사용해야 한다.

// Code. 자동 클로저의 탈출
var customerInLine: [String] = ["minjae", "inniceive", "sopress"]

func returnProvider(_ customerProvider: @autoclosure @escaping () -> String
    ) -> (() -> String) {
    return customerProvider
}
let customerProvider: () -> String = returnProvider(customerInLine.removeFirst())
print("Now serving \(customerProvider())!") // 클로저 형태로 반환되어진다(= 함수를 탈출하는 클로저가 되는 것을 의미)
