import UIKit

//chapter 7 함수
//스위프트에서 함수는 일급 객체이기 때문에 하나의 값으로도 사용할 수 있다.


//7.1 함수와 메서드
//함수와 메서드는 기본적으로 같다. 상황이나 위치에 따라 다르게 불리는 것 뿐이다.
//구조체, 클래스, 열거형 등 특정 타입에 연관되어 사용하는 함수를 '메서드'라고 불리고, 모듈 전체에서 전체적으로 사용하는 함수를 그냥 '함수'라고 부른다.

//7.2 함수의 정의와 호출
// 함수와 메서드는 정의하는 위치와 호출되는 범위만 다를 뿐, 정의하는 키워드와 구현하는 방법은 같다.
//스위프트에서의 함수는 override(재정의)와 overroad(중복 정의)를 모두 지원하기 때문에 매개변수의 타입이 다르면 같은 이름의 함수를 여러 개 만들 수 있고, 매개변수의 개수가 달라도 같은 이름의 함수를 만들 수 있다.

//7.2.1 기본적인 함수의 정의와 호출



// 기본 형태의 함수 정의와 사용
func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny)


//7.2.2 매개변수
//함수에 매개변수가 필요 없다면 매개변수 위치를 공란으로 비워둔다

func helloWorld() -> String {
    return "Hello, world!"
}

print(helloWorld())


// 매개변수가 여러 개인 함수의 정의와 사용
func sayHello(myName: String, yourName: String) -> String {
    return "Hello \(yourName)! I'm \(myName)"
}

print(sayHello(myName: "yagom", yourName: "Jenny"))


// 매개변수 이름과 전달인자 레이블을 가지는 함수 정의와 사용
//from과 to라는 전달인자 레이블이 있으며
//myName과 name이라는 매개변수 이름이 있는 sayHello1 함수

func sayHello1(from myName:String, to name:String) -> String {
    return "Hello \(name)! I'm \(myName)"
}

print(sayHello1(from:"yagom", to: "Jenny"))

// 전달인자 레이블이 없는 함수 정의와 사용
func sayHello2(_ name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello2("Chope", 2))


// 전달인자 레이블 변경을 통한 함수 중복 정의

func sayHello3(to name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

func sayHello3(to name: String, repeatCount times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello3(to: "Chope", 2))
print(sayHello3(to: "Chope", repeatCount: 2))

// 매개변수 기본값이 있는 함수의 정의와 사용
//times 매개변수가 기본값 3을 갖는다.

func sayHello4(_ name: String, times: Int = 3) -> String {
    var result: String = " "
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    return result
}

//times 매개변수의 전달 값을 넘겨주지 않아 기본값 3을 반영해서 세 번 출력
print(sayHello4("Hana"))

//times 매개변수의 전달 값을 2로 넘겨주었기 때문에 전달 값을 반영하여 두 번 출력
print(sayHello4("Joe", times: 2))


// 가변 매개변수와 입출력 매개변수
// 함수마다 가변 매개변수는 하나만 가질 수 있습니다.
func sayHelloToFriends(me: String, friends names: String...) -> String {
    var result: String = ""
    
    for friend in names {
        result += "Hello \(friend)!" + " "
    }
    
    result += "I'm " + me + "!"
    return result
}
    
    print(sayHelloToFriends(me: "yagom", friends: "Johnsson", "Jay", "Wizplan"))
    //Hello Johanson! Hello Jay! Hello Wizplan! I'm yagom!
    
    print(sayHelloToFriends(me: "yagom"))

// inout 매개변수의 활용

var numbers: [Int] = [1,2,3]

func nonReferenceParameter(_ arr: [Int]) {
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]) {
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1])

referenceParameter(&numbers)
print(numbers[1])

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}


var yagom: Person = Person()

// 참조 타입의 inout 매개변수 사용은 더욱 주의하여야 한다.
// 사용 방법에 따라 기존 참조 매개변수처럼 동작하기도 하고, 참조 자체가 변경되어지기도 한다.
func reference(_ person: inout Person) {
    person.height = 130
    print(yagom.height)
    person = Person()
}

reference(&yagom)
yagom.height // 함수 안에서 새로운 인스턴스가 할당되었기 때문에 reference안에 있는 print구문에서와는 다른 참조 값을 갖는다.

// 7.2.3 반환 타입

// 반환 값이 없는 함수의 정의와 사용
func sayHelloWorld() {
    print("Hello, world!")
}
sayHelloWorld()

func sayHello(from myName: String, to name: String) {
    print("Hello \(name)! I'm \(myName)")
}

sayHello(from: "yagom", to: "Mijeong")

func sayGoodbye() -> Void {
    print("Good bye")
}
sayGoodbye()

// 7.2.4 데이터 타입으로서의 함수
// 각 함수는 매개변수 타입과 반환 타입으로 구성된 하나의 타입으로 사용할 수 있다.

// 함수를 데이터타입으로 사용할 수 있다는 것은 함수를 전달인자로 받을 수도, 반환 값으로 돌려줄 수도 있다는 의미이다.

// 함수 타입의 사용
typealias CalculateTwoInts = (Int, Int) -> Int
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
print(mathFunction(2,5))

mathFunction = multiplyTwoInts
print(mathFunction(2,5))

func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int){
    print("Result: \(mathFunction(a,b))")
}
printMathResult(addTwoInts, 3, 5)

func chooseMathFunction(_ toAdd: Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5)

//함수를 리턴한다는 것 자체만으로도 스위프트가 함수를 일급 객체로 여기는 것의 장점이다.

// 7.3 중첩 함수

typealias MoveFunc = (Int) -> Int

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }
    
    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft : goRight
}

var position: Int = -4

//현 위치가 0보다 작기 때문에 전달되는 인자 값은 false가 된다.
// goRight함수가 할당되어진다.

let moveToZero: MoveFunc = functionForMove(position > 0)
//원점에 도착하게 되면 반목문은 종료된다.
while position != 0 {
    print("\(position)...")
    position = moveToZero(position)
}
print("원점 도착!")


// 7.4 종료되지 않는 함수
// 비반환 함수의 정의와 사용

func crashAndBurn() -> Never {
    fatalError("Something very, very bad happend")
}

//crashAndBurn() // 프로세스가 종료된 이후 오류 보고

func someFunction(isAllIsWell: Bool){
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다!")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(isAllIsWell: true)
//someFunction(isAllIsWell: false)


// 7.5 반환 값을 무시할 수 있는 함수

//@discardableResult 선언 속성 사용

func say(_ something: String) -> String {
    print(something)
    return something
}

@discardableResult func discadableResultSay(_ something: String) -> String {
    print(something)
    return something
}

// 반환 값을 사용하지 않았으므로 컴파일러가 경고를 표시할 수 있다.
say("hello")

// 바로 위의 코드에서 반환 값을 사용하지 않을 수 있다고 미리 경고하였기 때문에, 반환 값을 사용하지 않아도 컴파일러가 경고하지 않는다.
discadableResultSay("hello")

