import UIKit
// Chapter 27. ARC
// 전달 하고 싶을 때마다 값을 복사하여 전달하는 값타입과는 달리, 참조 타입은 하나의 인스턴스가 참조를 통해 여러 곳에서 접근하기 때문에 적절한 시기에 메모리 해제를 해주지 않으면 메모리의 자원을 낭비하기 되어 성능 저하가 된다.
// ARC가 관리해주는 참조 횟수 계산은 구조체나 열거형은 값 타임이므로 해당하지 않고, 참조 타입인 클래스의 인스턴스에만 적용이 된다.


// 27.1 ARC란
// Automatic Reference Counting. 자동 참조 카운팅은 자동으로 메모리를 관리해주는 방식이므로 프로그래머가 메모리 관리에 신경을 덜 쓸 수 있기 때문에 편리한 기능이다.
// ARC는 더이상 필요하지 않은 클래스의 인스턴스를 메모리에서 해제해주는 방식으로 작동한다.
// ARC와 비슷한 기법으로는 자바나 다른 프로그래밍 언어에서 사용하는 가비지 컬렉션이라는 기법이 있다.
// 가장 큰 차이점으로는 참조를 카운팅 하는 시점이다.
// ARC는 컴파일과 동시에 언제 메모리가 해제되어야 할지를 결정하고, 가비지 컬렉션은 프로그램을 동작하면서 카운팅을 한다.
// ARC는 클래스의 인스턴스를 생성할 때마다 그 인스턴스에 대한 정보를 저장하기 위한 메모리 공간을 따로 할당한다. 그 메모리 공간에는 인스턴스 타입 정보와 함께 인스턴스와 관련된 저장 프로퍼티 값 등을 저장한다.
// 인스턴스가 더 이상 필요없는 상태가 되면 인스턴스가 차지하던 메모리 공간을 다른 용도로 활용할 수 있도록 ARC가 메모리에서 인스터스를 없앤다.
// 만약 더 사용해야 하는 인스턴스를 메모리에서 해제시킨다면 인스턴스와 관련된 프로퍼티에 접근하거나 인스턴스의 메모리를 호출할 수 없게 된다.
// 게다가 인스턴스에 강제로 접근하려고 하면 잘못된 메모리 접근으로 인해 강제 종료될 확률이 커진다.

// 27.2 강한참조
// 강한참조는 인스턴스가 계속해서 메모리에 남아있어야 하는 명분을 만들어 주기 위해 사용한다.
// 인스턴스는 참조 횟수가 0이 되는 순간 메모리에서 해제하게 된다.
// 인스턴스를 다른 인스턴스의 프로퍼티나 변수, 상수등에 할당할 때 강한 참조를 사용하게 되면 참조 횟수가 1 증가한다.
// 강한참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당해주면 원래 자신에게 할당되어 있던 인스턴스의 참조 횟수가 1 감소한다.
// 참조의 기본은 강한참조이므로 클래스 타입의 프로퍼티, 변수, 상수 등을 선언할 때 별도의 식별자를 명시하지 않으면 강한참조를 한다.

/*// Code. 강한참조의 참조 횟수 확인
class Person {
    let name: String
    
    init(name: String) {
    self.name = name
        print("\(name) is being initialized")
}
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "yagom") // 인스턴스의 참조횟수 1
reference2 = reference1 // 참조횟수 2
reference3 = reference1 // 참조횟수 3

reference3 = nil // 참조횟수 2
reference2 = nil // 참조횟수 1
reference1 = nil // 참조횟수 0

// 참조횟수가 0이 되는 순간 인스턴스는 ARC의 규칙에 의해 메모리에서 해제되고, 메모리가 해제되기 직전에 디이니셜라이저를 호출한다.

/*// Code. 강한참조 지역변수(상수)의 참조 횟수 확인
func foo() {
    let yagom: Person = Person(name: "yagom")
}
foo()

// Person 타입의 인스턴스는 이니셜라이저에 의해 생성된 후 yagom 상수에 할당할 때 참조횟수가 1이 된다.
// 그리고 강한참조 지역변수가 사용된 범위의 코드 실행이 종료되면 그 지역변수가 참조하던 인스턴스의 참조횟수가 1 감소한다.
// 그렇기 때문에 yagom 상수가 강한참조를 하던 인스턴스의 참조 횟수가 1 감소하여 인스턴스의 참조 횟수가 0이 된다.
// 인스턴스의 참조 횟수가 0이 되는 순간 인스턴스는 메모리에서 해제된다.*/

// Code. 강한참조 지역변수의 참조 횟수 확인과 전역변수
var globalReference: Person?

func foo(){
    let yagom: Person = Person(name: "yagom")
    
    globalReference = yagom
}
foo()

// 27.2.1 강한참조 순환 문제
// 강한참조 순환이란 인스턴스끼리 서로가 서로를 강한참조할 때를 말한다.
// Code. 강한참조 순환 문제
class Person {
    let name: String
    init(name: String) {
        self.name = name
}

    var room: Room? // 강한참조를 하는 Room? 타입의 저장 프로퍼티 room.

    deinit {
        print("\(name) is being deinitialized")
    }
}
class Room {
    let number: String
    
    init(number: String) {
        self.number  = number
    }
    
    var host: Person?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var yagom: Person? = Person(name: "yagom")
var room: Room? = Room(number: "505")

room?.host = yagom
yagom?.room = room

yagom = nil
room = nil

// Code. 강한참조 순환 문제를 수동으로 해결
var yagom: Person? = Person(name: "yagom")
var room: Room? = Room(number: "505")

room?.host = yagom
yagom?.room = room

yagom?.room = nil
yagom = nil

room?.host = nil

room = nil

// Code. 27.3 약한참조
// 약한참조는 강한참조와 달리 자신이 참조하는 인스턴스의 참조 횟수를 증가시키지 않는다.
// 참조 타입의 프로퍼티나 변수의 선언 앞에 weak 키워드를 써주면 그 프로퍼티나 변수는 자신이 참조하는 인스턴스를 약한참조한다.

// Code. 강한참조 순환 문제를 약한참조로 해결
class Room {
    let number: String
    
    init(number: String) {
        self.number = number
}

    weak var host: Person? // 강한참조 순환 문제를 해결하기 위해 약한참조를 하도록 weak 추가.

    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var yagom: Person? = Person(name: "yagom")
var room: Room? = Room(number: "505")

room?.host = yagom
yagom?.room = room

yagom = nil
print(room?.host)

room = nil
}*/

// 27.4 미소유참조
// 참조 횟수를 증가시키지 않고 참조할 수 있는 방법이다.
// 약한참조와 마찬가지로 미소유참조는 인스턴스의 참조 횟수를 증가시키지 않는다.
// 미소유참조는 약한참조와 다르게 자신이 참조하는 인스턴스가 항상 메모리에 존재할 것이라는 전제를 기반으로 한다.
// 즉, 자신이 참조하는 인스턴스가 메모리에서 해제되더라도 스스로 nil을 할당해주지 않는다.
// 미소유 참조는 옵셔널이나 변수가 아니어도 된다.

// 미소유 참조를 하면서 메모리에서 해제된 인스턴스에 접근하려고 하면 잘못된 메모리 접근을 하여 프로세스가 강제로 종료된다.
// 미소유참조는 참조하는 동안 해당 인스턴스가 메모리에서 해제되지 않으리라는 확신이 있을 때만 사용한다.

/*// Code. 미소유참조
class Person {
    let name: String
// 카드를 소지할 수도, 소지하지 않을 수도 있기 때문에 옵셔널로 정의한다.
    // 카드를 한 번 가진 후 잃어버리면 안되기 때문에 강한참조를 한다.
    var card: CreditCard? // 강한참조
    
    init(name: String) {
        self.name = name
    }
    
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt
    unowned let owner: Person
    init(number: UInt, owner: Person) {
        self.number = number
        self.owner = owner // 미소유참조하는 프로퍼티
}
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var jisoo: Person? = Person(name: "jisoo")

if let person: Person = jisoo {
    // CreditCard 인스턴스의 참조 횟수 : 1
    person.card = CreditCard(number: 1004, owner: person)
    // CreditCard의 이니셜라이저에서 owner 프로퍼티에 미소유참조되는 Person인스턴스는 참조 횟수가 증가하지 않으므로 2가 되지 않고 그대로 1이 된다.
    // Person 인스턴스의 참조 횟수 : 1
}

jisoo = nil // Person 인스턴스의 참조 횟수 : 0

// 27.5 미소유참조와 암시적 추출 옵셔널 프로퍼티
// 서로 참조해야하는 프로퍼티에 값이 꼭 있어야 하면서도 한번 초기화되면 그 이후에는 nil을 할당할 수 없는 조건을 갖추어야 할 경우에 사용한다.

// Code. 미소유참조와 암시적 추출 옵셔널 프로퍼티의 활용
class Company {
    let name: String
    var ceo: CEO!
    // 암시적 추출 옵셔널이 아닌 일반 프로퍼티를 사용했다면 초기화가 끝난후에만 CEO와 같은 코드를 호출할 수 있기 때문
    
    init(name: String, ceoName: String) {
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    
    func introduce() {
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}

class CEO {
    let name: String
    unowned let company: Company
    
    init(name: String, company: Company) {
        self.name = name
        self.company = company
    }
    
    func introduce() {
        print("\(name)는 \(company.name)의 CEO입니다.")
    }
}

let company: Company = Company(name: "무한상사", ceoName: "김태호")
company.introduce()
company.ceo.introduce()*/

// 27.6 클로저의 강한참조 순환
// 강한참조 순환 문제는 두 인스턴스끼리의 참조일때만 발생하는 것이 아니라 클로저가 인스턴스의 프로퍼티일 때나, 클로저의 값 획득 특성 때문에 발생한다.
// 강한참조 순환이 발생하는 이유는 클로저가 클래스와 같은 참조 타입이기 때문이다.
// 클로저를 클래스 인스턴스의 프로퍼티로 할당하면 클로저의 참조가 할당된다. 이때 참조 타입과 참조 타입이 서로 강한 참조를 하기 때문에 강한참조 순환 문제가 발생한다.

// 클로저의 강한참조 순환 문제는 클로저의 획득 목록을 통해 해결할 수 있다.

/*// Code. 클로저의 강한참조 순환 문제
class Person {
    let name: String
    let hobby: String?

    lazy var introduce: () -> String = { // 클로저 할당과 지연 저장 프로퍼티 (lazy var) introduce
        // 지연 저장 프로퍼티를 다시 한번 복습해보자면, 지연 저장 프로퍼티는 호출이 있어야 값을 초기화한다.
        // 즉, 필요할 때에만 값을 할당한다.
        // 지연 저장 프로퍼티는 주로 복잡한 클래스나 구조체를 구현할 때 사용하는데, 클래스 인스턴스의 저장 프로퍼티로 다른 클래스 인스턴스나 구조체 인스턴스를 할당해야 할 때 인스턴스를 초기화하면서 저장 프로퍼티로 쓰이는 인스턴스들이 한번에 생성되어야 하는 경우나 굳이 모든 저장 프로퍼티를 사용할 필요가 없을 때 지연 저장 프로퍼티를 사용한다.
        
        // introduce 프로퍼티를 통해 클로저를 호출하면 클로저는 '자신 내부에 있는 참조 타입 변수 등을 획득'한다. 문제는 여기서 발생하게 되는데 클로저는 '자신이 호출되면 언제든지 자신 내부의 참조들을 사용할 수 있도록 참조 횟수를 증가시켜 메모리에서 해제되는 것을 방지'하는데, 이때 '자신을 프로퍼티로 갖는 인스턴스'의 참조 횟수도 증가시킨다.
        // 이렇게 되면 강한참조 순환이 발생하여 자신을 강한참조 프로퍼티로 갖는 인스턴스가 메모리에서 해제될 수 없게된다.
        // 즉, yagom 변수에 nil을 할당하게 되도 인스턴스가 메모리에서 해제되지 않는 것을 확인해볼 수 있다.

        var introduction: String = "My name is \(self.name)."
        // 클로저 내부에서 self 프로퍼티를 사용할 수 있었던 이유는 introduce가 지연 저장 프로퍼티이기 때문이다.

        guard let hobby = self.hobby else {
        return introduction
        }

        introduction += " "
        introduction += "My hobby is \(hobby)."

        return introduction
}

    init(name: String, hobby: String? = nil) {
    self.name = name
    self.hobby = hobby
}

    deinit {
        print("\(name) is being deinitialized")
    }
}

var yagom: Person? = Person(name: "yagom", hobby: "eating")
print(yagom?.introduce())
yagom = nil*/
// yagom 변수에서 마지막에 nil을 할당하였지만, deinit이 호출되지 않았다. 이것으로 보아 메모리에서 해제되지 않고, 메모리 누수가 일어났다는 것을 짐작해볼 수 있다.

// 클로저 내부에서 self 프로퍼티를 여러 번 호출하여 접근한다고 해도 참조 횟수는 한 번만 증가한다.


// 27.6.1 획득목록
// 앞의 강한참조 순환 문제를 해결할 수 있는 방법이 획득목록이다.
// 획득목록은 클로저 내부에서 참조 타입을 획득하는 규칙을 제시해줄 수 있는 기능이다.
// 획득목록을 사용하면 때에 따라서, 혹은 각 관계에 따라서 참조 방식을 클로저에 제안할 수 있다.

// 획득목록에 명시한 요소가 참조타입이 아니라면 해당 요소들은 클로저가 생성될 때 초기화된다.

/*// Code. 획득목록을 통한 값 획득
var a = 0
var b = 0
let closure = { [a] in // 획득목록 [a]

    print(a, b)
    b = 20
}

a = 10
b = 10
closure()
// 클로저가 생성됨과 동시에 획득목록 내에서 다시 a라는 이름의 상수로 초기화된 것이기 때문에 외부에서 a의 값을 변경하더라도 클로저의 획득목록을 통한 a와는 별개가 된다.
print(b)*/

/*// Code. 참조 타입의 획득목록 동작
class SimpleClass { // 클래스는 참조타입
    var value: Int = 0
}

var x = SimpleClass() // 참조타입 인스턴스
var y = SimpleClass() // 참조타입 인스턴스

let closure = { [x] in
    print(x.value, y.value)
    // 둘다 같은 동작결과가 나오는 이유는 두 변수 모두 참조 타입의 인스턴스가 있기 때문이다.
}
x.value = 10
y.value = 10

closure()


// 약한획득을 하게 되면 획득목록에서 획득하는 상수가 옵셔널 상수로 지정된다. 그 이유로는 클로저 내부에서 약한 획득한 상수를 나중에 사용하려고 할 때 이미 메모리에서 해제된 상태일 수 있기 때문이다.
// 메모리에서 해제된 후에 접근하려고 하면 잘못된 접근으로 오류가 발생하므로 안전을 위해 약한획득은 기본적으로 타입을 옵셔널으로 사용해야한다.*/

// Code. 획득목록의 획득 종류 명시
class SimpleClass {
    var value: Int = 0
}

var x: SimpleClass? = SimpleClass()
var y = SimpleClass()

let closure = {[weak x, unowned y] in
    // 클로저의 획득목록에서 x는 약한참조로, y는 미소유참조로 하도록 지정하였따.
    // x는 약한참조이므로 클로저 내부에서 사용하더라도 클로저는 x가 참조하는 인스턴스의 참조횟수를 증가하지 않으므로 변수 x가 참조하는 인스턴스가 메모리에서 해제되어 클로저 내부에서도 더 이상 참조가 불가능하다.
    print(x?.value, y.value)
}

x = nil
y.value = 10
closure()

/*// Code. 획득목록을 통한 클로저의 강한참조 순환 문제 해결
class Person {
    let name: String
    let hobby: String?

    lazy var introduce: () -> String = { [unowned self] in
        var introduction: String = "My name is \(self.name)."
        // self 프로퍼티를 unowned(미소유참조)한 것은 해당 인스턴스가 존재하지 않으면 프로퍼티도 호출할 수 없으므로 self는 미소유참조를 하더라도 실행중에 오류를 발생시킬 가능성이 거의 없다고 볼 수 있다.

        guard let hobby = self.hobby else {
        return introduction
}

introduction += " "
introduction += "My hobby is \(hobby)."
return introduction
}

    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
}

    deinit {
        print("\(name) is being deinitialized")
    }
}

//var yagom: Person? = Person(name: "yagom", hobby: "eating")
//print(yagom?.introduce())
//yagom = nil

// Code. 획득목록의 미소유참조로 인한 차후 접근 문제 발생
var yagom: Person? = Person(name: "yagom", hobby: "eating")
var hana: Person? = Person(name: "hana", hobby: "playing guitar")

hana?.introduce = yagom?.introduce ?? {" "}
print(yagom?.introduce())

yagom = nil

//print(hana?.introduce())
// 오류 ! 왜냐면 이미 메모리에서 해제되어있는 인스턴스를 호출하기 때문이다.
// 미소유참조로 인한 문제상황이 발생할 수 있다면 약한참조로 변경하여 옵셔널로 사용해도 된다.*/

// Code. 획득목록의 약한참조를 통한 차후 접근 문제 방지
class Person {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = { [weak self] in
        guard let 'self' = self else {
            return "원래의 참조 인스턴스가 없어졌습니다."
        }
        
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)."
        
        return introduction
}

    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var yagom: Person? = Person(name: "yagom", hobby: "eating")
var hana: Person? = Person(name: "hana", hobby: "playing guitar")

hana?.introduce = yagom?.introduce ?? {" "}
print(yagom?.introduce())

yagom = nil

print(hana?.introduce())
