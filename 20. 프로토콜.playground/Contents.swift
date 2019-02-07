ㅌimport Foundation

// Chapter 20. 프로토콜

// 20.1 프로토콜이란
// 프로토콜은 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 의미한다.
// 구조체, 클래스, 열거형은 프로토콜을 채택해서 특정 기능을 실행하기 위한 요구사항을 실제로 구현할 수 있다.
// 프로토콜은 정의를 하고 제시를 할 뿐이지 스스로 기능을 구현하지 않는다.

// 20.2 프로토콜 정의
// Code. 타입의 프로토콜 채택
/*
클래스가 다른 클래스를 상속받는다면 상속받을 클래스 이름 다음에 채택할 프로토콜을 나열해준다.
struct SomeStruct: AProtocol, AnotherProtocol {
    // 구조체 정의
}

class SomeClass: AProtocol, AnotherProtocol {
    // 클래스 정의
}

enum SomeEnum: AProtocol, AnotherProtocol {
    // 열거형 정의
}
*/

// 20.3 프로토콜 요구사항
// 프로토콜은 타입이 특정 기능을 실행하기 위해 필요한 기능을 요구한다.
// 프로토콜이 자신을 채택한 타입에 요구하는 사항은 프로퍼티나 메서드와 같은 기능들이다.

// 20.3.1 프로퍼티 요구
// 프로토콜의 프로퍼티 요구사항은 항상 var 키워드를 사용한 변수 프로퍼티로 정의한다.
// 읽기와 쓰기가 모두 가능한 프로퍼티는 프로퍼티의 정의 뒤에 { get set }이라고 명시하며, 읽기 전용 프로퍼티는 프로퍼티의 정의 뒤에 { get }이라고 명시한다.

/*// Code. 프로퍼티 요구
protocol SomeProtocol {
    var settableProperty: String { get set } // 읽기 쓰기 모두 가능한 프로퍼티
    var notNeedToBeSettableProperty: String { get } // 읽기 전용 프로퍼티
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set } // 읽기 쓰기 모두 가능한 프로퍼티
    static var anotherTypeProperty: Int { get } // 읽기 전용 프로퍼티
}*/

/*// Code. Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스
protocol Sendable { // Sendable 프로토콜에서는 무언가의 전송을 가능하게 하는 from과 to를 요구한다.
    var from: String { get }
    var to: String { get }
}

class Message: Sendable { // Sendable 프로토콜을 채택하여 준수하기 때문에 from과 to 프로퍼티를 갖는다.
    var sender: String
    var from: String { // 읽기 전용 연산 프로퍼티
        return self.sender
    }

    var to: String

    init(sender: String, receiver: String) {
self.sender = sender
self.to = receiver
}
}
class Mail: Sendable { // Sendable 프로토콜을 채택하여 준수하기 때문에 from과 to 프로퍼티를 갖는다.
    var from: String
    var to: String
    
    init(sender: String, receiver: String) {
        self.from = sender
        self.to = receiver
    }
}*/

/*// Code. Receiveable, Sendable 프로토콜과 두 프로토콜을 준수하는 Message와 Mail 클래스

// 무엇인가 수신받을 수 있는 기능
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

// 무엇인가를 발신할 수 있는 기능
protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }

    func send(data: Any)

    static func isSendableInstance(_ instance: Any) -> Bool
}

// 수신, 발신이 가능한 Message 클래스
class Message: Sendable, Receiveable {
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
    var from: Sendable {
        return self
    }
    
    // 상대방은 수신 가능한 객체, 즉 Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
    var to: Receiveable?
    
    // 메세지를 발신합니다.
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
    }
    // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    // 메시지를 수신합니다.
    func received(data: Any, from: Sendable) {
        print("Message received \(data) from \(from)")
    }
    
    // class 메서드이므로 상속이 가능합니다.
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
    }
        return false
    }
}

// 수신, 발신이 가능한 Mail 클래스
class Mail: Sendable, Receiveable {
    var from: Sendable {
        return self
}

    var to: Receiveable?

    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Mail has no receiver")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable) {
        print("Mail received \(data) from: \(from)")
    }
    
    // static 메서드이므로 상속이 불가능하다.
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}
// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메세지를 주고 받을 수 있다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

// 두 Mail 인스턴스를 생성합니다.
let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi")

//Mail과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있다.
myMail.to = yourMail
myMail.send(data: "Hi")

myMail.to = myPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable프로토콜을 준수하지 않는다.
Message.isSendableInstance("Hello")

// Mail과 Message는 Sendable 프로토콜을 준수한다.
Message.isSendableInstance(myPhoneMessage)

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태이다.
Message.isSendableInstance(yourPhoneMessage)
Mail.isSendableInstance(myPhoneMessage)
Mail.isSendableInstance(myMail)*/


// 20.3.3 가변 메서드 요구
// 프로토콜이 어떤 타입이든 간에 인스턴스 내부의 값을 변경해야 하는 메서드를 요구하려면 프로토콜의 메서드 정의 앞에 mutating 키워드를 명시해야 한다.

/*// Code. Resettable 프로토콜의 가변 메서드 요구
protocol Resettable {
    mutating func reset() // 인스턴스 내부의 값을 변경해야하는 메서드를 요구하기 때문에 프로토콜의 메서드 정의 앞에 mutating 키워드를 명시한다.
}

class Person: Resettable { // 클래스
    var name: String?
    var age: Int?

    func reset() { // reset() 가변 메서드 요구
        self.name = nil
        self.age = nil
    }
}

struct Point: Resettable { // 값타입
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
         self.x = 0
         self.y = 0
    }
}

enum Direction: Resettable {
case east, west, south, north, unknown

    mutating func reset() {
        self = Direction.unknown
    }
}

// Resettable 프로토콜에서 가변 메서드를 요구하지 않는다면, 값 타입의 인스턴스 내부 값을 변경하는 mutating 메서드는 구현이 불가능하다.*/

// 20.3.4 이니셜라이저 요구
// 프로토콜에서 이니셜라이저를 요구하려면 메서드 요구와 마찬가지로 이니셜라이저를 정의하지만 구현은 하지 않는다.
// Code. 프로토콜의 이니셜라이저 요구와 구조체의 이니셜라이져 요구 구현
/*protocol Named { // Named 프로토콜 구현
    var name: String { get }

    init(name: String)
}

struct Pet: Named {
    var name: String

    init(name: String) {
        self.name = name
    }
}*/
/*
// Code. 클래스의 이니셜라이저 요구 구현
class Person: Named {
    var name: String

    required init(name: String) {
        self.name = name
    }
}*/

/*// Code. 상속 불가능한 클래스의 이니셜라이저 요구 구현
final class Person: Named {
    var name: String

    init(name: String) {
        self.name = name
    }
}*/

/*// Code. 상속받은 클래스의 이니셜라이저 요구 구현 및 재정의
class School {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class MiddleSchool: School, Named {
    required override init(name: String) {
        super.init(name: name)
    }
}*/

/*// Code. 실패 가능한 이니셜라이저 요구를 포함하는 Named 프로토콜과 Named 프로토콜을 준수하는 다양한 타입들
protocol Named {
    var name: String { get }

    init?(name: String)
}

struct Animal: Named {
    var name: String
    
    init!(name: String) {
        self.name = name
    }
}

struct Pet: Named {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class Person: Named {
    var name: String

    required init(name: String) {
        self.name = name
        }
    }

class School: Named {
    var name: String
    required init?(name: String) {
        self.name = name
    }
}*/


// 20.4 프로토콜의 상속과 클래스 전용 프로토콜
// 프로토콜은 하나 이상의 프로토콜을 상속받아 기존 프로토콜의 요구사항보다 더 많은 요구사항을 추가할 수 있다.

/*// Code. 프로토콜의 상속
protocol Readable {
    func read()
    }

protocol Writeable {
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
func speak()
}

class SomeClass: ReadWriteSpeakable {
    func read() {
        print("Read")
    }

    func write() {
        print("Write")
    }

    func speak() {
        print("Speak")
    }
}*/

// 프로토콜의 상속 리스트에 class 키워드를 추가하여 프로토콜이 클래스 타입에만 채택될 수 있도록 제한할 수 있다.
// 클래스 전용 프로토콜로 제한을 주기 위해서는 프로토콜의 상속 리스트의 맨 처음에 class 키워드가 위치해야 한다.

/*// Code. 클래스 전용 프로토콜의 정의
protocol ClassOnlyProtocol: class, Readable, Writeable {
// 추가 요구사항
}

class SomeClass: ClassOnlyProtocol {
    func read() { }
    func write() { }
}

// 오류 !! ClassOnlyProtocol 프로토콜은 클래스 타입에만 채택 가능하다.
struct SomeStruct: ClassOnlyProtocol {
    func read() {  }
    func write() {  }
    }*/

// 20.5 프로토콜 조합과 프로토콜 준수 확인
// 하나의 매개변수가 여러 프로토콜을 모두 준수하는 타입이어야 한다면 하나의 매개변수에 여러 프로토콜을 한 번에 조합하여 요구할 수 있다.

/*// Code. 프로토콜 조합 및 프로토콜, 클래스 조합
protocol Named {
    var name: String { get }
}
    protocol Aged {
        var age: Int { get }
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

class Car: Named {
    var name: String

    init(name: String) {
    self.name = name
        }
    }

class Truck: Car, Aged {
    var age: Int

    init(name: String, age: Int) {
        self.age = age
        super.init(name:  name)
    }
}

func celebrateBirthday(to celebrator: Named & Aged) {
print("Happy birthday \(celebrator.name) !! Now you are \(celebrator.age)")

    let yagom: Person = Person(name: "yagom", age: 99)
celebrateBirthday(to: yagom)

    let myCar: Car = Car(name: "Boong Boong")
    var someVariable: Car & Aged //

    someVariable = Truck(name: "Truck", age: 5)
 

// Code. 프로토콜 캐스팅
print(yagom is Named)
print(yagom is Aged)

print(myCar is Named)
print(myCar is Aged)

if let castedInstance: Named = yagom as? Named {
print("\(castedInstance) is Named")
}

    if let castedInstance: Aged = yagom as? Aged {
print("\(castedInstance) is Aged")
}

    if let castedInstance: Named = myCar as? Named {
        print("\castedInstance) is Named")
}

    if let castedInstance: Aged = myCar as? Aged {
        print("\(castedInstance) is Aged")
}*/

// 20.6 프로토콜의 선택적 요구
// @objc 속성은 해당 프로토콜을 Objective-C 코드에서 사용할 수 있도록 만드는 역할이다.
// 선택적 요구를 하면 프로토콜을 준수하는 타입에 해당 요구사항을 필수로 구현할 필요가 없다.
// 선택적 요구사항은 optional 식별자를 요구사항의 정의 앞에 붙여주면 된다.
// Code. 프로토콜의 선택적 요구

@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

//  걷기만 할 수 있는 호랑이
class Tiger: NSObject, Moveable {
    func walk() {
        print("Tiger walks")
    }
}

// 걷고 날 수 있는 새
class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }

    func fly() {
    print("Bird flys")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()
bird.walk()
bird.fly()

var movableInstance: Moveable = tiger
movableInstance.fly?()

movableInstance = bird
movableInstance.fly?()


// 20.7 프로토콜 변수와 상수
// 프로토콜은 프로토콜 이름만으로 자기 스스로 인스턴스를 생성하고 초기화할 수는 없다.
// 프로토콜 변수나 상수를 생성하여 특정 프로토콜을 준수하는 타입의 인스터스를 할당할 수는 있다.

// 20.8 위임을 위한 프로토콜
// 위임은 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 디자인 패턴이다.
// 예를 들어 UITableView 타입의 인스턴스가 해야 하는 일을 위임받아 처리하는 인스턴스는 UITableViewDelegate 프로토콜을 준수하면 된다.
// 위임받은 인스턴스인 UITableViewDelegate 프로토콜을 준수하는 인스턴스는 UITableView의 인스턴스가 해야 하는 일을 대신 처리해줄 수 있다.







