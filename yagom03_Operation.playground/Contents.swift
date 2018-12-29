import UIKit

// Chapter 05 연산자

// 스위프트는 데이터의 타입에 대해 굉장이 엄격하므로, 서로 다른 자료형끼리의 연산을 심하게 제한한다. 서로 다른 자료형끼리의 연산을 실행하려면 값을 해당 타입으로 변환을 하는 '타입 캐스팅'을 통해 변환 후 연산해야 한다.
var value: Double = 3.3
var convertedValue: Int = Int(value)
//기존 값을 전달인자로 받는 이니셜라이저를 통해 새로운 Int구조체의 인스턴스를 생성.-> 이니셜라이저를 통해 새로운 인스턴스를 생성하는 과정.
convertedValue = Int(5.5)

let result33 = 5/2.1
let number: Double = 5.0
var result: Double = number.truncatingRemainder(dividingBy: 1.5)
result = 12.truncatingRemainder(dividingBy: 2.5)

//나누기 연산은 나머지나 소수점을 제외한 정수만을 결과값으로 반환한다.
var result1: Int = 5/3
result1 = 10/3

//참조 비교 연산자
//클래스의 인스턴스만이 스위프트에서는 유일한 참조타입이기 때문에 여기서만 참조 비교 연산자를 사용할 수 있다. 다른 데이터 타입에서 === 에 대한 연산자를 프로그래머가 정의하게 된다면, 다른 용도로도 사용이 가능하다.(이건 값 타입과 참조타입인 179페이지에서 다시 다뤄보자.)
//스위프트의 기본 데이터 타입은 모두 구조체로 구현되어 있기 때문에 값 타입이다.
//구조체인 스위프트에서는 비교 연산시 ==를 사용하고, 클래스의 인스턴스인 경우에만 ===를 사용한다.

//삼항 조건 연산자의 사용
var valueA: Int = 3
var valueB: Int = 5
var biggerValue: Int = valueA > valueB ? valueA : valueB

valueA = 0
valueB = -3
//biggerValue = valueA > valueB ? >valueA : valueB

var stringA : String = ""
var stringB : String = "String"
var resultValue: Double = stringA.isEmpty ? 1.0 : 0.0
resultValue = stringB.isEmpty ? 1.0 : 0.0


// 클래스 및 구조체의 비교 연산자 구현 코드

class Car {
    var modelYear: Int? // 연식
    var modelName: String? // 모델 이름
}

struct SmartPhone {
    var company: String? // 제조사
    var model: String? // 모델
}

// Car 클래스의 인스턴스끼리 == 연산했을 때 modelName이 같다면 true를 반환
func ==(lhs: Car, rhs: Car) -> Bool {
    return lhs.modelName == rhs.modelName
}

//SmartPhone 구조체의 인스턴스끼리 == 연산했을 때 model이 같다면 true를 반환
func ==(lhs: SmartPhone, rhs: SmartPhone) -> Bool {
    return lhs.model == rhs.model
}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model = "6"

print(myCar == yourCar)
print(myPhone == yourPhone)

