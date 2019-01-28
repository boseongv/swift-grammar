import UIKit

// Chapter 16. 모나드
// 모나드는 특정한 상태로 값을 포장하는 것에서 시작되어진다.
// 함수 객체와 모나드는 특정 기능이 아닌 디자인 패턴이나 자료구조라고 할 수 있다.

// 16.1 컨텍스트
// 옵셔널은 열거형으로 구현되어 있기 때문에 열거형 case의 연관 값을 통해 인스턴스 안에 연관 값을 갖는 형태이다.
// 옵셔널의 값을 추출한다는 것은 열거형 인스턴스 내부의 .some(value) case의 연관 값을 꺼내오는 것과 같다.

// Code. addThree 함수
func addThree(_ num: Int) -> Int {
    return num + 3
}
// 16.2 함수객체
// 맵을 사용하면 컨테이너 안의 값을 처리할 수 있다.
// optional(2).map(addThree)

// Code. 옴셔널에 맵 메서드와 클로저의 사용
var value: Int? = 2
value.map{ $0 + 3 }

value = nil
value.map{$0 + 3}

// Code. 옵셔널의 map 메서드 구현
extension Optional {
    func map<U>(f: (Wrapped) -> U) -> U? {
        switch self {
        case .some(let x): return f(x)
        case .none: return .none
        }
    }
}
// 옵셔널의 map(_:) 메서드를 호출하게 되면 옵셔널이 스스로 값이 있는지 없는지 switch 구문으로 판단하여 값이 있다면 전달받은 함수에 자신의 값을 적용한 결과값을 다시 컨텍스트에 넣어 반환을 하고, 값이 없다면 함수를 실행하지 않고 빈 컨텍스트를 반환한다.

// 16.3 모나드
// 모나드는 함수 객체의 일종으로 맵 함수를 지원하는 컨테이너 타입이다.
// 모나드는 맵함수에서 나아가 값이 있을지 없을지 모르는 상태를 추가하게 된다.
// 플랫맵은 포장된 값을 받아서 값이 있으면 포장을 풀어서 값을 처리한 후 포장된 값을 반환하고, 값이 없으면 없는대로 다시 풀어서 반환한다.

// Code. doubledEven(_:) 함수와 플랫맵의 사용
func doubledEven(_ num: Int) -> Int? {
    if num % 2 == 0 {
        return num * 2
    }
    return nil
}
Optional(3).flatMap(doubledEven)

// Code. 맵과 플랫맵의 차이
let optionalArr: [Int?] = [1, 2, nil, 5]

let mappedArr: [Int?] = optionalArr.map{ $0 }
let flatmappedArr: [Int] = optionalArr.flatMap{ $0 }

print(mappedArr)
print(flatmappedArr)

// 맵 메서드를 사용한 결과는 Array 컨테이너 내부의 값 타입이나 형태가 어떤 것이든 Array 내부에 값이 있으면 그 값을 클로저의 코드에서만 실행하고 결과를 다시 Array 컨테이너에 담는다.
// 플랫맵을 통해 클로저를 실행하면 알아서 내부 컨테이너의 값까지 추출을 한다.


// Code. 중첩된 컨테이너에서 맵과 플랫맵의 차이
let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap{ $0.flatMap{ $0 } }

print(mappedMultipleContainer)
print(flatmappedMultipleContainer)


// 플랫맵은 내부의 값을 1차원적으로 펼처놓는 작업도 하기 때문에, 값을 꺼내어 모두 동일한 위상으로 펼쳐놓는 모양을 가질 수 있다.

//// Code. 플랫맵의 활용
//func stringToInt(str: String) -> Int? {
//    return Int(str)
//}
//
//func intToString(integer: Int) -> String? {
//    return "\(integer)"
//}
//
//var optionalString: String? = "2"
//
//var result: Any = optionalString.flatMap(stringToInt).flatMap(intToString).flatMap(stringToInt)
//print(result)
//result = optionalString.map(stringToInt)
//print(result)
//
// 플랫맵을 사용하여 체인을 연결했을 때 결과는 옵셔널 타입이지만, 맵을 사용하여 맵을 연결하면 옵셔널의 옵셔널 형태로 반환이 되어진다.
// 그 이유는 플랫맵은 함수의 결괏값에 값이 있다면, 값을 추출하여 평평하게 만드는 과정을 가지고 있지만. 맵은 그렇지 않기 때문이다.
// 맵은 옵셔널 타입의 값을 옵셔널이라는 컨테이너 안에 다시 집어넣어 반환을 하고, 플랫맵은 추출 작업을 하여 옵셔널에서 값을 꺼내온 후 다시 옵셔널에 넣어주기 때문에 이렇게 연쇄적인 연산이 가능한 것이다.

// Code. 옵셔널의 맵과 플랫맵 정의
//public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
//public func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?

// 맵에서 전달받는 함수 transform은 포장된 값을 매개변수로 갖고 U를 반환하는 함수이다.
// String 옵셔널의 맵에 stringToInt(_:) 함수를 전달하면 최종 반환 타입이 Int??가 된다.

// 플랫맵이 전달받는 transform은 포장된 값을 매개변수로 갖고 U?를 반환하는 함수이다.
// transform에 stringToInt(_:)를 대입해 생각해보면 U? == Int?가 된다. 즉 U == Int가 되기 때문에 플랫맵의 동작 결과는 최종적으로 Int? 타입을 반환하게 된다.

// Code. 옵셔널 바인딩을 통한 연산
if let str: String = optionalString {
    if let num: Int = stringToInt(str: str) {
        if let finalStr: String = intToString(integer: num){
            if let finalNum: Int = stringToInt(str: finalStr) {
                result = Optional(finalNum)
            }
        }
    }
}
print(result)

if let str: String = optionalString, let num: Int = stringToInt(str: str), let finalStr: String = intToString(integer: num), let finalNum: Int = stringToInt(str: finalStr) {
    result = Optional(finalNum)
}
print(result)

// 플랫맵은 체이닝 중간에, 연산에 실패는 경우나 값이 없어지는 경우 별도의 예외처리 없이 빈 컨테이너를 반환한다.

// Code. 플랫맵 체이닝 중 빈 컨텍스트를 만났을 때의 결과
func intToNil(param: Int) -> String? {
    return nil
}
var optionalString: String? = "2"

var result: Any = optionalString.flatMap(stringToInt).flatMap(intToNil).flatMap(stringToInt)
print(result)
