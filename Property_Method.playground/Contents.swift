import UIKit

//chapter 10. 프로퍼티와 메서드

//프로퍼티는 값, 메서드는 함수 라고 보면 된다.


// 프로퍼티는 클래스, 구조체 또는 열거형 등에 관련된 값
// 메서드는 특정 타입에 관련된 함수

// 10.1 프로퍼티

// 저장 프로퍼티, 연산 프로퍼티, 타입 프로퍼티로 나눌 수 있다.
// 1. 저장 프로퍼티 : 인스턴스의 변수 또는 상수를 의미( 구조체, 클래스 )
// 2. 연산 프로퍼티 : 특정 연산을 실행한 결과값( 구조체, 클래스, 열거형 )
// 3. 타입 프로퍼티 : 특정 타입에서만 사용되는 프로퍼티( 클래스 변수와 같이 참조되는 타입은 특정 타입에서만 사용되니까 타입 프로퍼티)
// 프로퍼티 감시자 : 프로퍼티의 값이 변하는 것을 감시한다.

// 클래스 인스턴스는 부모클래스로 참조하는 것과 같이 사용되는게 일반적인 참조 타입이고, 구조체 인스턴스는 이니셜라이저로 자동적으로 완성되는 것과 같이 항상 값 타입이다.


// 10.1.1 저장 프로퍼티
// 클래스 또는 구조체의 인스턴스와 연관된 값을 저장하는 단순한 개념의 프로퍼티
// var나 let로 변수든 상수든 사용 가능.

// 저장 프로퍼티의 선언 및 인스턴스의 생성
struct CoordinatePoint {
    var x: Int // 저장 프로퍼티
    var y: Int // 저장 프로퍼티
}

// 구조체는 기본적으로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있다.
let yagomPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

// 사람의 위치 정보
class Position {
    var point: CoordinatePoint
    // 프로퍼티 변수 point는 값이 변경될 수 있음을 뜻한다.
    let name: String // 저장 프로퍼티 (상수)

    // 프로퍼티의 기본값을 저장해주지 않는다면 이니셜라이저를 따로 정해주어야 한다.
    init(name: String, currentPoint: CoordinatePoint){
        self.name = name
        self.point = currentPoint
    }
}

let yagomPosition: Position = Position(name: "yagom", currentPoint: yagomPoint)

// 저장프로퍼티의 초깃값 설정
struct CoordinatePoint0 {
    var x: Int = 0
    var y: Int = 0
}

// 프로퍼티의 초깃값을 할당했다면 굳이 전달인자로 초깃값을 넘길 필요가 없습니다.
let yagomPoint0: CoordinatePoint0 = CoordinatePoint0()

// 물론 기존에 초깃값을 할당할 수 있는 이니셜라이저도 사용 가능합니다.
let wizplanPoint: CoordinatePoint0 = CoordinatePoint0(x: 10, y: 5)

print("yagom's point : \(yagomPoint.x), \(yagomPoint.y)")

print("wizplan's point : \(wizplanPoint.x), \(wizplanPoint.y)")

// 사람의 위치 정보
class Position0 {
    var point: CoordinatePoint0 = CoordinatePoint0() // 저장 프로퍼티
    var name: String = "Unknown"
}

let yagomPosition0: Position0 = Position0()

yagomPosition0.point = yagomPoint0
yagomPosition0.name = "yagom"

// 옵셔널 저장 프로퍼티

struct CoordinatePoint_op {
    var x : Int
    var y : Int
}

// 사람의 위치 정보
class Position_op {
//현재 사람의 위치는 모를 수도 있기 때문에 옵셔널으로 설정을 해본다.
    var point: CoordinatePoint_op?
    let name: String

init(name: String) {
    self.name = name
    }
}

let yagomPosition_op: Position_op = Position_op(name: "yagom")

yagomPosition_op.point = CoordinatePoint_op(x: 20, y: 10)

// 10.1.2 지연 저장 프로퍼티
// 지연 저장 프로퍼티는 호출이 있어야 값을 초기화하며 lazy 키워드를 사용한다.
// 지연프로퍼티는 필요할 때 호출하여 값을 할당해야 하므로 변수로 정의하고, var 키워드를 사용한다.

// 지연 저장 프로퍼티
struct CoordinatePoint_delay {
    var x: Int = 0
    var y: Int = 0
}

class Position_delay {
    lazy var point: CoordinatePoint_delay = CoordinatePoint_delay()
    let name: String

    init(name: String) {
        self.name = name
    }
}

let yagomPosition_delay: Position_delay = Position_delay(name: "yagom")

print(yagomPosition_delay.point)

// 10.1.3 연산 프로퍼티
// 실제 값을 저장하는 프로퍼티가 아니라, 특정 상태에 따른 값을 연산하는 프로퍼티이다.
// 인스턴스 내부 외부의 값을 연산하여 적절한 값을 돌려주는 접근자의 역할이나, 간접적으로 내부의 프로퍼티 값을 설정하는 설정자 역할을 한다.
// 메서드를 쓰지않고, 연산프로퍼티를 사용하려는 이유로는 인스턴스의 외부에서 인스턴스 내부 값을 접근하려면 접근자와 설정자 메서드를 두개 구현해야 하는데, 그렇게 하면 코드의 가독성이 나빠지기 때문에 연산 프로퍼티를 사용한다.

// 메서드로 구현된 접근자와 설정자
struct CoordinatePoint_cal {
    var x: Int // 저장 프로퍼티
    var y: Int // 저장 프로퍼티

    // 대칭점을 구하는 메서드 - 접근자
    func oppositePoint() -> CoordinatePoint_cal {
        return CoordinatePoint_cal(x: -x, y: -y)
    }

    // 대칭점을 설정하는 메서드 - 설정자
    mutating func setOppositePoint(_ opposite: CoordinatePoint_cal) {
        x = -opposite.x
        y = -opposite.y
    }
}

var yagomPosition_cal: CoordinatePoint_cal = CoordinatePoint_cal(x: 10, y: 20)

// 현재 좌표
print(yagomPosition_cal)

// 대칭좌표
print(yagomPosition_cal.oppositePoint())

yagomPosition_cal.setOppositePoint(CoordinatePoint_cal(x: 15, y: 10))

print(yagomPosition_cal)

// 연산 프로퍼티의 정의와 사용
struct CoordinatePoint_cal1 {
    var x: Int // 저장 프로퍼티
    var y: Int // 저장 프로퍼티

    // 대칭 좌표
    var oppositePoint: CoordinatePoint_cal1 { //연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint_cal1(x: -x, y: -y)
        }

        // 설정자
        set(opposite) {
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var yagomPosition_cal1: CoordinatePoint_cal1 = CoordinatePoint_cal1(x: 10, y: 20)

// 현재 좌표
print(yagomPosition_cal1)

// 대칭 좌표
print(yagomPosition_cal1.oppositePoint)

// 대칭 좌표를 (15,10) 으로 설정하면
yagomPosition_cal1.oppositePoint = CoordinatePoint_cal1(x: 15, y: 10)

// 현재 좌표는 -15, -10으로 설정
print(yagomPosition_cal1)


// 매개변수 이름을 생략한 설정자
struct CoordinatePoint_name {
    var x: Int // 저장 프로퍼티
    var y: Int // 저장 프로퍼티

    // 대칭 좌표
    var oppositePoint_name: CoordinatePoint_name { // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint_name(x: -x, y: -y)
        }

        // 설정자
        set {
            x = -newValue.x
            y = -newValue.y
        }
    }
}

// 읽기 전용 연산 프로퍼티
struct CoordinatePoint_read {
    var x: Int // 저장 프로퍼티
    var y: Int // 저장 프로퍼티

    // 대칭 좌표
    var oppositePoint: CoordinatePoint_read { // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint_read(x: -x, y: -y)
        }
    }
}

var yagomPosition_read: CoordinatePoint_read = CoordinatePoint_read(x: 10, y: 20)

// 현재 좌표
print(yagomPosition_read)

// 대칭 좌표
print(yagomPosition_read.oppositePoint)

// 설정자를 구현하지 않았으므로 오류가 난다.
// yagomPosition_read.oppositePoint = CoordinatePoint_read(x: 15, y: 10)

//
//// 10.1.4 프로퍼티 감시자
//// 프로퍼티 감시자는 지연 저장 프로퍼티에 사용할 수 없으며 오로지 일반 저장 프로퍼티에만 적용할 수 있다.
//class Account {
//    var credit: Int = 0 {
//        willSet {
//            print(" 잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
//        }
//
//        didSet {
//            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
//        }
//    }
//}
//
//let myAccount: Account = Account()
//// 잔액이 0원에서 1000원으로 변경될 예정입니다.
//
//myAccount.credit = 1000
//// 잔액이 0원에서 1000원으로 변경되었습니다.
//
//// 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현
//class Account_1 {
//    var credit: Int = 0 {
//        willSet {
//            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
//        }
//
//        didSet {
//            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
//        }
//    }
//
//    var dollarValue1: Double {
//        get {
//            return Double(credit)
//        }
//
//        set {
//            credit = Int(newValue * 1000)
//            print(" 잔액을 \(newValue)달러로 변경 중입니다.")
//        }
//    }
//}
//
//class ForeignAccount: Account_1 {
//    override var dollarValue1: Double {
//        willSet {
//            print(" 잔액이 \(dollarValue1)달러에서 \(newValue)달러로 변경될 예정입니다.")
//        }
//
//        didSet {
//            print(" 잔액이 \(oldValue)달러에서 \(dollarValue1)달러로 변경되었습니다.")
//        }
//    }
//}
//
//let myAccount1: ForeignAccount = ForeignAccount()
//// 잔액이 0원에서 1000원으로 변경될 예정입니다.
//
//myAccount1.credit = 1000
//// 잔액이 0원에서 1000원으로 변경되었습니다.
//
//myAccount1.dollarValue1 = 2
//
//// 10.1.5 전역변수와 지역변수
//// 저장변수의 감시자와 연산변수
//
//var wonInPocket: Int = 2000 {
//    willSet {
//        print(" 주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
//    }
//
//    didSet {
//        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
//    }
//}
//
//var dollarInPocket: Double {
//    get {
//        return Double(wonInPocket)
//    }
//
//    set {
//        wonInPocket = Int(newValue * 1000.0)
//        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
//    }
//}
//
//dollarInPocket = 3.5

// 10.1.6 타입 프로퍼티
// 타입 프로퍼티와 인스턴스 프로퍼티

class AClass {
    // 저장 타입 프로퍼티
    static var typeProperty: Int = 0

    // 저장 인스턴스 프로퍼티
    var instanceProperty: Int = 0 {
        didSet {
            AClass.typeProperty = instanceProperty + 100
        }
    }

    // 연산 타입 프로퍼티
    static var typeComputedProperty: Int {
        get {
            return typeProperty
        }

        set {
            typeProperty = newValue
        }
    }
}

AClass.typeProperty = 123

let classInstance: AClass = AClass()
classInstance.instanceProperty = 100

print(AClass.typeProperty)
print(AClass.typeComputedProperty)


// 타입 프로퍼티의 사용
class Account {
    static let dollarExchangeRate: Double = 1000.0

    var credit: Int = 0
    var dollarValue: Double {
        get {
            return Double(credit)
        }

        set {
            credit = Int(newValue * Account.dollarExchangeRate)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

// 10.1.7 키 경로

class Person_1 {
    var name: String

    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person_1
}

print(type(of: \Person_1.name))
print(type(of: \Stuff.name))

// keyPath 서브스크립트와 키 경로 활용
class Persona {
    var name: String
    init(name: String){
        self.name = name
    }
}

struct Stuffa {
    var name: String
    var owner: String
}

let yagoma = Persona(name: "yagom")
let hanaa = Persona(name: "hana")
let macbooka = Stuffa(name: "MacBook Pro", owner: yagoma)\
let imaca = Stuffa(name: "iMac", owner: yagoma)
let iPhonea = Stuffa(name: "iPhone", owner: hanaa)

let stuffNameKeyPatha = \Stuffa.name
let ownerKeyPatha = \Stuffa.owner

let ownerNameKeyPatha = ownerKeyPatha.appending(path: \.name)

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져온다.
print(macbooka[KeyPath: stuffNameKeyPatha])
print(imaca[KeyPath: stuffNameKeyPatha])
print(iPhonea[KeyPath: stuffNameKeyPatha])
print(macbooka[KeyPath: ownerNameKeyPatha])
print(imaca[KeyPath: ownerNameKeyPatha])
print(iPhonea[KeyPath: ownerNameKeyPatha])

imaca[KeyPath: stuffNameKeyPatha] = "iMac Pro"
imaca[KeyPath: ownerNameKeyPatha] = hanaa

print(imaca[KeyPath: stuffNameKeyPatha])
print(imaca[KeyPath: ownerNameKeyPatha])


class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

let yagom = Person(name: "yagom")
let hana = Person(name: "hana")
let macbook = Stuff(name: "MacBook Pro", owner: yagom)
var iMac = Stuff(name: "iMac", owner: yagom)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerkeyPath = \Stuff.owner

// \Stuff.owner.name과 같은 표현이 됩니다.
let ownerNameKeyPath = ownerkeyPath.appending(path: \.name)

print(macbook[KeyPath: stuffNameKeyPath])
print(iMac[KeyPath: stuffNameKeyPath])
print(iPhone[KeyPath: stuffNameKeyPath])
print(macbook[KeyPath: ownerNameKeyPath])
print(iMac[KeyPath: ownerNameKeyPath ])
print(iPhone[KeyPath: ownerNameKeyPath])

iMac[KeyPath: stuffNameKeyPath] = "iMac Pro"
iMac[KeyPath: ownerkeyPath] = hana

print(iMac[KeyPath: stuffNameKeyPath])
print(iMac[KeyPath: ownerNameKeyPath])


// 10.2 메서드

// 메서드는 특정 타입에 관련된 함수.
// 구조체와 열거형이 메서드를 가질 수 있다는 것은 스위프트의 특징.
// 스위프트에서는 프로그래머가 정의하는 타입(클래스, 구조체, 열거형 등)에 자유롭게 메서드를 정의할 수 있다.

// 10.2.1 인스턴스 메서드
// 인스턴스 메서드란 특정타입의 인스턴스에 속한 함수를 뜻한다.
// 인스턴스 내부의 프로퍼티 값을 변경하거나 특정 연산 결과를 반환하는 등 인스턴스와 관련된 기능을 실행한다.

// 클래스의 인스턴스 메서드
/*
 class LevelClass {
    // 현재 레벨을 저장하는 저장 프로퍼티
    var level: Int = 0 {
        // 프로퍼티 값이 변경되면 호출하는 프로퍼티 감시자
        didSet {
            print("Level \(level)")
        }
    }
    
    // 레벨이 올랐을 때 호출할 메서드
    func levelUp() {
        print("Level up!")
        level += 1
    }
    
    func levelDown(){
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    // 특정 레벨로 이동할 때 호출할 메서드
    func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    // 레벨을 초기화할 때 호출할 메서드
    func reset() {
        print("Reset!")
        level = 0
    }
}

var levelClassInstance: LevelClass = LevelClass()
levelClassInstance.levelUp()
levelClassInstance.levelDown()
levelClassInstance.levelDown()
levelClassInstance.jumpLevel(to: 3)
*/
// 자신의 프로퍼티 값을 수정할 때 클래스의 인스턴스 메서드는 크게 신경쓸 필요가 없지만, 구조체나 열거형은 값타입이기 때문에 메서드 앞에 mutating 키워드를 붙여 메서드가 해당 인스턴스 내부의 값을 변경한다는 것을 명시한다.
/*
struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset() {
        print("Reset")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()
levelStructInstance.levelDown()
levelStructInstance.levelDown()
levelStructInstance.jumpLevel(to: 3)

*/
// self 프로퍼티
// 모든 인스턴스는 암시적으로 생성된 self 프로퍼티를 갖는다. self 프로퍼티는 인스턴스를 더 명확하게 지칭하고 싶을 때 사용한다.
// self 프로퍼티의 다른 용도로는 값 타입 인스턴스 자체의 값을 치환할 수 있다.

/*
// self 프로퍼티와 mutating 키워드
class LevelClass {
    var level: Int = 0
    
    func reset() {
        // 오류 ! self 프로퍼티 참조 변경 불가 !
        //self = LevelClass()
        }
    }

struct LevelStruct {
    var level: Int = 0
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func reset() {
        print("Reset!")
        self = LevelStruct()
    }
}

var levelStructInstance: LevelStruct = LevelStruct
levelStructInstance.levelUp()


levelStructInstance.reset()
print(levelStructInstance.level)

enum OnOffSwitch {
case on, off
    mutating func nextState() {
        self = self == .on ? .off : .on
    }
}

var toggle: OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle)
*/


// 10.2.2 타입 메서드
// 타입 자체에 호출이 가능한 메서드를 타입 메서드라고 하며, 메서드 앞에 static 키워드를 사용하여 타입 메서드임을 나타내준다.
// 클래스의 타입 메서드는 static 키워드와 class 키워드를 사용할 수 있다.
// static 키워드를 사용하면 상속 후 메서드 재정의가 불가능.
// class 키워드를 사용하면 상속 후 메서드 재정의가 가능.


// 클래스의 타입 메서드
class AClass {
    static func staticTypeMethod() {
        print("AClass staticTypeMethod")
}

    class func classTypeMethod() {
        print("AClass classTypeMethod")
    }
}

class BClass: AClass {
    override class func classTypeMethod() {
print("BClass classTypeMethod")
    }
}

AClass.staticTypeMethod()
AClass.classTypeMethod()
BClass.classTypeMethod()
