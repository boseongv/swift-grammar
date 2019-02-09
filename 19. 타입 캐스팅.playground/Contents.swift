import UIKit

// 19. 타입캐스팅
// 스위프트는 데이터 타입 안전을 위하여 각기 다른 타입끼리의 값 교환을 엄격하게 제한한다.

// 19.1 기존 언어의 타입 변환과 스위프트의 타입 변환
// Code. C언어와 스위프트의 데이터 타입 변환 비교
// C언어
//double value = 3.3
//int convertedValue = (int)value
//convertedValue = 5.5

// 스위프트
//var value: Double = 3.3
//var convertedValue: Int = Int(value) // 이니셜라이저를 통한 데이터 타입의 형태를 변경해주었다.
//convertedValue = 5.5

// Int의 이니셜라이저는 대부분 실패하지 않는 이니셜라이저로 정의되어 있다. 하지만 실패 가능한 이니셜라이저도 포함되어 있다.

/*
// Code. 실패 가능한 이니셜라이저
var stringValue: String = "123"
var integerValue: Int? = Int(stringValue)

print(integerValue)

stringValue = "A123"
integerValue = Int(stringValue)

print(integerValue)
*/

// 19.2 스위프트 타입캐스팅
// 스위프트의 타입캐스팅은 인스턴스의 타입을 확인하거나 자신을 다른 타입의 인스턴스인양 행세할 수 있는 방법으로 사용할 수 있다.
// 스위프트의 타입캐스팅은 is 와 as 연산자로 구현한다. 이 두 연산자로 값의 타입을 확인하거나 다른 타입으로 전환할 수 있다.

// Code. Coffee 클래스와 Coffee 클래스를 상속받은 Latte와 Americano 클래스
/*
class Coffee {
    let name: String
    let shot: Int
    
    var description: String {
        return "\(shot) shot(s) \(name)"
    }
    
    init(shot: Int) {
        self.shot = shot
        self.name = "coffee"
    }
}

class Latte: Coffee {
    var flavor: String
    
    override var description: String {
        return "\(shot) shot(s) \(flavor) latte"
    }
    
    init(flavor: String, shot: Int) {
        self.flavor = flavor
        super.init(shot: shot)
    }
}
class Americano: Coffee {
    let iced: Bool
    
    override var description: String {
        return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool) {
        self.iced = iced
        super.init(shot: shot)
    }
}
*/
// 19.3 데이터 타입 확인
// 타입 확인 연산자인 is를 사용하여 인스턴스가 어떤 클래스(혹은 어떤 클래스의 자식클래스)의 인스턴스인지 타입을 확인해볼 수 있다.
// 타입 확인 연산자는 인스턴스가 해당 클래스의 인스턴스이거나 그 자식클래스의 인스턴스라면 true를 반환하고 그렇지 않다면 false를 반환한다.

/*// Code. 데이터 타입 확인
let coffee: Coffee = Coffee(shot: 1)
print(coffee.description)

let myCoffee: Americano = Americano(shot: 2, iced: false)
print(myCoffee.description)

let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
print(yourCoffee.description)

print(coffee is Coffee)
print(coffee is Americano)
print(coffee is Latte)

print(myCoffee is Coffee)
print(yourCoffee is Coffee)

print(myCoffee is Latte)
print(yourCoffee is Latte)*/

// is 연산자 외에도 타입을 확인할 수 있는 방법으로는 메타 타입 타입이있다. 메타 타입 타입은 타입의 타입을 뜻한다. 즉, 타입 자체가 하나의 타입으로 또 표현할 수 있다는 것이다.

/*// Code. 메타 타입
protocol SomeProtocol { }
class SomeClass: SomeProtocol { }

let intType: Int.Type = Int.self
let stringType: String.Type = String.self
let classType: SomeClass.Type = SomeClass.self
let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self

var someType: Any.Type

someType = intType
print(someType)

someType = stringType
print(someType)

someType = classType
print(someType)

someType = protocolProtocol
print(someType)*/

// 19.4 다운 캐스팅
// 어떤 클래스 타입의 변수 또는 상수가 정말 해당 클래스의 인스턴스를 참조하지 않을 수도 있다.

// Code. Latte 타입의 인스턴스를 참조하는 Coffee 타입 actingConstant 상수
//let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
//print(actingConstant.description)

// 다운 캐스팅은 클래스의 상속 모식도에서 자식클래스보다 더 상위에 있는 부모클래스의 타입을 자식클래스의 타입으로 캐스팅한다고 해서 다운캐스팅이라고 불린다.

// 다운 캐스팅은 실패할 여지가 충분히 있기 때문에 as? 와 as!를 이용하여 연산한다.
// as?는 다운 캐스팅이 실패할 경우 nil을 반환하고 as!는 실패할 경우 런타임 오류가 발생한다.
// 따라서 as? 연산자는 반환타입이 옵셔널이지만, as! 연산자의 반환타입은 옵셔널이 아니다.
// 다운캐스팅에 실패할 가능성이 있다면 조건부 연산자인 as? 를 사용하여야 한다. 조건부 연산자 as?를 사용할 시에 다운캐스팅에 성공할 경우 옵셔널 타입으로 인스턴스를 반환하며, 실패할 경우 nil을 반환한다.
/*
// Code. 다운 캐스팅
if let actingOne: Americano = coffee as? Americano {
    print("This is Americano")
} else {
    print(coffee.description)
}

if let actingOne: Latte = coffee as? Latte {
    print("This is Latte")
} else {
    print(coffee.description)
}

if let actingOne: Coffee = coffee as? Coffee {
    print("This is Just Coffee")
} else {
    print(coffee.description)
}

if let actingOne: Americano = myCoffee as? Americano {
    print("This is Americano")
} else {
    print(coffee.description)
}

if let actingOne: Latte = myCoffee as? Latte {
    print("This is Latte")
} else {
    print(coffee.description)
}
if let actingOne: Coffee = yourCoffee as? Coffee {
    print("This is Just Coffee")
} else {
    print(Coffee.description)
}

let castedCoffee: Coffee = yourCoffee as! Coffee

let castedAmericano: Americano = Coffee as! Americano
*/

// Code. 항상 성공하는 다운캐스팅
//let castedCoffee: Coffee = yourCoffee as Coffee

// 타입캐스팅은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아니다. 인스턴스는 메모리에 똑같이 남아있을 뿐이다. 다만 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할지 판단할 수 있도록 컴퓨터에게 도움을 주는 역할을 한다.

// 19.5 Any, AnyObject의 타입캐스팅
// 스위프트에는 특정 타입을 지정하지 않고 여러 타입의 값을 할당할 수 있는 Any와 AnyObject라는 특별한 타입이 있다.
// Any는 함수 타입을 포함한 모든 타입을 뜻하고, AnyObject는 클래스 타입만을 뜻한다.

/*// AnyObject의 타입 확인
func checkType(of item: AnyObject) {
    if item is Latte {
print("item is Latte")
    } else if item is Americano {
print("item is Americano")
    } else if item is Coffee {
print("item is Coffee")
    } else {
print("Unknown Type")
    }
}

checkType(of: coffee)
checkType(of: myCoffee)
checkType(of: yourCoffee)
checkType(of: actingConstant) */

// Code. Any의 타입캐스팅
func checkAnyType(of item: Any) {
    switch item {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x,y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let latte as Latte:
        print(latte.description)
    case let stringConverter as (String) -> String:
        print(stringConverter("yagom"))
    default:
        print("something else : \(type(of: item))")
    }
}
