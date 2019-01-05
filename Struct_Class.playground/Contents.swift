import UIKit

//// Chapter 9 구조체와 클래스
//
//// 구조체는 연관되어 있는 몇몇의 값들을 모아서, 하나의 데이터 타입으로 표현하고 싶을때 사용한다.
//// 다른 객체 또는 함수 등으로 전달을 할 때, 참조가 아닌 복사를 원할 경우에 사용한다.
//
//
//// 구조체는 값타입, 클래스는 참조타입이므로 클래스는 다중 상속이 안된다.
//
//struct BasicInformation {
//    var name: String
//    var age: Int
//}
//
//// 구조체 인스턴스의 생성 및 초기화
//var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)
//// var타입으로 값 변경가능
//yagomInfo.age = 100
//yagomInfo.name = "Seba"
//
//let sebaInfo: BasicInformation = BasicInformation(name: "Seba", age: 99)
////// let 타입이므로 값 변경 불가능
////sebaInfo.age = 100
////jennyInfo.age = 100
//
//class Person {
//    var height: Float = 0.0
//    var weight: Float = 0.0
//}
//
//var yagom: Person = Person()
//yagom.height = 123.4
//yagom.weight = 123.4
//
//let jenny: Person = Person()
//jenny.height = 123.4
//jenny.weight = 123.4
//
//class Persona {
//    var height: Float = 0.0
//    var weight: Float = 0.0
//
//    deinit {
//        print("Person 클래스의 인스턴스가 소멸됩니다.")
//    }
//}
//
//var yagoma: Persona? = Persona()
//yagoma = nil

// 9.3 구조체와 클래스의 차이
// 9.3.1 값 타입과 참조 타입
// 구조체는 값타입이고 클래스는 참조 타입이다. 무엇이 전달되느냐에 따라 차이는 확연하게 나타난다.

struct BasicInformation {
    let name: String
    var age: Int
}

var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)
yagomInfo.age = 100

var friendInfo : BasicInformation = yagomInfo

print("yagom's age: \(yagomInfo.age)")
print("friend's age: \(friendInfo.age)")

friendInfo.age = 999

print("yagom's age: \(yagomInfo.age)")
print("friend's age: \(friendInfo.age)")

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

var yagom: Person = Person()
var friend: Person = yagom

print("yagom's height: \(yagom.height)")
print("friend's height: \(friend.height)")

friend.height = 185.5
print("yagom's height: \(yagom.height)")

print("friend's height: \(friend.height)")

func changeBasicInfo(_ info: BasicInformation) {
    var copiedInfo: BasicInformation = info
    copiedInfo.age = 1
}
func changedPersonInfo(_ info: Person){
    info.height = 155.3
}

changeBasicInfo(yagomInfo)
print("yagom's age: \(yagomInfo.age)")

changedPersonInfo(yagom)
print("yagom's height : \(yagom.height)")

// 식별 연산자의 사용
var zieunv: Person = Person()
let guhan: Person = zieunv
let anotherPerson: Person = Person()

print(zieunv === guhan)
print(zieunv === anotherPerson)
print(guhan !== anotherPerson)


// 9.4 구조체와 클래스 선택해서 사용하기
// 구조체와 클래스는 새로운 타입을 정의하고 기능을 추가하는 점이 공통점이다.
// 구조체 인스턴스는 항상 값타입이고, 클래스 인스턴스는 참조 타입이다.

