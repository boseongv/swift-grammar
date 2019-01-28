import UIKit
// 15. 맵, 필터, 리듀스
// 15.1 맵
// 맵은 자신을 호출할 때 매개변수로 전달된 함수를 실행하여 그 결과를 다시 반환해주는 함수이다.
// 맵을 사용하면 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환한다.
// 기존 값이 나오는게 아니라 새로운 값이 반환되어지므로, 맵은 기존 데이터를 변형하는데 많이 사용한다.
/*
// Code. for-in 구문과 맵 메서드의 사용 비교
let numbers: [Int] = [0,1,2,3,4]
var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

// for 구문 사용
for number in numbers {
    doubledNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubledNumbers)
print(strings)

// map 메서드 사용
doubledNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})
strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubledNumbers)
print(strings)

// Code. 클로저 표현의 간략화
let numbers: [Int] = [0,1,2,3,4]

// 기본 클로저 표현식 사용
var doubledNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})

// 매개변수 및 반환타입 생략
doubledNumbers = numbers.map({ return $0 * 2 })
print(doubledNumbers)

// 반환 키워드 생략
doubledNumbers = numbers.map({ $0 * 2 })
print(doubledNumbers)

// 후행 클로저 사용
doubledNumbers = numbers.map{ $0 * 2 }
print(doubledNumbers)

// Code. 클로저의 반복 사용
let evenNumbers: [Int] = [0,2,4,6,8]
let oddNumbers: [Int] = [0,1,3,5,7]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubledEvenNumbers = evenNumbers.map(multiplyTwo)
print(doubledEvenNumbers)

let doubledOddNumbers = oddNumbers.map(multiplyTwo)
print(doubledOddNumbers)
*/

//// Code. 다양한 컨테이너 타입에서의 맵의 활용
//let alphabetDictionary: [String: String] = ["a":"A", "b":"B"]
//
//var keys: [String] = alphabetDictionary.map { (tuple: (String, String)) ->
//    String in
//    return tuple.0
//    }
//keys = alphabetDictionary.map{ $0.0 }
//
//let values: [String] = alphabetDictionary.map{ $0.1 }
//print(keys)
//print(values)
//
//var numberSet: Set<Int> = [1,2,3,4,5]
//let resultSet = numberSet.map{ $0 * 2 }
//print(resultSet)
//
//let optionalInt: Int? = 3
//let resultInt: Int? = optionalInt.map{ $0 * 2}
//print(resultInt)
//
//let range: CountableClosedRange = (0...3)
//let resultRange: [Int] = range.map { $0 * 2 }
//print(resultRange)

// 15.2 필터
// 컨테이너 내부의 값을 걸러서 추출하는 역할을 하는 고차함수이다.
// 맵과 마찬가지로 새로운 컨테이너의 값을 담아 반환해준다.
// 맵과 다른점으로는 기존 콘텐츠를 변형하는 맵과는 달리, 필터는 특정 조건에 맞추어 걸러주는 역할을 하는 점이 다르다.

//// Code. 필터 메서드의 사용
//let numbers: [Int] = [0,1,2,3,4,5]
//
//let evenNumbers: [Int] = numbers.filter { (number: Int) -> Bool in
//    return number % 2 == 0
//}
//print(evenNumbers)
//
//let oddNumbers: [Int] = numbers.filter{ $0 % 2 != 0 }
//print(oddNumbers)

// 15.3 리듀스
// 리듀스는 컨테이너 내부의 콘텐츠를 하나로 합하는 기능(=결합)을 실행하는 고차함수이다.
// 첫 번째 리듀스는 클로저가 각 요소를 전달받아 연산한 후 값을 다음 클로저 실행을 위해 반환하며 컨테이너를 순환하는 형태이다.

// 두 번째 리듀스는 컨테이너를 순환하며 클로저가 실행되지만 클로저가 따로 결괏값을 반환하지 않는 형태이다.
// public func reduce<Result><into initialResult: Result, _ updateAccmulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result
// 모든 순회가 끝나면 리듀스의 최종 결과값이 되는데, 상황에 따라서 리듀스는 매개변수로 전달된 함수를 실행하여 기존 컨테이너의 값에서 새로운 컨테이너가 생성되어 반환되어지는 맵 방식과 유사하게 사용이 가능하다.

//// Code. 리듀스 메서드의 사용
//let numbers: [Int] = [1,2,3]
//
//// 첫 번째 형태인 reduce(_:_:) 메서드의 사용
//// 초깃값이 0이고 정수 배열의 모든 값을 더한다.
//
//var sum: Int = numbers.reduce(0, {(result: Int, element: Int) -> Int in print("\(result) + \(element)")
//    // 0 + 1
//    // 1 + 2
//    // 3 + 3
//    return result + element
//})
//
//print(sum)
//
//// 초깃값이 0이고 정수 배열의 모든 값을 뺀다.
//let subtract: Int = numbers.reduce(0, { (result: Int, element: Int) -> Int in print("\(result) - \(element)")
//// 0 - 1
//// -1 -2
//// -3 -3
//    return result - element
//})
//
//print(subtract) // -6
//
//// 초깃값이 3이고 정수 배열의 모든 값을 더한다.
//let sumFromThree: Int = numbers.reduce(3) {
//print("\($0) + \($1)")
//// 3 + 1
//// 4 + 2
//// 6 + 3
//    return $0 + $1
//}
//
//print(sumFromThree)  // 9
//
//// 초깃값이 3이고 정수 배열의 모든 값을 뺀다.
//var subtractFromThree: Int = numbers.reduce(3) {
//print("\($0) - \($1)")
//// 3 - 1
//// 2 - 2
//// 0 - 3
//return $0 - $1
//}
//
//print(subtractFromThree)
//
//// 문자열 배열을 reduce(_:_:) 메서드를 이용해 연결시킨다.
//let names: [String] = ["Chope", "Jay", "Joker", "Nova"]
//
//let reducedNames: String = names.reduce("yagom's friend: ") {
//    return $0 + "," + $1
//}
//
//print(reducedNames) // "yagom's friend: , Chope, Jay, Joker, Nova"
//
//// 두 번째 형태인 reduce(into:_:) 메서드의 사용
//// 초깃값이 0이고 정수 배열의 모든 값을 더한다.
//// 첫 번째 리듀스 형태와 달리 클로저의 값을 변환하지 않고 내부에서 직접 이전 값을 변경한다는 점이 다르다.
//sum = numbers.reduce(into: 0, { (result: inout Int, element: Int) in
//// 0 + 1
//// 1 + 2
//// 3 + 3
//    print("\(result) + \(element)")
//    result += element
//})
//
//print(sum)
//
//// 초깃값이 3이고 정수 배열의 모든 값을 뺀다.
//// 첫 번째 리듀스 형태와 달리 클로저의 값을 반환하지 않고 내부에서 직접 이전 값을 변경한다는 점이 다르다.
//subtractFromThree = numbers.reduce(into: 3, {
//print("\($0) - \($1)")
//$0 -= $1
//})
//
//print(subtractFromThree)
//
//// 첫 번째 리듀스 형태와 다르기 때문에 다른 컨테이너에 값을 변경하여 넣어줄 수도 있다.
//// 이렇게 하면 맵이나 필터와 유사한 형태로 사용할 수도 있다.
//// 홀수는 걸러내고 짝수만 두 배로 변경하여 초깃값인 [1, 2, 3] 배열에 직접 연산한다.
//var doubledNumbers: [Int] = numbers.reduce(into: [1,2]){ (result: inout [Int], element: Int) in
//    print("result: \(result) element: \(element)")
//    guard element % 2 == 0 else {
//return
//}
//
//print("\(result) append \(element)")
//
//result.append(element * 2)
//}
//
//print(doubledNumbers)
//
//// 필터와 맵을 사용한 모습
//doubledNumbers = [1, 2] + numbers.filter { $0 % 2 == 0 }.map { $0 * 2}
//print(doubledNumbers)
//
//// 이름을 모두 대문자로 변환하여 초깃값인 빈 배열에 직접 연산한다.
//var upperCasedNames: [String]
//upperCasedNames = names.reduce(into: [], {
//$0.append($1.uppercased())
//})
//
//print(upperCasedNames)
//
//
//// 맵을 사용한 모습
//upperCasedNames = names.map{ $0.uppercased() }
//print(upperCasedNames)
//

// 15.4 맵 필터 리듀스의 사용

// Code. 친구들의 정보 생성
enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: [Friend] = [Friend]()

friends.append(Friend(name: "Yoobato", gender:  .male, location: "발리", age: 26))
friends.append(Friend(name: "Jisoo", gender:  .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender:  .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender:  .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender:  .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender:  .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender:  .male, location: "경기", age: 24))


// Code. 조건에 맞는 친구 결과 출력
// 서울 외의 지역에 거주하며 25세 이상인 친구
var result: [Friend] = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }

result = result.filter{ $0.location != "서울" && $0.age >= 25 }

let string : String = result.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") { $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"}

print(string)


