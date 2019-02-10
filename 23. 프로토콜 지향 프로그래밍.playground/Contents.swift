import UIKit

// Chapter 23. 프로토콜 지향 프로그래밍
// 23.1 프로토콜 초기 구현
// 특정 프로토콜을 정의하고 여러 타입에서 이 프로토콜을 준수하게 만들어 타입마다 똑같은 메서드, 프로퍼티, 서브스크립트 등을 구현해야 한다면 많은 코드들을 사용해야하고, 유지보수도 어렵기 때문에 익스텐션과 프로토콜을 결합한다.
// (프로토콜의 요구사항)을 (익스텐션)을 통해 구현하는 것을 프로토콜 초기구현이라고 한다.


/*// Code. 익스텐션을 통한 프로토콜의 실제 구현
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

extension Receiveable {
    // 메시지를 수신합니다.
    func received(data: Any, from: Sendable) {
        print("\(self) received \(data) from \(from)")
    }
}

// 무언가를 발신할 수 있는 기능
protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

extension Sendable {
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
    var from: Sendable {
        return self
    }
    
    // 메시지를 발신한다.
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no reveiver")
            return
        }
        
        // 수신 가능한 인스턴스의 received 메서드를 호출한다.
        receiver.received(data: data, from: self.from)
    }
    
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
        }
    }

// 수신, 발신이 가능한 Message 클래스
class Message: Sendable, Receiveable {
    var to: Receiveable?
}

/*// 수신, 발신이 가능한 Mail 클래스
class Mail: Sendable, Receiveable {
    var to: Receiveable?
}*/

// 두 Message 인스턴스를 생성한다.
let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

// Mail 인스턴스를 두개 생성한다.
let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi")

// Message와 Mail 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있다.
myMail.to = yourMail
myMail.send(data: "Hi")

myMail.to = myPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable 프로토콜을 준수하지 않는다.
Message.isSendableInstance("Hello")

// Message와 Mail은 Sendable 프로토콜을 준수한다.
Message.isSendableInstance(myPhoneMessage)

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상황이다.
Message.isSendableInstance(yourPhoneMessage)
Mail.isSendableInstance(myPhoneMessage)
Mail.isSendableInstance(myMail)

// '프로토콜을 정의할 때'는 요구사항을 정의만 할 수 있지, 프로토콜을 채택한 타입에서 구현해주어야 하는 프로토콜의 요구사항을 구현할 수 없다.
// 그러나, '프로토콜의 익스텐션'에서는 프로토콜이 요구하는 기능을 실제로 구현해줄 수 있다.
// 다만, 익스텐션에는 저장 프로퍼티를 구현할 수 없으므로 저장프로퍼티는 각각의 타입에서 직접 구현해주어야 한다.
// 프로토콜과 익스텐션을 결합하면 '코드의 재사용성'이 월등하게 증가한다.

// 만약 프로토콜의 익스텐션에서 구현한 기능을 사용하지 않고 타입의 특성에 따라 변형하여 구현하고 싶다면
// 프로토콜을 재정의하면 된다.

// Code. 익스텐션을 통해 구현된 메서드 재정의
class Mail: Sendable, Receiveable {
    var to: Receiveable?
    
    func send(data: Any) {
        print("Mail의 send 메서드는 재정의되었습니다.")
    }
}
let mailInstance: Mail = Mail()
mailInstance.send(data: "Hello")*/

// 특정 프로토콜을 준수하는 타입에 프로토콜의 요구사항을 찾아보고 이미 구현되어져있다면 그 기능을 호출하고,
// 그렇지 않다면 프로토콜 초기구현의 기능을 호출한다.
// 특정 타입이 아니라 다른 타입을 오가며 사용할 수 있도록 제네릭, 프로토콜, 익스텐션을 적절하게 융합하여 재사용을 해보도록 한다.

/*// Code. 제네릭, 프로토콜, 익스텐션을 통한 재사용 가능한 코드 작성
protocol SelfPrintable {
func printSelf()
}

extension SelfPrintable where Self: Container {
    func printSelf() {
        print(items)
    }
}

protocol Container: SelfPrintable {
    associatedtype ItemType // 연관 타입을 활용하여 타입 매개변수의 역할을 프로토콜에서 실행할 수 있도록 만들었다.

    
    var items: [ItemType] { get set }
    var count: Int { get }
    
    mutating func append(item: ItemType)
    subscript(i: Int) -> ItemType { get }
}

extension Container {
    mutating func append(item: ItemType) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> ItemType {
        return items[i]
    }
}

protocol Popable: Container { // Container 프로토콜을 상속받음
    mutating func pop() -> ItemType?
    mutating func push(_ item: ItemType)
}

extension Popable {
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }

    mutating func push(_ item: ItemType) {
        self.append(item: item)
    }
}

protocol Insertable: Container { // Container 프로토콜을 상속받음
    mutating func delete() -> ItemType?
    mutating func insert(_ item: ItemType)
}

extension Insertable {
    mutating func delete() -> ItemType?{
    return items.removeFirst()
}

mutating func insert(_ item: ItemType) {
    self.append(item: item)
    }
}

struct Stack<Element>: Popable {
    var items: [Element] = [Element]()
}

struct Queue<Element>: Insertable {
    var items: [Element] = [Element]()
}


/// Stack 구조체 구현부 외부
var myIntStack: Stack<Int> = Stack<Int>()
var myStringStack: Stack<String> = Stack<String>()
var myIntQueue: Queue<Int> = Queue<Int>()
var myStringQueue: Queue<String> = Queue<String>()

myIntStack.push(3)
myIntStack.printSelf()

myIntStack.push(2)
myIntStack.printSelf()

myIntStack.pop()
myIntStack.printSelf()

myStringStack.push("A")
myStringStack.printSelf()

myStringStack.push("B")
myStringStack.printSelf()

myStringStack.pop()
myStringStack.printSelf()

myIntQueue.insert(3)
myIntQueue.printSelf()

myIntQueue.insert(2)
myIntQueue.printSelf()

myIntQueue.delete()
myIntQueue.printSelf()

myStringQueue.insert("A")
myStringQueue.printSelf()

myStringQueue.insert("B")
myStringQueue.printSelf()

myStringQueue.delete()
myStringQueue.printSelf()

// 스위프트의 클래스는 다중상속을 지원하지 않기 때문에
// 부모클래스의 기능으로 부족하다면 자식클래스에서 다시 구현해야 한다.
// 프로토콜 초기구현을 한 프로토콜을 채택하였다면 상속도 추가 구현도 필요 없다.
// 초기구현을 한 프로토콜만 채택한다면 추가 기능을 구현할 수 있다.

/*// Code. 스위프트 표준 라이브러리의 Array 정의
public struct Array<Element> : RandomAccessCollection, MutableCollection {
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<[Element]>
    
    public var startIndex: Int { get }
    public var endIndex: Int { get }
    
    public func index(after i: Int) -> Int
    public func formIndex(after i: inout Int)
    public func index(before i: Int) -> Int
    public func formIndex(before i: inout Int)
    public func index(_ i: Int, offsetBy n: Int) -> Int
    중략 ...
    }*/
*/

// 23.2 맵, 필터, 리듀스 직접 구현해보기
// 1. 맵 : 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후에 다시 컨테이너에 포장하여 반환하는 함수
// 2. 필터 : 컨테이너 내부의 값을 '걸러서 추출'해 '새로운 컨테이너'에 '값을 담아 반환'하는 함수.
// 3. 리듀스 : '컨테이너 내부의 콘텐츠를 하나로 합쳐주는 기능'을 실행하는 함수.

/*// Code. Array 타입의 맵 사용
let items: Array<Int> = [1, 2, 3]

let mappedItems: Array<Int> = items.map { (item: Int) -> Int in
return item * 10
}

print(mappedItems)

// Code. Stack 구조체의 맵 메서드

/// Stack 구조체 구현부

func map<T>(transform: (Element) -> T) -> Stack<T> {
    var transformedStack: Stack<T> = Stack<T>()
    
    for item in items {
        transformedStack.items.append(transform(item))
    }
    
    return transformedStack
}
 // Stack 구조체 구현부 외부
 var myIntStack: Stack<Int>  = Stack<Int>()
 // Int 타입을 자신의 요소로 갖는 Stack에 맵 메서드를 호출하여 새로운 Stack을 반환받았다.
 myIntStack.push(1)
 myIntStack.push(1)
 myIntStack.push(1)
 myIntStack.printSelf()
 var myStrStack: Stack<String> = myIntStack.map{ "\($0)" }
 myStrStack.printSelf()

/*// Code. Array 타입의 필터 사용
let filteredItems: Array<Int> = items.filter { (item: Int) -> Bool in
return item % 2 == 0
}

print(filteredItems)*/


/*// Code. Stack 구조체의 필터 메서드
/// Stack 구조체 구현부
func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
    var filteredStack: Stack<ItemType> = Stack<ItemType>()

    for item in items {
        if includeElement(item) {
            filteredStack.items.append(item)
        }
}

return filteredStack
}

/// Stack 구조체 구현부 외부
let filteredStack: Stack<Int> = myIntStack.filter { (item: Int) -> Bool in
return item < 5
}

filteredStack.printSelf()
*/
*/
/*// Code. Array 타입의 리듀스 사용
let combinedItems: Int = items.reduce(0) { (result: Int, item: Int) -> Int in
    return result + item
}

print(combinedItems)

let combinedItemsDoubled: Double = items.reduce(0.0) { (result:
    Double, item: Int) -> Double in
    return result + Double(item)
}

print(combinedItemsDoubled)

let combinedItemsString: String = items.reduce(""){ (result: String, item: Int) -> String in return result + "\(item) "
}

print(combinedItemsString)*/

/*// Code. Stack 구조체의 리듀스 메서드
/// Stack 구조체 구현부
func reduce<T>(_ initial: T, combine: (T, Element) -> T) -> T {
    var result: T = initial

    for item in items {
    result = combine(result, item)
}

return result
}

/// Stack 구조체 구현부 외부
let combinedInt: Int = myIntStack.reduce(100) { (result: Int, item: Int) ->
Int in
return result + item
}

print(combinedInt)

let combinedDouble: Double = myIntStack.reduce(100.0) { (result:
    Double, item: Int) -> Double in
return result + Double(item)
}

print(combinedDouble)

let combinedString: String = myIntStack.reduce("") { (result: String, item: Int) -> String in return result + Double(item)
}

print(combinedDouble)

let combinedString: String = myIntStack.reduce("") { (result: String, item: Int) -> String in return result + "\(item)"
}

print(combinedString)*/

// 23.3 기본 타입 확장
// Code. SelfPrintable 프로토콜의 초기구현과 기본 타입의 확장
protocol SelfPrintable {
func printSelf()
}

extension SelfPrintable {
    func printSelf() {
        print(self)
    }
}

extension Int: SelfPrintable { }
extension String: SelfPrintable { }
extension Double: SelfPrintable { }

1024.printSelf()
3.14.printSelf()
"hana".printSelf()

