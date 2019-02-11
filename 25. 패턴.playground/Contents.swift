import UIKit

// 25. 패턴
// 패턴은 '단독 또는 복합 값의 '구조'를 나타내는 것'
// 패턴 매칭은 '코드에서 어떤 패턴의 형태를 찾아내는 행위'

// 스위프트의 패턴은 크게 두 종류로 나뉘어진다.
// 1. 값을 해체(추출)하거나 무시하는 패턴 : 와일드카드 패턴, 식별자 패턴, 값 바인딩 패턴, 튜플 패던
// 2. 패턴 매칭을 위한 패턴 : 열거형 케이스 패턴, 옵셔널 패턴, 표현 패턴, 타입캐스팅 패턴

// 25.1 와일드카드 패턴
// 와일드카드 식별자(_)를 사용하게 되면, 식별자가 위치한 곳의 값은 무시한다.
/*// Code. 와일드카드 패턴의 사용
let string: String = "ABC"

switch string {
    // ABC -> 어떤 값이 와도 상관이 없다.
case _: print(string)
}

let optionalString: String? = "ABC"

switch optionalString {
case "ABC"?: print(optionalString)
    
case _?: print("Has value, but not ABC")
    
case nil: print("nil")
}

let yagom = ("yagom", 99, "Male")

switch yagom {
case ("yagom", _,_): print("Hello yagom!!!")
    
case(_, _, _): print("Who cares~")
}

for _ in 0..<2 {
    print("Hello")
}*/

// 25.2 식별자 패턴
// 식별자 패턴은 변수 또는 상수의 이름에 알맞는 값을 어떤 값과 매칭시키는 패턴을 말한다.

// Code. 식별자 패턴의 사용
//let someValue: Int = 42
// someValue의 타입인 Int와 할당하려는 42의 타입이 매치된다면 someValue는 42라는 값의 식별자가 되므로 식별자 패턴이 성립된다.
// 식별자 패턴이 성립되고 나면 42라는 값은 someValue라는 상수에 할당된다.

// 25.3 값 바인딩 패턴
// 값 바인딩 패턴은 변수 또는 상수의 이름에 매칭된 값을 바인딩 하는 것이다.
// 식별자 패턴은 값 바인딩 패턴의 일종이다.
// 값바인딩 패턴을 예를 들면 튜플의 요소를 해체하여 그에 대응하는 식별자 패턴에 각각의 요소 값을 바인딩한다.

/*// Code. 값 바인딩 패턴의 사용
let yagom = ("yagom", 99, "Male")

switch yagom {
    // name, age, gender를 yagom의 각각의 요소에 바인딩한다.
case let (name, age, gender) : print ("Name: \(name), Age: \(age), Gender: \(gender)")
}

switch yagom {
case (let name, let age, let gender) : print ("Name: \(name), Age: \(age), Gender: \(gender)")
}

switch yagom {
    // 값 바인딩 패턴은 와일드카드 패턴과 결합하여 유용하게 사용할 수 있다.
case (let name, _, let gender): print("Name: \(name), Gender: \(gender)")
}*/


// 25.4 튜플 패턴
// 튜플 패턴은 소괄호 내에 쉼표로 분리하는 리스트이다.
// 튜플 패턴은 그에 상응하는 튜플 타입과 값을 매칭한다.
// 예를 들면 let (x, y): (Int, Int) = (1, 2)와 같이 상수를 선언한다면 (x, y): (Int, Int)라고 사용된 튜플 패턴은 요소가 모두 Int 타입인 튜플하고만 매치가 된다.

/*// Code. 튜플 패턴의 사용
let (a): Int = 2
print(a)

let (x, y): (Int, Int) = (1, 2)
print(x)
print(y)

let name: String = "Jung"
let age: Int = 99
let gender: String? = "Male"

switch (name, age, gender) {
case("Jung", _, _): print("Hello Jung!!")
case(_, _, "Male"?): print("Who are you man?")
default: print("I don't know who you are")
}

let points: [(Int, Int)] = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]

for (x, _) in points {
    print(x)
}*/

// 20.5 열거형 케이스 패턴
// 열거형 케이스 패턴은 값을 열거형 타입의 case와 매치시킨다.
// 만약 연관 값이 있는 열거형 케이스와 매치하려고 한다면 열거형 케이스 패턴에는 반드시 튜플 패턴이 함께해야 한다.

/*// Code. 열거형 케이스 패턴의 사용
let someValue: Int = 30

if case 0...100 = someValue {
    print("0 <= \(someValue) <= 100")
}
let anotherValue: String = "ABC"

if case "ABC" = anotherValue {
print(anotherValue)
}

enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dishes: [MainDish] = []

var dinner: MainDish = .pasta(taste: "크림")
dishes.append(dinner)

if case .pasta(let taste) = dinner {
print("\(taste) 파스타")
}

dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
dishes.append(dinner)

func whatIsThis(dish: MainDish) {
    guard case .pizza(let dough, let topping) = dinner else {
        print("It's not a Pizza")
        return
    }
print("\(dough) \(topping) 피자")
}
whatIsThis(dish: dinner)

dinner = .chicken(withSauce: true)
dishes.append(dinner)

while case .chicken(let sauced) = dinner {
    print("(\(sauced ? "양념" : "후라이드") 통닭")
    break
}

dinner = .rice
dishes.append(dinner)

if case .rice = dinner {
print("오늘 저녁은 밥입니다.")
}

for dish in dishes {
    switch dish {
    case let .pasta(taste): print(taste)
    case let .pizza(dough, topping): print("\(dough, topping)")
    case let .chicken(sauced): print(sauced ? "양념" : "후라이드" )
    case .rice: print("Just 쌀")
    }
}*/

// 25.6 옵셔널 패턴
// 옵셔널 패턴은 옵셔널 또는 암시적 추출 옵셔널 열거형에 감싸져 있는 값을 매치시킬 때 사용한다.
// 옵셔널 패턴은 옵셔널 값을 저장하는 배열의 for-in 구문을 통한 순환에서 nil이 아닌 값을 찾는 데도 유용하게 사용한다.

/*// Code. 옵셔널 패턴의 사용
var optionalValue: Int? = 100

if case .some(let value) = optionalValue {
    print(value)
}

if case let value? = optionalValue {
print(value)
}

func isItHasValue(_ optionalValue: Int?) {
        guard case .some(let value) = optionalValue else {
        print("none")
        return
    }

    print(value)
}

isItHasValue(optionalValue)

while case .some(let value) = optionalValue {
    print(value)
    optionalValue = nil
}

print(optionalValue)

let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

for case let number? in arrayOfOptionalInts {
print("Found a \(number)")
}*/

// 25.7 타입캐스팅 패턴
// 타입캐스팅 패턴에는 is 패턴과 as 패턴이 있다.
// is 패턴은 switch case 레이블에서만 사용할 수 있다.
// is 패턴은 프로그램 실행 중에 값 타입이 is의 오른쪽에 쓰여진 타입이나 그 타입의 자식클래스 타입이면 값과 매치시킨다.
// is 패턴은 타입 캐스팅에서 사용되는 as 연산자와 비슷한 역할을 하지만 반환된 결과값은 신경쓰지 않는다는 차이점이 있다.

// as 패턴은 프로그램 실행 중에 값의 타입이 as 우측에 쓰여진 타입 또는 그 타입의 자식클래스 타입이면 값과 매치시킨다.
// 매치가 된 후에는 매치된 값의 타입은 as 패턴이 원하는 타입으로 캐스팅된다.

// Code. 타입캐스팅 패턴의 사용
let someValue: Any = 100

switch someValue {
// 타입이 Int인지 확인하지만 캐스팅된 값을 사용할 수는 없다.
case is String: print("It's String!")

// 타입 확인과 동시에 캐스팅까지 완료되어 value에 저장된다.
// 값 바인딩 패턴과 결합된 모습이다.
case let value as Int: print(value + 1)
default: print("Int도 String이 아닙니다.")
}

// 25.8 표현 패턴
// 표현 패턴은 표현식의 값을 평가한 결과를 이용하는 것이다.
// 표현 패턴은 switch 구문의 case 레이블에서만 사용할 수 있다.

/*// Code. 표현 패턴의 사용
switch 3 {
case 0...5: print("0과 5 사이")
default: print("0보다 작거나 5보다 큽니다.")
}

var point: (Int, Int) = (1, 2)

// 같은 타입 간의 비교이므로 == 연산자를 사용하여 비교할 것입니다.
switch point {
case (0, 0): print("원점")
case(-2...2, -2...2): print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
default: print("point (\(point.0), \(point.1))")
}

// String 타입과 Int 타입이 매치될 수 있도록 ~= 연산자를 정의합니다.
func ~=(pattern: String, value: Int) -> Bool {
return pattern == "\(value)"
}

point = (0, 0)

// 새로 정의된 ~= 연산자를 사용하여 비교합니다.
switch point {
case ("0", "0"): print("원점")
default: print("point (\(point.0), \(point.1))")
}

struct Person {
    var name: String
    var age: Int
}

let lingo: Person = Person(name: "Lingo", age: 99)
func ~=(pattern: String, value: Person) -> Bool {
return pattern == value.name
}
func ~=(pattern: Person, value: Person) -> Bool {
return pattern.name == value.name && pattern.age == value.age
}

switch lingo {
case Person(name: "Lingo", age: 99): print("Same Person!!")
case "Lingo": print("Hello Lingo!!!")
default: print("I don't know who you are")
}*/

// Code. 제네릭을 사용한 표현 패턴 활용
// 제네릭을 사용하기 위한 프로토콜 정의
protocol Personalize {
    var name: String { get }
    var age: Int { get }
}

struct Person: Personalize {
    var name: String
    var age: Int
}

let star: Person = Person(name: "Star", age: 99)

func ~=(pattern: String, value: Person) -> Bool {
return pattern == value.name
}

func ~=(pattern: Person, value: Person) -> Bool {
return pattern.name == value.name && pattern.age == value.age
}

// 제네릭을 사용하여 패턴 연산자를 정의
func ~=<T: Personalize>(pattern: String, value: T) -> Bool {
return pattern == value.name
}

func ~=<T: Personalize>(pattern: T, value: T) -> Bool {
return pattern.name == value.name && pattern.age == value.age
}

// 기존 패턴 연산자가 없더라도 제네릭 패턴 연산자로 똑같이 사용할 수 있다.
switch star {
case Person(name: "Star", age: 99): print("Same Person!!")
case "Star": print("Hello Star!!")
default: print("I don't know who you are")
}

// 제네릭을 사용하여 패턴 연산자 정의
func ~=<T: Personalize>(pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}

// 패턴에 사용할 제네릭 함수
// 패턴에 함수를 사용하여 함수의 결과를 통해 Bool 값을 얻어낸다.
// 단순하게 패턴에 함수를 사용하는 것을 넘어, 제네릭을 사용하여 프로토콜을 준수하는 타입 모두가 공통으로 매칭이 가능하다.
func young<T: Personalize>(value: T) -> Bool {
return value.age < 50
}

switch star {
// 패턴결합을 하면 young(star)와 같은 효과를 볼 수 있다.
case young: print("\(star.name) is young")
default: print("\(star.name) is old")
}

// 패턴에 사용할 제네릭 함수
func isNamed<T: Personalize>(_ pattern: String) -> ((T) -> Bool) {
    return { (value: T) -> Bool in value.name == pattern }
// 패턴과 값을 비교할 클로저 반환
}

switch star {
// 패턴 결합을 하면 isNamed("Jung")(star)와 같은 효과를 본다.
case isNamed("Jung"): print("He is Jung")
default: print("Another person")
}
// 연산자가 함수라는 점을 생각하면 이런 방식으로도 구현할 수 있다.
prefix operator ==?

prefix func ==?<T: Personalize>(pattern: String) -> ((T) -> Bool) {
return isNamed(pattern)
}

switch star {
    // 패턴결합을 하면 isNamed("Jung"(star)와 같은 효과를 본다.
case ==?"Jung": print("He is Jung")
default: print("Another person")
}

