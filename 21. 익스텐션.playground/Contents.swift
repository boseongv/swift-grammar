import UIKit
// Chapter 21. 익스텐션

// 21.1 익스텐션이란
// 익스텐션은 스위프트의 강점 중 하나로 구조체, 클래스, 열거형, 프로토콜타입에 새로운 기능을 추가할 수 있다.
// 기능을 추가하려는 타입을 구현한 소스 코드를 알지 못하거나, 보지 못한다고 해도 타입만 안다면 그 기능을 확장할 수 있다.
// 익스텐션은 타입에 새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없다.
// 클래스의 상속과 익스텐션을 비교해보자면
// 클래스의 상속은 클래스 타입에서만 가능하고 특정 타입을 물려받아 하나의 새로운 타입을 정의하는 '수직적'인 확장 기능이지만, 익스텐션은 구조체, 클래스, 프로토콜 등 다양한 곳에 적용이 가능하며, 기존의 타입에 기능을 추가하는 '수평적'인 확장 기능이다.
// 상속을 받으면 기존 기능을 재정의 할 수 있지만, 익스텐션은 재정의 할 수 없다.

// 21.1 익스텐션 문법
// 익스텐션은 extension이라는 키워드를 사용하여 선언한다.
// 익스텐션은 기존에 존재하는 타입이 추가로 다른 프로토콜을 채택할 수 있도록 확장할 수 있다.
// 이런 경우에는 클래스나 구조체에서 사용하던 것과 같은 방법으로 프로토콜의 이름을 나열해주면 된다.

// extenstion 확장할 타입 이름: 프로토콜 1, 프로토콜 2, 프로토콜 3 {
// 프로토콜 요구사항 구현
// }

/* Code. 스위프트 표준 라이브러리의 Double 타입에 구현한 익스텐션의 일부 코드
extension Double : CustomStringConvertible {
    // A textual representation of the value.
    public var description: String { get }
}

extension Double : CustomDebugStringConvertible {
    // A textual representation of the value, suitable for debugging.
    public var debugDescription: String { get }
}

extension Double : ExpressibleByIntegerLiteral {
    /// Parameter value: The new value.
    public init(integerLiteral value: Int64)
}
 
 extension Double : Hashable {
 /// The number's hash value.
 public var hashValue: Int { get }
 }
 
 extension Double : CustomReflectable {
 /// A mirror that reflects the 'Double' instance/
 public var customMirror: Mirror { get }
 }
*/

// 21.3 익스텐션으로 추가할 수 있는 기능
// 21.3.1 연산 프로퍼티
// 익스텐션을 통해 타입에 연산 프로퍼티를 추가할 수 있다.

/*// Code. 익스텐션을 통한 연산 프로퍼티 추가
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var isOdd: Bool {
        return self % 2 == 1
    }
}

print(1.isEven)
print(2.isEven)
print(1.isOdd)
print(2.isOdd)

var number: Int = 3
print(number.isEven)
print(number.isOdd)

number = 2
print(number.isEven)
print(number.isOdd)

// 코드의 익스텐션은 Int 타입에 두 개의 연산 프로퍼티를 추가한 것이다.
// Int 타입의 인스턴스가 홀수인지 짝수인지 판별하여 Bool 타입으로 알려주는 연산 프로퍼티이다.
// 익스텐션으로 Int타입에 추가해준 연산 프로퍼티는 Int타입의 어떤 인스턴스에도 사용이 가능하다.
// 위의 코드처럼 인스턴스 연산 프로퍼티를 추가할 수도 있으며, 'static 키워드' 를 사용하여 타입 연산 프로퍼티도 추가할 수 있다.

// 익스텐션으로 연산 프로퍼티를 추가할 수 있지만, 저장 프로퍼티는 추가할 수 없다.
// 또한 익스텐션으로 타입에 정의되어 있는 기존의 프로퍼티에 프로퍼티 감시자를 추가할 수도 없다.*/


// 21.3.2 메서드
// 익스텐션을 통해 타입에 메서드를 추가할 수 있다.
/*// Code. 익스텐션을 통한 메서드 추가
extension Int {
    func multiply(by n: Int) -> Int {
        return self * n
}

    mutating func multiplySelf(by n: Int) {
    self = self.multiply(by: n)
}
    static func isIntTypeInstance(_ instance: Any) -> Bool {
        return instance is Int
    }
}

print(3.multiply(by: 2))
print(4.multiply(by: 5))

var number: Int = 3

number.multiplySelf(by: 2)
print(number)

number.multiplySelf(by: 3)
print(number)

Int.isIntTypeInstance(number)
Int.isIntTypeInstance(3)
Int.isIntTypeInstance(3.0)
Int.isIntTypeInstance("3")

prefix operator ++

struct Position {
    var x: Int
    var y: Int
}

extension Position {
// + 중위 연산 구현
    static func + (left: Position, right: Position) -> Position {
return Position(x: left.x + right.x, y: left.y + right.y)
}

// - 전위 연산 구현
    static prefix func - (vector: Position) -> Position {
return Position(x: -vector.x, y: -vector.y)
}

// += 복합할당 연산자 구현
    static func += (left: inout Position, right: Position) {
        left = left + right
    }
}

extension Position {
// ==  비교 연산자 구현
    static func == (left: Position, right: Position) -> Bool {
return (left.x == right.x) && (left.y == right.y)
}

// != 비교 연산자 구현
    static func != (left: Position, right: Position) -> Bool {
        return !(left == right)
    }
}

extension Position {
// ++ 사용자정의 연산자 구현
    static prefix func ++ (position: inout Position) -> Position {
        position.x += 1
        position.y += 1
        return position
    }
}

var myPosition: Position = Position(x: 10, y: 10)
var yourPosition: Position = Position(x: -5, y: -5)

print(myPosition + yourPosition)
print(-myPosition)

myPosition += yourPosition
print(myPosition)

print(myPosition == yourPosition)
print(myPosition != yourPosition)

print(++myPosition)*/

// Position의 기능처럼 여러 기능을 여러 익스텐션 블록으로 나눠서 구현해도 좋다.
// 관련 기능별로 하나의 익스텐션 블록에 묶어 주는 것도 좋다.

// 21.3.3 이니셜라이저
// 인스턴스를 초기화(이니셜라이즈)할 때 인스턴스 초기화에 필요한 다양한 데이터를 전달받을 수 있도록 여러 종류의 이니셜라이저를 만들 수 있다.
// 타입의 정의 부분에 이니셜라이저를 추가하지 않더라도 익스텐션을 통해 이니셜라이저를 추가할 수 있다.
// 익스텐션으로 클래스 타입에 편의 이니셜라이저는 추가할 수 있지만, 지정 이니셜라이저는 추가할 수 없다.
// 지정 이니셜라이저와 디이니셜라이저는 반드시 클래스 타입의 구현부에 위치해야 한다.(?)

/*// Code. 익스텐션을 통한 디이니셜라이저 추가
extension String {
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }

    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }
}

let stringFromInt: String = String(intTypeNumber: 100)
let strinfFromDouble: String = String(doubleTypeNumber: 100.0)

class Person {
    var name: String

    init(name: String) {
        self.name = name
    }
}

extension Person {
    convenience init() {
        self.init(name: "Unknown")
    }
}

let someOne: Person = Person()
print(someOne.name)*/

// 익스텐션으로 열거형이나 구조체와 같은 값 타입에 이니셜라이저를 추가하였을 때,
// 모든 저장 프로퍼티에 기본 값이 있고, 타입에 기본 이니셜라이저와 멤버와이즈 이니셜라이저 외에 추가 사용자 정의 이니셜라이저가 없는 경우에는
// 익스텐션으로 사용자정의 이니셜라이저를 추가한 이후에도 해당 타입의 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 호출할 수 있다.

// 익스텐션을 통해 추가하는 이니셜라이저는 타입의 기존 이니셜라이저가 갖는 임무를 똑같이 수행해야 한다.
// 이 말은 즉슨, 인스턴스는 이니셜라이저가 호출 후 종료가 되는 시점까지 정상적으로 완벽하게 초기화 되는 것을 책임져야 한다는 말이다.

/*// Code. 익스텐션을 통한 초기화 위임 이니셜라이저 추가
struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Rect {
    var origin: Point = Point()
    var size: Size = Size()
}

let defaultRect: Rect = Rect()
let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX: Double = center.x - (size.width / 2)
        let originY: Double = center.y  - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect: Rect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

// Size 구조체와 Point 구조체의 모든 저장 프로퍼티는 기본값을 가지며, 추가로 사용자정의 이니셜라이저를 구현하지 않았기 때문에 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 사용할 수 있다.
// 그러므로 익스텐션에서 추가해주는 새로운 이니셜라이저는 멤버와이즈 이니셜라이저에게 초기화를 위임해줄 수 있다.*/

// 21.3.4 서브스크립트
// 익스텐션을 통해 타입에 서브스크립트를 추가할 수 있다.
// Code. 익스텐션을 통한 서브스크립트 추가
extension String {
    subscript(appedValue: String) -> String {
        return self + appedValue
}

    subscript(repeatCount: UInt) -> String {
        var str: String = ""

        for _ in 0..<repeatCount {
            str += self
        }

        return str
    }
}

print("abc"["def"])
print("abc"[3])

// 21.3.5 중첩 데이터 타입
// 익스텐션을 통해 타입에 중첩 데이터 타입을 추가할 수 있다.
// Code. 익스텐션을 통한 중첩 데이터 타입 추가
extension Int {
    enum Kind { // 열거형 타입 Kind
        case negative, zero, positive
}

    var kind: Kind { // Kind 타입의 연산 프로퍼티
        // kind 프로퍼티는 인스턴스가 양수인지 음수인지 0인지 판단하여 Kind를 반환하는 연산 프로퍼티이다.
        switch self {
        case 0:
        return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

print(1.kind)
print(0.kind)
print((-1).kind)

func printIntegerkinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind { // Kind 타입의 연산 프로퍼티
        case .negative:
            print("- ", terminator: "")
            // terminator 함수를 사용해준 이유는 terminator는 줄바꿈을 할 때 쓰는 명령인데, 일부러 빈문자열인 ""를 할당하여 줄바꿈을 하지 않게 하기 위해 빈 문자열을 전달하여 준 것이다.
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
}
print("")
}

printIntegerkinds(numbers: [3, 19, -27, 0, -6, 0, 7])



