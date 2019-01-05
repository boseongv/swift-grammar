import UIKit

// 흐름 제어
// 스위프트의 흐름 제어 구문에서는 소괄호 생략 가능 !, 중괄호 생략 불가능 !

// 6.1 조건문

// 6.1.1 if 구문

// if 구문은 조건의 값이 꼭 bool 타입이어야 한다.

let first: Int = 5
let second: Int = 5

// else if는 몇 개가 이어져도 상관 없으며, else 블록은 없어도 상관없다.
if first > second {
    print(" first > second ")
} else if first < second {
    print(" first < second ")
} else {
    print(" first == second ")
}

var biggerValue: Int = 0
if first > second { // 조건 수식을 소괄호로 묶어주는 것은 선택 사항입니다.
    biggerValue = first
} else if first == second {
    biggerValue = first
} else if first < second {
    biggerValue = second
} else if first == 5 {
    // 조건을 충족하더라도 이미 first == second라는 조건을 충족해 위에서 실행되었기 때문에 실행되지 않는다.
    biggerValue = 100
}
//마지막 else는 생략 가능

print(biggerValue)



//6.1.2 Switch 구문

//switch 구문도 소괄호를 생략할 수 있다.
//case 내부의 코드를 모두 실행하면 break 없이도 switch 구문이 종료된다.
//case에 들어갈 비교 값은 입력 값과 데이터 값이 같아야 한다. 또한 비교될 값이 명확히 한정적인 값이 아닐 때에는 default를 꼭 !! 작성해주어야 한다.
//각 case에는 범위 연산자나, where 절을 사용하여 조건을 확장해줄 수도 있다.

let doubleValue : Double = 3.0

switch doubleValue {
case 0:
    print("Value == zero")
case 1.5 ... 10.5:
    print("1.5 <= value <= 10.5")
default: //자동으로 break는 생기지만, default는 작성해주지 않으면 오류가 생긴다.
   print("Value == \(doubleValue)")
}


//문자열이 있는 switch case 구성코드
let stringValue: String = "Liam Neeson"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny","Joker","Nova" :
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said ' I don't know who you are'")
}

// break를 사용하지 않은 경우 그 다음 case를 실행하도록 했던 trick을 구현하고 싶을 때에는 'fallthrough' 키워드를 사용한다.

//fallthrough의 사용
let stringValue_2: String = "Joker"

switch stringValue_2 {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny":
    fallthrough
case "Joker":
    fallthrough
case "Nova":
    print("He or She is \(stringValue_2)")
    fallthrough
default:
    print("\(stringValue_2) said 'I don't know who you are.'")
}
//위의 코드를 보면, 이미 case문에서 "Joker"에 해당하는 코드가 출력이 되었으나, 다음 조건들에 해당하는 결과까지 전부 출력되어진다. "Nova","default"구문들..


//튜플 switch case 구성
typealias Nameage = (name: String, age: Int)
let tupleValue: Nameage = ("yagom",99)

switch tupleValue {
case ("yagom",99):
    print("정확히 맞췄습니다!")
default:
    print("누굴 찾나요?")
}
// case값으로 튜플을 사용할 수 있음을 볼 수 있다.

// 와일드카드 식별자를 사용한 튜플 switch case 구성.
typealias Nameandage = (name: String, age: Int)

let tupleValue1: Nameandage = ("yagom", 99)
switch tupleValue1 {
case ("yagom",50):
    print("정확히 맞췄습니다!")
case ("yagom", _):
    print("이름만 맞았습니다. 나이는 \(tupleValue1.age)입니다.")
    fallthrough
case (_, 99):
    print("나이만 맞았습니다. 이름은 \(tupleValue1.name)입니다.")
default:
    print("누굴 찾나요?")
}

// 값 바인딩을 사용한 튜플 switch case 구성
// 값 바인딩을 사용하면 case의 조건을 확장할 수 있다.
typealias NameAge_1 = (name: String, age: Int)

let tupleValue_1: NameAge_1 = ("yagom",99)

switch tupleValue_1 {
case("yagom", 50):
    print("정확히 맞췄습니다!")
case("yagom", let age):
    print("이름만 맞았습니다. 나이는 \(age)입니다.")
case(let name, 99):
    print("나이만 맞았습니다. 이름은 \(name)입니다.")
default:
    print("누굴 찾나요?")
}

// where를 사용하여 switch case를 확장하는 코드

let 직급: String = "사원"
let 연차: Int = 1
let 인턴인가: Bool = false

switch 직급 {
case "사원" where 인턴인가 == true:
    print("인턴입니다.")
case "사원" where 연차 < 2 && 인턴인가 == false:
    print("신입사원입니다.")
case "사원" where 연차 > 5:
    print("사원입니다.")
case "대리":
    print("대리입니다.")
default:
    print("사장입니까?")
}

// 열거형과 같이 한정된 범위의 값을 입력 값으로 받게 될 때에는 값에 대응하는 case들이 구현되어진다면 default를 구현하지 않아도 된다.
// 값에 대응하는 각 case를 구현하지 않는다면 default는 필수적으로 해야한다.

enum School {
    case primary, elementary, middle, high, college, university, graduate
}

let 최종학력: School = School.university

switch 최종학력 {
case .primary:
    print("최종학력은 유치원입니다.")
case .elementary:
    print("최종학력은 초등학교입니다.")
case .middle:
    print("최종학력은 중학교입니다.")
case .high:
    print("최종학력은 고등학교입니다.")
case .college, .university:
    print("최종학력은 대학(교)입니다.")
case .graduate:
    print("최종학력은 대학원입니다.")
}

//6.2 반복문
//조건에 따라 실행되어야 하는 명령어를 조건문을 통해 분류하고 실행해야한다면, 같거나 비슷한 명령을 반복 실행 할때는 반복문이 중요한 요소이다.
//C언어에서의 do-while 구문은 스위프트에서 repeat-while 구문으로 구현되어진다.

//6.2.1 for-in 구문
//반복적인 데이터나 시퀀스를 다룰 때 많이 사용하게 된다.

//for-in 반복 구문의 활용

for i in 0...2 {
    print(i)
}

for i in 0...5{
    
    if i%2 == 0 {
        print(i)
        continue // continue 키워드를 사용하면 바로 다음 시퀀스로 건너뛰어진다.
    }
    print("\(i) == 홀수")
}

let helloSwift: String = "Hello Swift!"

for char in helloSwift.characters {
    print(char)
}

var result: Int = 1

//시퀀스에 해당하는 값이 필요 없다면 와일드카드 식별자(_)를 사용하면 됩니다.
for _ in 1...3 {
    result *= 10
}

print("10의 3제곱은 \(result)입니다.")


// 기본 데이터 타입의 for-in 반복 구문 사용
//Dictionary
let friends: [String: Int] = ["Jay":35, "Joe":29, "Jenny":31]

for tuple in friends {
    print(tuple)
}
let 주소: [String: String] = ["도": "충청북도","시군구": "청주시 청원구","동읍면": "율량동"]

for(키, 값) in 주소 {
    print("\(키) : \(값)")
}

//Set
let 지역번호 : Set<String> = ["02","031","032","033","041","042","043","051","052","053","054","055","061","062","063","064"]

for 번호 in 지역번호 {
    print(번호)
}

// 6.2.2 while 구문
//특정 조건이 성립하는 한 블록 내부의 코드를 반복하여 실행한다.

//while 반복 구문의 사용

var names: [String] = ["Joker","Jenny","Nova","yagom"]

numbersLoop: while names.isEmpty == false {
    print("Goodbye \(names.removeFirst())")
    //removeFirst()는 요소를 삭제함과 동시에 삭제한 요소를 반환한다.
}

// 6.2.3 repeat-while 구문

//c언어의 do-while 구문과 다를게 없이, repeat 블록의 코드를 최초 1회 실행한 후, while 다음의 조건이 성립하면 블록 내부의 코드를 반복 실행한다.

var do_names: [String] = ["John","Jenny","Joe","yagom"]

repeat {
    print("Good bye \(do_names.removeFirst())")
    //removeFirst()는 요소를 삭제함과 동시에 삭제된 요소를 반환한다.
}while do_names.isEmpty == false
