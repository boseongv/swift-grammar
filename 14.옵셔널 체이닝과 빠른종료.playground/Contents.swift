import UIKit

// Chapter 14. 옵셔널 체이닝과 빠른 종료

// 14.1 옵셔널 체이닝
// 옵셔널에 값이 있다면 프로퍼티, 메서드, 서브스크립트 등을 호출할 수 있고, 옵셔널이 nil이라면 프로퍼티, 메서드, 서브스크립트 등은 nil을 반환한다.

// 옵셔널 체이닝은 프로퍼티나 메서드 또는 서브스크립트를 호출하고 싶은 옵셔널 변수나 상수 뒤에 물음표를 붙여 표현한다.
// 결과적으로 nil이 반환될 가능성이 있으므로 옵셔널 체이닝의 반환되는 값은 항상 옵셔널이다.

// 느낌표 (!)
// 물음표 대신 느낌표를 사용하는 것은 옵셔널에서 값을 강제로 추출하는 효과가 있다.
// 옵셔널의 !와 ?의 가장 큰 차이점
// 1. 값을 강제로 추출하기 때문에 옵셔널 형식에 값이 없다면 런타임 오류가 발생.
// 2. 옵셔널에서 값을 강제로 추출하여 반환하기 때문에 반환 값이 옵셔널이 아니라는 점.
/*
// Code. 사람의 주소 정보 표현 설계
class Room { // 호실
    var number: Int // 호실 번호
    
    init(number: Int) {
        self.number = number
    }
}

class Building {
    var name: String
    var room: Room?
    
    init(name: String) {
        self.name = name
    }
}

struct Address { // 주소
    var province: String // 광역시/도
    var city: String     // 시/군/구
    var street: String   // 도로명
    var building: Building? // 건물
    var detailAddress: String?  // 건물 외 상세 주소
    
    init(province: String, city: String, street: String) {
        self.province = province
        self.city = city
        self.street = street
    }
    
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            
            restAddress = buildingInfo.name
            
        } else if let detail = self.detailAddress {
            restAddress = detail
        }
        
        if let rest: String = restAddress {
            var fullAddress: String = self.province
            
            fullAddress += " " + self.city
            fullAddress += " " + self.street
            fullAddress += " " + rest
            
            return fullAddress
        } else {
            return nil
        }
    }
    func printAddress() {
        if let address: String = self.fullAddress() {
            print(address)
        }
    }
}

//  yagom.address?.fullAddress()?.isEmpty
// yagom.address?.printAddress()



class Person { // 사람
    var name: String
    var address: Address?
    
    init(name: String) {
        self.name = name
    }
}

//yagom 인스턴스 생성
let yagom: Person = Person(name: "yagom")
//let yagomRoomViaOptionalChaining: Int? = yagom.address?.building?.room?.number
//yagom에는 아직 주소,건물,호실 정보가 없기 때문에 옵셔널 체이닝 도중 nil이 반환되어진다.
//let yagomRoomViaOptionalChaining: Int = yagom.address!.building!.room!.number
// !를 사용하여 강제추출을 하려했으나 값이 없기 때문에 오류가 발생한다.

var roomNumber: Int? = nil

if let yagomAddress: Address = yagom.address {
    if let yagomBuilding: Building = yagomAddress.building {
        if let yagomRoom: Room = yagomBuilding.room {
            roomNumber = yagomRoom.number
        }
    }
}

if let number: Int = roomNumber {
    print(number)
} else {
    print("Can not find room Number")
}
// 옵셔널 체이닝의 결과 값은 옵셔널 값이기 때문에 옵셔널 바인딩과 결합할 수 있다.
// 옵셔널 바인딩을 통해 yagom.address?.building?.room?.number의 결괏값이 nil이 아님을 확인하는 동시에 roomNumber라는 상수로 받아올 수 있다.
/*
yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로", building: nil, detailAddress: nil)
yagom.address?.building = Building(name: "곰굴")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505

print(yagom.address?.building?.room?.number)
*/
*/
/*
let optionalArray: [Int]? = [1,2,3]
optionalArray?[1]

var optionalDictionary: [String: [Int]]? = [String: [Int]]()
optionalDictionary?["numberArray"] = optionalArray
optionalDictionary?["numberArray"]?[2]

// 14.2 빠른 종료
// guard 구문은 if 구문과 유사하게 Bool 타입의 값으로 동작하는 기능이다.
// if 구문과는 다르게 guard 구문은 항상 else 구문이 뒤에 따라와야 한다.
// 현재의 코드 블록을 종료할 때는 return, break, continue, throw 등의 제어문 전환 명령을 사용한다.

// Code. 같은 역할을 하는 if 구문과 guard 구문
// if 구문 사용
for i in 0 ... 3 {
    if i == 2 {
print(i)
    } else {
continue
}
}

// guard 구문을 사용한 코드
for i in 0 ... 3 {
    guard i == 2 else {
continue
}
print(i)
}

// guard 구문의 옵셔널 바인딩 활용
func greet(_ person: [String: String]) {
    guard let name: String = person["name"] else {
return
}

print("Hello \(name)!")

    guard let location: String = person["locaton"] else {
print("I hope the weather is nice near you")
return
}
print("I hope the weather is nice in \(location)")
}

var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)
// I hope the weather is nice near you

personInfo["location"] = "Korea"

greet(personInfo)
*/
/*
// Code. 메서드 내부에서 guard 구문의 옵셔널 바인딩 활용
func fullAddress() -> String? {
    var restAddress: String? = nil

    if let buildingInfo: Building = self.building {
        restAddress = buildingInfo.name
    } else if let detail = self.detailAddress {
    restAddress = detail
}

    guard let rest: String = restAddress else {
        return nil
}

    var fullAddress: String = self.province
    fullAddress += " " + self.city
    fullAddress += " " + self.street
    fullAddress += " " + rest

    return fullAddress

}
*/
func enterClub(name: String?, age: Int?) {
    guard let name: String = name, let age: Int = age, age > 19,
        name.isEmpty == false else {
            print("You are too young to enter the club")
            return
        }
        print("Welcome \(name)!")
    }

//let first: Int = 3
//let second: Int = 5
//
//guard first > second else {
//
//}
// guard 구문의 한계는 자신을 감싸는 코드 블록, 즉 return, break, continue, throw 등의 제어문 전환 명령어를 쓸 수 없는 상황이라면 사용이 불가능하다.
