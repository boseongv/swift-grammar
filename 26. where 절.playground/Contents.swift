import UIKit

// Chapter 26. where 절
// where 절은 특정 패턴과 결합하여 조건을 추가하는 역할을 한다.

// 26.1 where 절의 활용
// where 절은 크게 두 가지 용도로 사용된다.
// 1. 패턴과 결합하여 조건 추가
// 2. 타입에 대한 제약 추가

// Code. 값 바인딩, 와일드카드 패턴과 where 절의 활용
let tuples: [(Int, Int)] = [(1, 2), (1, -1), (1, 0), (0, 2) ]

// 값 바인딩, 와일드카드 패턴
for tuple in tuples {
    switch tuple {
    case let (x, y) where x == y: print("x == y")
    case let (x, y) where x == -y: print("x == -y")
    case let (x, y) where x > y: print("x > y")
    case (1, _): print("x == 1")
    case (_, 2): print("y == 2")
    default: print("\(tuple.0), \(tuple.1)")
    }
}

var repeatCount: Int = 0
// 값 바인딩 패턴
for tuple in tuples {
    switch tuple {
    case let (x, y) where x == y && repeatCount > 2: print("x == y")
    case let (x, y) where repeatCount < 2: print("\(x), \(y)")
    default: print("Nothing")
    }
    
    repeatCount += 1
}

let firstValue: Int = 50
let secondValue: Int = 30

// 값 바인딩 패턴
switch firstValue + secondValue {
case let total where total > 100: print("total > 100")
case let total where total < 0: print("wrong value")
case let total where total == 0: print("zero")
case let total: print(total)
}

// Code. 옵셔널 패턴과 where 절의 활용
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

for case let number? in arrayOfOptionalInts where number > 2 {
    print("Found a \(number)")
}

// Code. 타입캐스팅 패턴과 where 절의 활용
let anyValue: Any = "ABC"

switch anyValue {
case let value where value is Int: print("value is Int")
case let value where value is String: print("value is String")
case let value where value is Double: print("value is Double")
default: print("Unknown type")
}

var things: [Any] = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as an Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

// Code. 표현 패턴과 where 절의 활용
var point: (Int, Int) = (1, 2)

switch point {
case (0, 0): print("원점")
case (-2...2, -2...2) where point.0 != 1: print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
default: print("point (\(point.0), \(point.1))")
}

// 프로토콜의 익스텐션에 where 절을 사용하면 이 익스텐션이 특정 프로토콜을 준수하는 타입에만 적용될 수 있도록 제약을 줄 수 있다.
// 이 말은 즉슨, 익스텐션이 적용되어있는 프로토콜 중에서도 where절 뒤에 제시되는 프로토콜을 준수하는 타입만 익스텐션이 적용되도록 제약을 줄 수 있다는 뜻이다.
// 여러개의 프로토콜을 제시하고 싶다면 쉼표로 구분해주면 된다.

// Code. where 절을 활용한 프로토콜 익스텐션의 프로토콜 준수 제약 추가
protocol SelfPrintable {
    func printSelf()
}

struct Person: SelfPrintable { }

extension Int: SelfPrintable { }
extension UInt: SelfPrintable { }
extension String: SelfPrintable { }
extension Double: SelfPrintable { }

extension SelfPrintable where Self: BinaryInteger, Self: Comparable {
    func printSelf() {
        print("BinaryInteger와 Comparable을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}

extension SelfPrintable where Self: CustomStringConvertible {
    func printSelf() {
        print("CustomStringConvertable을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}

extension SelfPrintable {
    func printSelf() {
        print("그 외 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}

// BinaryInteger와 Comparable을 준수하면서 SelfPrintable을 준수하는 Int 타입
Int(-8).printSelf()

// BinaryInteger와 Comparable을 준수하면서 SelfPrintable을 준수하는 UInt 타입
UInt(8).printSelf()

// CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 String 타입
String("yagom").printSelf()

// 그 외 SelfPrintable을 준수하는 타입 Double
Double(8.0).printSelf()

// 그 외 SelfPrintable을 준수하는 타입 Person()
Person().printSelf()


