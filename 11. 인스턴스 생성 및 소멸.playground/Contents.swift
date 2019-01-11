import UIKit

// 11. 인스턴스 생성 및 소멸
// 인스턴스를 생성하는 방법과 클래스의 인스턴스가 소멸할 때 어떤 프로세스가 진행되는지

// 11.1 인스턴스 생성
// 초기화과정은 새로운 인스턴스를 사용할 준비를 하기 위해 저장 프로퍼티의 초깃값을 설정하는 것과 같은 일을 한다.
// 이니셜라이저를 정의하면 초기화 과정을 직접 구현할 수 있다.

// 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저

//
//class SomeClass {
//    init() {
//        // 초기화할 때 필요한 코드
//    }
//}
//
//struct SomeStruct {
//    init() {
//        // 초기화할 때 필요한 코드
//    }
//}
//
//enum SomeEnum {
//    case someCase
//
//    init() {
//        // 열거형은 초기화할 때 반드시 case중 하나가 되어야 한다.
//        self = .someCase
//        // 초기화할 때 필요한 코드
//    }
//}
//
//
//// 11.1.1 프로퍼티 기본 값
//// 구조체와 클래스의 인스턴스는 처음 생성할 때 옵셔널 저장 프로퍼티를 제외한 모든 저장 프로퍼티에 적절한 초깃값을 할당해주어야 한다.
//
//// Area 구조체와 이니셜라이저
//struct Area {
//    var squareMeter: Double
//    init () {
//        squareMeter = 0.0 // squareMeter의 초깃값 할당
//        }
//    }
//
//let room: Area = Area()
//print(room.squareMeter)
//
//
//// 프로퍼티 기본값 지정
//struct Areaa {
//    var squareMeter: Double = 0.0
//}
//
//let rooma: Areaa = Areaa()
//print(rooma.squareMeter)
//
//
//// 11.1.2 이니셜라이저 매개변수
//// 인스턴스를 초기화하는 과정에 필요한 값을 전달받을 수 있다.
//
//// 이니셜라이저 매개변수
//struct zieun {
//    var squareMeter: Double
//
//    init(fromPy py: Double) {           // 첫 번째 이니셜라이저
//        squareMeter = py * 3.3058
//    }
//
//    init(fromSquareMeter squareMeter: Double) {     // 두 번째 이니셜라이저
//        self.squareMeter = squareMeter
//    }
//
//    init(value: Double) {       // 세 번째 이니셜라이저
//        squareMeter = value
//    }
//
//    init(_ value: Double) {        // 네 번째 이니셜라이저
//        squareMeter = value
//    }
//}
//
//let roomOne: zieun = zieun(fromPy: 15.0)
//print(roomOne.squareMeter)
//
//let roomTwo: zieun = zieun(fromSquareMeter: 33.06)
//print(roomTwo.squareMeter)
//
//let roomThree: zieun = zieun(value: 30.0)
//let roomFour: zieun = zieun(55.0)
//
//
//// 11.3 옵셔널 프로퍼티 타입
//// 인스턴스가 사용되는 동안에 값을 꼭 갖지 않아도 되는 저장 프로퍼티가 있거나, 초기화과정에서 값을 지정해주기 어려운 경우 해당 프로퍼티를 옵셔널로 선언할 수 있다.
//// 옵셔널로 선언한 저장 프로퍼티는 초기화과정에서 값을 할당해주지 않는다면 자동으로 nil이 할당된다.
//
//// Person 클래스
//class Person {
//    var name: String
//    var age: Int?
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//let yagom: Person = Person(name: "yagom")
//print(yagom.name)
//print(yagom.age)
//
//yagom.age = 99
//print(yagom.age)
//
//yagom.name = "Eric"
//print(yagom.name)
//
//
//// 11.1.4 상수 프로퍼티
//// 상수로 선언된 저장 프로퍼티는 인스턴스를 초기화하는 과정에서만 값을 할당할 수 있으며, 처음 할당된 이후로는 값을 변경할 수 없다.
//
//// 상수 프로퍼티의 초기화
//
//class sang {
//    let name: String
//    var age: Int?
//
//    init(name: String) {
//        self.name = name
//    }
//}
//let ya: sang = sang(name:"yagom")
//// ya.name = "Eric" 하면 오류가 생기는 이유는, 처음에 할당을 name이라고 주었는데, Eric라는 값을 줌으로써 변경하려고 하였기 때문에 오류가 생겼다.
//
//
//// 11.1.5 기본 이니셜라이저와 멤버와이즈 이니셜라이저
//// 사용자정의 이니셜라이저를 정의해주지 않으면 클래스나 구조체는 기본값이 지정되어 있다고 전제하고 기본 이니셜라이저를 사용한다.
//// 기본 이니셜라이저는 프로퍼티 기본값으로 프로퍼티를 초기화하여 인스턴스를 생성한다.
//
//// 기본 이니셜라이저는 저장 프로퍼티의 기본값이 모두 지정되어 있고, 동시에 사용자정의 이니셜라이저가 지정되어 있지 않은 상태에서 제공된다.
//
//// Point 구조체와 Size 구조체의 선언과 멤버와이즈 이니셜라이저의 사용
//struct Point {
//    var x: Double = 0.0
//    var y: Double = 0.0
//}
//
//struct Size {
//    var width: Double = 0.0
//    var height: Double = 0.0
//}
//
//let point: Point = Point(x: 0, y: 0)
//let size: Size = Size(width: 50.0, height: 50.0)
//
//// 11.1.6 초기화 위임
//// Student 열거형과 초기화 위임
//enum Student {
//    case elementary, middle, high
//    case none
//
//    // 사용자정의 이니셜라이저가 있는 경우, init() 메서드를 구현해주어야 기본 이니셜라이저를 사용할 수 있다.
//
//    init() {
//        self = .none
//    }
//
//    init(koreanAge: Int) {
//        switch koreanAge {
//        case 8...13:
//            self = .elementary
//        case 14...16:
//            self = .middle
//        case 17...19:
//            self = .high
//        default:
//            self = .none
//    }
//}
//
//    init(bornAt: Int, currentYear: Int) { // 두 번째 사용자정의 이니셜라이저
//        self.init(koreanAge: currentYear - bornAt + 1)
//    }
//}
//
//var younger: Student = Student(koreanAge: 16)
//print(younger) //middle
//
//younger = Student(bornAt: 1998, currentYear: 2016)
//print(younger) // high

// 11.1.7 실패 가능한 이니셜라이저
// 이니셜라이저를 통해 인스턴스를 초기화 할 수 없는 여러가지 예외 사항이 있다.
// 대표적인 예로는 이니셜라이저의 전달인자로 잘못된 값이나 적절치 못한 값이 전달되었을 때, 이니셜라이저는 인스턴스 초기화에 실패할 수 있다.
// 이렇게 실패 가능성을 가지고 있는 이니셜라이저를 실패 가능한 이니셜라이저라고 말한다.
// 실패 가능한 이니셜라이저는 실패했을 때 nil을 반환하기 때문에 반환 타입이 옵셔널로 지정된다.

// 실패 가능한 이니셜라이저
//class Person {
//    let name: String
//    var age: Int?
//
//    init?(name: String) {
//
//        if name.isEmpty {
//            return nil
//        }
//        self.name = name
//
//
//}
//
//    init?(name: String, age: Int) {
//        if name.isEmpty || age < 0 {
//            return nil
//        }
//        self.name = name
//        self.age = age
//    }
//}
//
//let yagom: Person? = Person(name: "zieunv", age: 99)
//
//if let person: Person = yagom {
//    print(person.name)
//} else {
//    print("Person wasn't initialized")
//}
//
//let chope: Person? = Person(name: "chope", age: -10)
//
//if let person: Person = chope {
//    print(person.name)
//} else {
//    print("Person wasn't initialized")
//}
//
//let eric: Person? = Person(name: "", age: 30)
//
//if let person: Person = eric {
//    print(person.name)
//} else {
//    print("Person wasn't initialized")
//}

// 열거형의 실패 가능한 이니셜라이저
//enum Student: String {
//    case elementary = "초등학생" , middle = "중학생" , high = "고등학생"
//
//    init?(koreanAge: Int) {
//        switch koreanAge {
//        case 8...13:
//            self = .elementary
//        case 14...16:
//            self = .middle
//        case 17...19:
//            self = .high
//        default:
//            return nil
//        }
//    }
//
//    init?(bornAt: Int, currentYear: Int) {
//        self.init(koreanAge: currentYear - bornAt + 1)
//    }
//}
//
//var younger: Student? = Student(koreanAge:  20)
//print(younger)
//
//younger = Student(bornAt: 2020, currentYear: 2016)
//print(younger)
//
//younger = Student(rawValue: "대학생")
//print(younger)
//
//younger = Student(rawValue: "고등학생")
//print(younger)
//

// 11.1.8 함수를 사용한 프로퍼티 기본값 설정
// 인스턴스를 초기화할 때 함수나 클로저가 호출되면서 연산 결괏값을 프로퍼티 기본값으로 제공해준다. 그렇기 때문에 클로저나 함수의 반환 타입은 프로퍼티의 타입과 일치하여야 한다.
// 클로저 내부에서는 인스턴스의 다른 프로퍼티에 기본값이 있다고 해도 사용할 수 없다.
// 클로저 내부에서 self 프로퍼티도 사용할 수 없으며, 인스턴스 메서드를 호출할 수도 없다.

// 클로저를 통한 프로퍼티 기본값 설정
//
//class SomeClass {
//    let someProperty: SomeType = {
//        // 새로운 인스턴스를 생성하고 사용자정의 연산을 통한 후 반환한다.
//        // 반환되는 값의 타입은 SomeType과 같은 타입이어야 한다.
//        return someValue
//    }() // 클로저 뒤에 소괄호가 붙은 이유는 클로저를 실행하기 위해서이다.
// 클로저 뒤에 소괄호가 붙어 클로저를 실행한 결괏값은 프로퍼티의 기본값이 된다.
// 소괄호가 없다면 프로퍼티의 기본값은 클로저 그 자체가 된다.
//}


// 클로저를 통한 student 프로퍼티 기본값 설정
//struct Student {
//    var name: String?
//    var number: Int?
//}
//
//class SchoolClass {
//    var students: [Student] = {
//        // 여기서 students 프로퍼티는 Student 구조체의 인스턴스를 요소로 갖는 Array타입이다.
//        // 새로운 인스턴스를 생성하고 사용자정의 연산을 통한 후 반환해준다.
//        // 반환되는 값의 타입은 [Student] 타입이어야 한다.
//        var arr: [Student] = [Student]()
//
//        for num in 1...15 {
//            var student: Student = Student(name: nil, number: num)
//            arr.append(student)
//        }
//
//        return arr
//    }()
//}
//
//let myClass: SchoolClass = SchoolClass()
//// 생성되자마자 1번부터 15번까지의 학생을 생성하여 배열에 할당한다.
//print(myClass.students.count)

// 11.2 인스턴스 소멸
// 디이니셜라이저는 이니셜라이저와 반대 역할을 한다.
// 즉 메모리에서 해제되기 직전 클래스 인스턴스와 관련하여 원하는 정리 작업을 구현할 수 있다.
// 클래스의 인스턴스가 메모리에서 소멸되기 바로 직전 호출하는데 deinit 키워드를 사용하여 디이니셜라이저를 구현하면 자동으로 호출된다.
// 디이니셜라이저는 클래스의 인스턴스에만 구현할 수 있다.

// FileManager 클래스의 디이니셜라이저 활용
class FileManager {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func openFile() {
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile() {
        print("Modify File: \(self.fileName)")
    }
    
    func writeFile() {
        print("Write File: \(self.fileName)")
    }
    
    func closeFile() {
        print("Close File: \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = FileManager {
    manager.openFile()
    manager.modifyFile()
}
// 디스크의 파일을 불러와 사용하는 FileManager 클래스이다.
// FileManager의 인스턴스가 파일을 불러와 사용하며, 인스턴스의 사용이 끝난 후에는 파일의 변경사항을 저장하고 다시 닫아줘야 메모리에서 파일이 해제되기 때문에 인스턴스가 메모리에서 해제되기 직전에 파일도 닫아주는 작업을 한다.

FileManager = nil
// Deinit instance
// Write File : abc.txt
// Close File : abc.txt
