import UIKit
// Chapter 22. 제네릭

// 제네릭을 이용하여 코드를 구현하면 어떤 타입에도 유연하게 대응할 수 있다.
// 제네릭으로 구현한 기능과 타입은 재사용하기도 쉽고, 코드의 중복을 줄일 수 있기 때문에 깔끔하고 추상적인 표현이 가능하다.

/*// Code. 제네릭, 프로토콜, 서브스크립트 등 다양한 기능으로 구현된 Array 타입 선언부
public struct Array<Element> : RandomAccessCollection, MutableCollection {
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<[Element]>.Element
    // 중략 ...
    public var startIndex: Int { get }
    public var endIndex: Int { get }
    // 중략 ...
    public subscript(index: Int) -> Element
    public subscript(bounds: Range<Int>) -> ArraySlice<Element>.ArrayLiteralElement
    // 중략 ...
    public mutating func popLast() -> Element?
    // 중략 ...
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    // 중략 ...
    public var last: Element? { get }
    // 중략 ...
    public func reduce<Result>(_ initialResult: Result, _nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
}*/

/*// Code. 전위 연산자 구현과 사용
prefix func **(value: Int) -> Int {
return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)
*/
// 사용자 연산자인 **는 조금 한정된 범위인 Int타입에서만 사용할 수 있다.
// UInt 타입, 즉 부호가 없는 정수 타입에서는 Int 타입에 구현해준 사용자정의 연산자를 사용하지 못한다.

// 위와 같은 한계점이 있기에, 조금 더 넓게 사용할 수 있게 '정수의 제곱을 구하는 연산자'를 구현해보도록 한다.
// 프로토콜과 제네릭을 조합하여 정수 타입 프로토콜, 즉 BinaryInteger 프로토콜에 해당하는 값이면 해당 연산자를 사용할 수 있도록 제네릭을 이용하여 구현하게 된다면 UInt 타입에서도 해당 연산자를 사용할 수 있다.

/*// Code. 프로토콜과 제네릭을 이용한 전위 연산자 구현과 사용
prefix operator **

prefiz func **<T: BinaryInteger> (value: T) -> T {
return value * value
}

let minusFive: Int = -5
let five: UInt = 5

let sqrtMinusFive: Int = **minusFive
let sqrtFive: UInt = **five

print(sqrtMinusFive)
print(sqrtFive)
*/
/*// Code. 제네릭을 사용하지 않은 swapTwoInts(_:_:) 함수
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA: Int = a
    a = b
    b = temporaryA
}
var numberOne: Int = 5
var numberTwo: Int = 10

swapTwoInts(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")

// 제네릭을 사용하지 않은 swapTwoInts(_:_:)함수는 두 Int 타입의 변숫값을 교환하는 역할을 충분히 해낼 수 있다.
// 하지만, 만약 Int 타입이 아닌 Double이나 String 타입의 변숫값을 교환해야 하는 상황이라면 별도의 함수를 다시 구현하여야 한다는 불편함이 있다.*/

/*// Code. 제네릭을 사용하지 않은 swapTwoStrings(_:_:)함수
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA: String = a
    a = b
    b = temporaryA
}

var stringOne: String = "A"
var stringTwo: String = "B"

swapTwoStrings(&stringOne,&stringTwo)

print("\(stringOne), \(stringTwo)")

// 이 함수도 두 String 타입의 변수끼리 값을 교환하는 역할은 하지만, String 타입끼리의 교환만 허용한다.
// Double 타입의 값 교환을 원한다면 또 다른 함수를 구현해야 한다.
// 그리고, 타입마다 다른 함수를 써줘야 한다는 불편함이 있다.*/

// Any를 사용하여도 문제가 생기는지 코드를 하나 더 작성해보겠다.
/*// Code. 제네릭을 사용하지 않은 swapTwoValues(_:_:)함수
func swapTwoValues(_ a: inout Any, _ b: inout Any) {
    let to temporaryA: Any = a
    a = b
    b = temporaryA
}
var anyOne: Any = 1
var anyTwo: Any = "Two"

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")

anyOne = stringOne
anyTwo = stringTwo

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")
print("\(stringOne), \(stringTwo)")

swapTwoStrings(&stringOne, &stringTwo)
*/
// Any타입의 두 변수에 어떤 타입의 값이 들어있을지 모르는것이 문제이다. 예를 들면 Int면 Int끼리, String은 String끼리 교환하고 싶은데 그런 제한을 줄 수 없다는 것이 문제이다.
// Any 타입의 inout 매개변수를 통해 전달될 전달인자는 Any 타입으로만 전달되어야 한다.
// 다른 타입인 String 타입의 변수인 stringOne, stringTwo는 전달인자로 전달할 수가 없다.
// 그래서 String 타입의 값을 Any 타입의 새로운 변수를 만들어 그 변수에 값을 넣어 함수를 호출해야 하는데, 그 순간 값은 복사되어 할당되어진다.
// 새로운 변수로만 함수를 호출할 수 있으므로 처음에 원하던 stringOne과 stringTwo의 값은 교환할 수가 없는 것이다.

// 22.1 제네릭 함수
// 앞서 작성하였던 코드들은 같은 타입의 두 변수만 교환이 가능했는데, 제네릭 함수를 사용하면 그 문제를 해결할 수 있다.

// Code. 제네릭을 사용한 swapTwoValues(_:_:)함수
/*func swapTwoValues<T>(_ a: inout T, _b: inout T) {
    let temporaryA: T = a
    a = b
    b = temporaryA
}

swapTwoValues(&numberOne, _b: &numberTwo)
print("\(numberOne), \(numberTwo)")

swapTwoValues(&stringOne, _b: &stringTwo)
print("\(stringOne), \(stringTwo)")

swapTwoValues(&anyOne, _b: &anyTwo)
print("\(anyOne), \(anyTwo)")

swapTwoValues(&numberOne, _b: &stringOne)*/
// 제네릭 함수는 실제 타입 이름(Int, String 등)을 써주는 대신에 플레이스홀더( 위 함수의 T )를 사용한다.
// 플레이스홀더는 타입의 종류를 알려주지는 않지만 말 그대로 어떤 타입이라는 것을 알려준다.
// 매개변수로 플레이스홀더 타입이 T인 두 매개변수가 있으므로, 두 매개변수는 같은 타입이라는 정도를 알려준다.
// T의 실제 타입은 함수가 호출되는 순간부터 결정되므로, Int 타입의 변수가 전달인자로 전달되었다면 T는 Int가 되고, Sting 타입의 변수로 전달되었다면 T는 String이 된다.
// T가 플레이스홀더로 사용되기 때문에 스위프트 컴파일러는 함수의 문법을 검사할 때, T의 실제 타입을 신경쓰지 않는다.

// 22.2 제네릭 타입
// 제네릭 타입을 구현하면 사용자 정의 타입인 구조체, 클래스, 열거형 등이 어떤 타입과도 연관되어 동작할 수 있다.

/* // Code. 제네릭을 사용하지 않은 IntStack 구조체 타입
struct IntStack {
var items = [Int]()
    mutating func push(_ item: Int) {
items.append(item)
}
    mutating func pop() -> Int {
return items.removeLast()
}
}
var integerStack: IntStack = IntStack()

integerStack.push(3)
print(integerStack.items)

integerStack.push(2)
print(integerStack.items)

integerStack.push(3)
print(integerStack.items)

integerStack.push(5)
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)
 */

// IntStack 타입은 Int 타입을 요소로 가질 수 있는 간단한 스택 기능을 구현하는 구조체 타입이다.
// 내부에 items라는 이름의 Int 타입 배열을 가짐으로써, Int 타입의 요소들을 팝하고 푸시할 수 있는 기능이 구현되어진다.

// 이제, 모든 타입을 대상으로 푸시 팝을 동작하는 스택 기능을 구현해본다.
// 모든 타입을 대상으로 한다고 해서 모든 타입이 섞여서 들어온다는 것이 아니라 (만약 요소로 모든 타입을 수용하려고 하면 items 배열의 타입을 Any로 지정해주기만 하면 된다) "스택의 요소로 한 타입을 지정해주면 그 타입으로 계속 스택이 동작하여야 하고, 처음 지정해주는 타입은 스택을 사용하고자 하는 사람의 마음대로 지정할 수 있도록 제네릭을 사용"한다.

/*// Code. 제네릭을 사용한 Stack 구조체 타입
struct Stack<Element> {
    // Stack 구조체는 Int라는 타입 대신 Element라는 타입 매개변수를 사용하여, 그 타입에만 동작하도록 제한할 수 있기 때문에 더욱 안전하고, 의도한 대로 기능을 사용할 수 있다.
var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
}
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var doubleStack: Stack<Double> = Stack<Double>()

doubleStack.push(1.0)
print(doubleStack.items)
doubleStack.push(2.0)
print(doubleStack.items)
doubleStack.pop()
print(doubleStack.items)

var stringStack: Stack<String> = Stack<String>()

stringStack.push("1")
print(stringStack.items)
stringStack.push("2")
print(stringStack.items)
stringStack.pop()
print(stringStack.items)

var anyStack: Stack<Any> = Stack<Any>()

anyStack.push(1.0)
print(anyStack.items)
anyStack.push("2")
print(anyStack.items)
anyStack.push(3)
print(anyStack.items)
anyStack.pop()
print(anyStack.items)

// 22.3 제네릭 타입 확장
// 익스텐션을 통해 제네릭을 사용하려는 타입에 기능을 추가하고 싶다면(확장하고 싶다면) 익스텐션을 정의할 때 타입 매개변수를 별도로 명시하지 않아도 된다.
// Code. 익스텐션을 통한 제네릭 타입의 기능 추가
extension Stack {
    var topElement: Element? {
        return self.items.last
    }
}

print(doubleStack.topElement)
print(stringStack.topElement)
print(anyStack.topElement)*/


// 22.4 타입 제약
// 제네릭함수는 어떤 타입이든 제약없이 사용할 수 있는 장점이 있지만, 타입 매개변수가 가져야 할 제약사항을 지정할 수 있는 상황이 발생할 수 있다.
// 예를 들어 타입 매개변수 자리에 사용할 실제 타입이 특정 클래스를 상속 받은 타입이어야 한다던지, 특정 프로토콜을 준수하는 타입이어야 한다는 등의 제약을 줄 수 있다.
// 타입 제약은 클래스 타입 또는 프로토콜로만 줄 수 있다.
// 열거형, 구조체 등의 타입은 타입 제약의 타입으로 사용할 수 없다.
// 예를 들면, 자주 사용하는 제네릭 타입인 Dictionary의 키는 Hashable 프로토콜을 준수하는 타입만 사용할 수 있다.
/*// Code. Dictionary 타입 정의
public struct Dictionary<Key : Hashable, Value> : Collection, ExpressibleByDictionaryLiteral {
/*.....*/
}*/
// 코드를 보면 Dictionary의 두 타입 매개변수는 Key와 Value이다.
// Key 뒤에 콜론을 붙인 다음에 Hashable이라고 명시되어 있는데, 이는 타입 매개변수인 Key 타입은 Hashable 프로토콜을 준수하여야 한다는 뜻이다.
// 여기서 Hashable이란 정수 hash값을 제공하는 타입으로, Set또는 Dictionary의 Key로 Hashable을 준수하는 모든 타입을 사용할 수 있다.
// 이 프로토콜에는 유일한 제약사항이 있는데, 반드시 KeyType은 해쉬가능한 타입이어야 한다.
// 즉, 그 자체로 유일하게 표현이 가능한 방법을 제공해야 한다.
// 즉, Key로 사용할 수 있는 타입은 Hashable 프로토콜을 준수하는 타입이어야 한다는 것이다.
// 제네릭 타입에 제약을 주고 싶으면 타입 매개변수 뒤에 콜론을 붙인 후 원하는 클래스 타입 또는 프로토콜을 명시하면 된다.

/*// Code. 제네릭 타입 제약
func swapTwoValues<T: BinaryInteger>(_ a: inout T, _b: inout T) {
// 함수 구현
}

struct Stack<Element: Hashable> {
// 구조체 구현
}*/

/*// Code. 제네릭 타입 제약 추가
func swapTwoValues<T: BinaryInteger>(_ a: inout T,_ b: inout T) where T: FloatingPoint, T: Equatable {
// 함수 구현
}*/
// 위의 코드는 BinaryInteger, FloatingPoint, Equatable 세 가지 프로토콜을 다 준수하는 타입만이 사용할 수 있다.

// 타입 제약을 실제로 사용할 만한 코드를 작성해보겠다.
/*// Code. substractTwoValue 함수의 잘못된 구현
func substractTwoValue<T>(_ a: T, _b: T) -> T {
    return a - b
}
// 뺄셈을 하기 위해서는 T가 실제로 받아들일 수 있는 타입이 뺄셈 연산자를 사용할 수 있는 타입이어야 한다.*/

/*// Code. substractTwoValue 함수의 구현
func substractTwoValue<T: BinaryInteger>( _a: T, _b: T) -> T {
    return a - b
}*/

/*// Code.makeDictionaryWithTwoValue 함수의 구현
func makeDictionaryWithTwoValue<Key: Hashable, Value>(key: Key, value: Value) -> Dictionary<Key, Value> {
    // Key와 Value라는 타입의 매개변수가 있는데, 두 타입 매개변수의 제약조건이 다르다는 것을 알 수 있다.
    // 이처럼 타입 매개변수마다 제약조건을 달리해서 구현해줄 수 있다.
    let dictionary: Dictionary<Key, Value> = [key:value]
    return dictionary
}*/

// 22.5 프로토콜의 연관 타입
// 프로토콜을 정의할 때 연관 타입을 함께 정의하면 유용하다.
// 연관 타입은 프로토콜에서 사용할 수 있는 플레이스홀더 이름입니다.
// 즉, 제네릭에서는 어떤 타입이 들어올지 모를 때, 타입 매개변수를 통해
// '종류는 알 수 없지만, 어떤 타입이 여기에 쓰일 것이다'
// 라고 표현해주었다면 연관 타입은 타입 매개변수의 그 역할을 프로토콜에서 실행할 수 있도록 만들어진 기능이다.




 // Code. Container 프로토콜 정의
protocol Container {
    associatedtype ItemType
    // 연관 타입으로 ItemType을 정의하여 프로토콜 정의에서 타입 이름으로 활용한다.
    // ItemType을 연관 타입으로 정의한다는 것은 프로토콜 정의 내부에서 사용할 타입이 ' 그 어떤 것이라도 상관없지만, 하나의 타입임은 분명하다' 라는 의미이다.
    var count: Int { get }
    // 아이템 개수를 확인할 수 있도록 Int 타입 값을 갖는 count 프로퍼티를 구현해야 한다.
    mutating func append(_ item: ItemType)
    // 컨테이너의 새로운 아이템을 append(_:) 메서드를 통해 추가할 수 있어야 한다.
    subscript(i: Int) -> ItemType { get }
    // Int 타입의 인덱스 값으로 특정 인덱스에 해당하는 아이템을 가져올 수 있는 서브스크립트를 구현해야 한다.
}
// 위의 코드를 보면 컨테이너가 어떤 타입의 아이템을 저장해야 할 지에 대해서 언급하지 않는다.
 


// Code. MyContainer 클래스 정의
class MyContainer: Container {
    // MyContainer 클래스는 Container 프로토콜을 준수하기 위해서 필요한 것을 모두 갖추었다.
    var items: Array<Int> = Array<Int>()
    // 연관 타입인 ItemTyep 대신에 실제 타입인 Int 타입으로 구현해주었으며, 이것은 프로토콜의 요구 사항을 모두 충족하기 때문에 문제가 되지 않는다.
    
    var count: Int {
        return items.count
    }
    
    func append(_ item: Int) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// 실제 프로토콜 정의를 준수하기 위해 구현할 때는 ItemType을 하나의 타입으로 일관성있게 구현하면 된다.

// IntStack 구조체를 Container 프로토콜을 준수하도록 구현해보는 예제코드를 작성해본다.
// Code. IntStack 구조체의 Container 프로토콜 준수
struct IntStack: Container {
// 기존 IntStack 구조체 구현
var items = [Int]()
    mutating func push(_ item: Int) {
items.append(item)
}
    mutating func pop() -> Int {
return items.removeLast()
}

// Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: Int) {
        self.push(item)
}
    var count: Int {
        return items.count
}
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// IntStack 구조체는 Container 프로토콜을 채택하기 위해 append(_:) 메서드, count 프로퍼티, 서브스크립트를 구현했다.
// 다만 ItemType 대신 Int 타입을 사용하여 구현했다.

/*// Code.IntStack 구조체의 typealias 사용
struct IntStack: Container {
typealias ItemType = Int // ItemType를 어떤 타입으로 사용할지 조금 더 명확하게 해주기 위한 지정

// 기존 IntStack 구조체 구현
var items = [ItemType]()
    mutating func push(_ item: ItemType) {
items.append(item)
}
    mutating func pop() -> ItemType {
        return items.removeLast()
}

// Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: ItemType) {
        self.push(item)
}
    var count: ItemType {
        return items.count
}
    subscript(i: ItemType) -> ItemType {
        return items[i]
    }
}*/

// Code. Stack 구조체의 Container 프로토콜 준수
struct Stack<Element>: Container {
    // Container 프로토콜을 준수하기 위해 ItemType이라는 연관 타입 대신에 Element라는 타입 매개변수를 사용하였다.
// 기존 Stack<Element> 구조체 구현
var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }

// Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}


// 22.6 제네릭 서브스크립트
// 제네릭 함수(메서드)를 구현할 수 있었던 것처럼 서브스크립트도 제네릭을 활용하여 타입에 큰 제한없이 구현할 수 있다.
// 타입 제약 또한 마찬가지로 제네릭을 활용하는 타입에 사용할 수 있다.

// Code. Stack 구조체의 제네릭 서브스크립트 구현과 사용
extension Stack {
    subscript<Indices: Sequence>(indices: Indices) -> [ItemType]
        // Indices라는 타입의 종류를 알려주진 않지만 말 그대로 어떤 타입이라는 것을 알려주는 '플레이스 홀더'를 사용하여 매개변수를 제네릭하게 받아들일 수 있다.
        // 1. Indices는 Sequence 프로토콜을 준수하는 타입으로 제약이 걸어져있다.
      
        where Indices.Iterator.Element == Int {
              // 2. 또한, Indices 타입 Iterator의 Element 타입이 Int 타입이어야 하는 제약이 있다.
            
            // 서브스크립트는 이 Indices 타입이 indices라는 매개변수로 인덱스 값을 받아올 수 있다.
            // 결과적으로 indices 시퀀스의 인덱스 값에 해당하는 스택요소의 값을 배열로 반환하게 된다.
            var result = [ItemType]()
            for index in indices {
                result.append(self[index])
}
    return result
}
}

var integerStack: Stack<Int> = Stack<Int>()
integerStack.append(1)
integerStack.append(2)
integerStack.append(3)
integerStack.append(4)
integerStack.append(5)

print(integerStack[0...2])


