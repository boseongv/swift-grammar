
import UIKit
// Chapter 28 오류처리
var str = "Hello, playground"
/*
// 28.1 오류처리란
// 오류처리는 프로그램이 오류를 일으켰을 때 감지하고 회복시키는 일련의 과정.
// 오류처리 기능을 통해 상황들을 구별하여 프로그램 자체적으로 오류를 해결할 수 잇고, 사용자와 상호작용을 통해 오류를 어떤 방향으로 풀어나갈지 제어할 수 있다.

// 28.2 오류의 표현
// 스위프트에서 오류는 Error라는 프로토콜을 준수하는 타입의 값을 통해 표현된다.

/*// Code. 자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeed: Int)
    case outOfStock
}*/
// 오류의 종류를 미리 예상한 다음, 오류 때문에 다음에 행할 동작이 정상적으로 진행되지 않을 때라면 오류를 던져주면 된다.
// 오류를 던져줄 때에는 throw 구문을 사용한다.

// 28.3 오류 포착 및 처리
// 오류를 던질 수도 있지만 오류가 던져지는 것에 대비하여 던져진 오류를 처리하기 위한 코드를 작성해야 한다.

// 스위프트에는 오류를 처리하기 위한 네 가지 방법이 있다.
// 1. 함수에서 발생한 오류를 해당 함수를 호출한 코드에 알리는 방법
// 2. do-catch 구문을 이용하여 오류를 처리하는 방법
// 3. 옵셔널 값으로 오류를 처리하는 방법
// 4. 오류가 발생하지 않을 것이라고 확신하는 방법

// 28.3.1 함수에서 발생한 오류 알리기
// 함수, 메서드, 이니셜라이저의 매개변수 뒤에 throws 키워드를 사용하면 해당 함수, 메서드, 이니셜라이저는 오류를 던질 수 있다.

// Code. 자판기 동작 도중 발생한 오류 던지기
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Biscuit": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws {
        // 오류를 던질 수 있는 vend(itemNamed:) 메서드
        guard let item = self.inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        // vend(itemNamed:) 메서드 내부에서는 오류가 발생했을 때 흐름을 제어하기 위해 guard를 통해 빠른종료 구문을 사용.
        // 특정 조건이 충족되지 않는다면 throws키워드를 사용하여 오류를 던져서 오류가 발생하였다는 것을 자신을 호출한 코드에게 알린다.
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= self.coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeed: item.price - self.coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventory[name] = newItem
        
        self.dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom": "Chips",
    "jinsung": "Biscuit",
    "heejin": "Chocolate"
]

/*func buyFavoriteSnack(person: String, vendingMachine: VendingMachine)
    throws {
        // throws 키워드를 통한 오류를 던질 수 있는 함수로 만듦.
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 30

var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)

print(purchase.name)

for(person, favoriteSnack) in favoriteSnacks {
    print(person, favoriteSnack)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}*/

// 28.3.2 do-catch 구문을 이용하여 오류처리
// 함수, 메서드, 이니셜라이저등에서 오류를 던져주면 오류를 전달받은 코드 블록은 do-catch 구문을 사용하여 오류를 처리해주어야 한다.

// Code. do-catch 구문을 사용하여 던져진 오류를 처리
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    tryingVend(itemNamed: snackName, vendingMachine: vendingMachine)

}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) {
        tryingVend(itemNamed: name, vendingMachine: vendingMachine)
        self.name = name
    }
}

func tryingVend(itemNamed: String, vendingMachine: VendingMachine) {
    do{
        try vendingMachine.vend(itemNamed: itemNamed)
    } catch VendingMachineError.invalidSelection {
        print("유효하지 않은 선택")
    } catch VendingMachineError.outOfStock {
        print("품절")
    } catch VendingMachineError.instufficientFunds(let coinsNeeded) {
        print("자금 부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
    } catch {
        print("그 외 오류 발생 : ", error)
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 20
var purchase: PurchasedSnack = PurchasedSnack(name: "Biscuit", vendingMachine: machine)
// Biscuit 제공

print(purchase.name)

purchase = PurchasedSnack(name: "Ice Cream", vendingMachine: machine)
// 유효하지 않은 선택

print(purchase.name)

for(person, favoriteSnack) in favoriteSnacks {
    print(person, favoriteSnack)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}*/

// 28.3.3 옵셔널 값으로 오류처리
// try?를 사용하여 옵셔널 값으로 변환하여 오류를 처리한다.

/*// Code. 옵셔널 값으로 오류를 처리
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
        enum SomeError: Error {
case justSomeError
}

        throw SomeError.justSomeError
}

return 100
}

let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x) // 호출한 함수가 오류를 던지면 nil값을 반환.

let y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y) // 호출한 함수가 오류를 던지지 않으면 Optional로 처리.


//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() {
//        return data
//    }
//    if let data = try? fetchDataFromServer() {
//        return data
//    }
//    return nil
//  // 반환타입을 옵셔널로 정한 이유는 함수 내부에서 제대로 처리가 이루어지지 않으면 반환값을 nil로 준다.
//}*/

// 28.3.4 오류가 발생하지 않을 것이라고 확신하는 방법
// try! 표현을 쓰면 실제 오류가 발생하였을 때 런타임 오류가 발생하여 프로그램이 강제로 종료된다.
/*// Code. 오류가 발생하지 않음을 확신하여 오류처리
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
        enum SomeError: Error {
case justSomeError
}

throw SomeError.justSomeError
}

return 100
}

let y: Int = try! someThrowingFunction(shouldThrowError: false)
print(y)

let x: Int = try! someThrowingFunction(shouldThrowError: true)*/


// 28.3.5 다시던지기
// 함수나 메서드는 rethrows 키워드를 사용하여 자신의 매개변수로 전달받은 함수가 오류를 던진다는 것을 알 수 있다.
// rethrows 키워드를 사용하여 다시 던지기가 가능하게 하려면 최소 하나 이상의 오류 발생이 가능한 함수를 매개변수로 전달받아야 한다.


/*// Code. 오류의 다시던지기
// 오류를 던지는 함수
func someThrowingFunction() throws {
    enum SomeError: Error {
        case justSomeError
}

throw SomeError.justSomeError
}

// 다시던지기 함수
func someFunction(callback: () throws -> Void) rethrows {
try callback()
}

do {
try someFunction(callback: someThrowingFunction)
} catch {
print(error)
}*/

/*// Code. 다시던지기 함수의 오류 던지기
// 오류를 던지는 함수
func someThrowingFunction() throws {
    enum SomeError: Error {
        case justSomeError
}

    throw SomeError.justSomeError
}
// 다시던지기 함수
func someFunction(callback: () throws -> Void) rethrows {
    enum AnotherError: Error {
        case justAnotherError
}

    do {
    // 매개변수로 전달한 오류 던지기 함수이므로 catch 절에서 제어할 수 있다.
    try callback()
    } catch {
throw AnotherError.justAnotherError
}

    do {
    try someThrowingFunction()
    } catch {
throw AnotherError.justAnotherError
}

// catch 절 외부에서 단독으로 오류를 던질 수는 없다.
throw AnotherError.justAnotherError
}*/

/*// Code. 프로토콜과 상속에서 던지기 함수와 다시던지기 함수
protocol SomeProtocol {
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows
}

class SomeClass: SomeProtocol {
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws { }
    func someFunction(callback: () throws -> Void) rethrows { }

    // 던지기메서드는 다시던지기 메서드를 요구하는 프로토콜을 충족할 수 없다.
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows {
}
    // 다시던지기 메서드는 던지기 메서드를 요구하는 프로토콜의 요구사항에 부합하다.
    func someThrowingFunctionFromProtocol(callback: throws -> Void) rethrows { }
}
class SomeChildClass: SomeClass {
// 부모클래스의 던지기 메서드는 자식클래스에서 다시던지기 메서드로 재정의할 수 있다.
    override func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws { }

    // 부모클래스의 다시던지기 메서드는 자식클래스에서 던지기 메서드로 재정의할 수 없다.
    // 오류 발생
    override func someFunction(callback: () throws -> Void) throws { }
}*/

// 28.3.6 후처리 defer
// defer 구문을 사용하면 코드가 블록을 어떤 식으로 빠져나가든 간에 꼭 실행해야 하는 작업이다. (무조건 실행해야하는 구문)

/*// Code. 파일쓰기 예제에서 defer 구문 활용
func writeData() {
let file = openfile()

// 함수 코드 블록을 빠져나가기 직전 무조건 실행되어 파일을 잊지 않고 닫아준다.
    defer {
        closeFile(file)
}

    if ... {
        return
    }
    
    if ... {
        return
    }
 
    // 처리 끝
}*/

// defer 구문이 없었다면 중복된 코드가 많아질 것이고, 차후 유지관리가 어려울뿐더러 코드가 길어지다보면 프로그래머가 파일닫기 코드를 닫지 않는 실수를 할 가능성이 높아진다.

/*// Code. 파일닫기 예제에서 defer 구문이 없다면
func writeData() {
let file = openFile()

    if ... {
    closerFile(file)
    return
}
    
    if ... {
        closeFile(file)
        return
    }
    
    closeFile(file)
    // 처리 끝
}*/

// defer 구문 내부에는 break, return 등과 같이 구문을 빠져나갈 수 있는 코드 또는 오류를 던지는 코드는 작성하며 안된다.
// 여러 개의 defer 구문이 하나의 블록 내부에 속해 있다면 맨 마지막에 작성된 구문부터 역순으로 실행된다.

// Code. defer 구문의 실행 순서
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    defer {
        print("First")
}

    if shouldThrowError {
        enum SomeError: Error {
    case justSomeError
    }

    throw SomeError.justSomeError
}

    defer {
    print("Second")
    }

    defer {
        print("Third")
    }

    return 100
}

try? someThrowingFunction(shouldThrowError: true)

try? someThrowingFunction(shouldThrowError: false)

// Code. 복합적인 defer 구문의 실행순서
func someFunction() {
print("1")

    defer {
    print("2")
}
    do {
        defer {
            print("3")
        }
        print("4")
    }
    
    defer {
        print("5")
    }
    
    print("6")
}
someFunction()
