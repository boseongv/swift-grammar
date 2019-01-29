import UIKit

// Chapter 18. 상속
// 클래스는 메서드나 프로퍼티 등을 다른 클래스로부터 상속받을 수 있다.
// 어떤 클래스로부터 상속을 받게되는 클래스는 자식 클래스라고 하고, 자식클래스에게 자신의 특성을 물려준 클래스를 부모클래스라고 한다.
// 스위프트의 클래스는 부모클래스로부터 물려받은 메서드를 호출할 수 있고 프로퍼티에 접근할 수 있으며 서브스크립트도 사용할 수 있다. 또한 가공하였던 메서드, 프로퍼티, 서브스크립트 등을 자신만의 내용으로 재정의할 수도 있다.
// 스위프트에서는 부모클래스의 요소를 자식클래스에서 재정의할 때 자식클래스가 부모클래스의 요소들을 재정의한다는 것을 명확히 확인해주어야 한다.
// 상속받은 프로퍼티에 프로퍼티의 값이 변경되었을 때 알려주는 프로퍼티 감시자도 구현할 수 있다.
// 연산 프로퍼티를 정의해준 클래스에서는 연산 프로퍼티에 프로퍼티 감시자를 구현할 수 없지만, 부모 클래스에서 연산 프로퍼티로 정의한 프로퍼티거나 저장 프로퍼티로 정의한 프로퍼티도 자식클래스에서는 프로퍼티 감시자를 구현할 수 있다.
// 다른 클래스로부터 상속을 받지 않은 클래스를 기반클래스라고 부른다.

/*// Code. 기반 클래스 Person
class Person {
    var name: String = "" // 저장프로퍼티 name
    var age: Int = 0   // 저장프로퍼티 age
    
    var introduction: String { // 연산 프로퍼티 introduction
        return "이름: \(name). 나이 : \(age)"
    }
    
    func speak() { // 메서드 speak()
        print("가나다라마바사")
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction)
yagom.speak()
*/

// 18.1 클래스 상속
// 상속은 기반 클래스를 다른 클래스에서 물려받는 것을 말한다.
// 부모클래스의 메서드, 프로퍼티 등을 재정의하거나, 기반클래스의 기능이나 프로퍼티를 물려받고 자신의 기능을 추가할 수 있다.

/*// Code. Person 클래스를 상속받은 Student 클래스
class Student: Person { // 뒤에오는 클래스인 Person 클래스의 기능을 앞의 클래스인 Student가 상속 받았다
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction) // 이름 : yagom, 나이 : 99
yagom.speak() // 가나다라마바사

let jay: Student = Student()
jay.name = "jay"
jay.age = 10
jay.grade = "A"
print(jay.introduction)
jay.speak()
jay.study()

// Student 클래스는 Person 클래스를 상속받았기 때문에 부모 클래스가 물려준 프로퍼티와 메서드를 사용할 수 있으며 자신이 정의한 프로퍼티와 메서드도 사용할 수 있다.
// 또한 어떤 클래스의 자식클래스가 다른 클래스의 부모클래스가 될 수도 있으므로, Student 클래스도 다른 클래스의 부모 클래스가 될 수 있다.

// Code. Student 클래스를 상속받은 UniversityStudent 클래스
class UniversityStudent: Student {
    var major: String = ""
}

let jenny: UniversityStudent = UniversityStudent()
jenny.major = "Art"
jenny.speak()
jenny.study()

// 다른 클래스를 상속받으면 똑같은 기능을 구현하기 위하여 코드를 다시 작성할 필요가 없으므로 코드를 재사용하기 쉽고, 기능을 확장하고 싶을 때 기존 클래스를 변경하지 않고도 새로운 추가 기능을 구현한 클래스를 정의할 수 있다.*/

// 18.2 재정의
// 부모클래스로부터 물려받은 특성(인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로퍼티, 서브스크립트 등)을 그대로 사용하지 않고 자신만의 기능으로 변경하여 사용하는 것을 재정의라고 한다.
// 재정의를 할 때에는 새로운 정의 앞에 override라는 키워드를 사용하여 표현한다.
// override 키워드는 스위프트 컴파일러가 부모를 포함한 그 상위 부모클래스인 조상클래스에 해당 특성이 있는지 확인한 후에 재정의하게 된다.
// 조상클래스에 재정의할 해당 특성이 없는데도 override를 사용하였을시에는 컴파일 오류가 발생한다.

// override를 할때에 super 키워드를 사용하게 되는데, 이것은 자식클래스에서 특성을 재정의하였지만 필요에 따라 부모클래스의 특성을 활용하고 싶을 때 super를 사용한다.
// super 키워드를 타입 메서드 내에서 사용한다면, 부모클래스의 타입 메서드와 타입 프로퍼티에 접근할 수 있으며 인스턴스 메서드 내에서 사용한다면, 부모 클래스의 인스터스 메서드와 인스턴스 프로퍼티, 서브스크립트에 접근할 수 있다.

// 18.2.1 메서드 재정의
// 부모클래스로부터 상속받은 인스턴스 메서드나 타입 메서드를 자식클래스에서 용도에 맞게 재정의할 수 있다.

/*// Code. 메서드 재정의
class Person {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
    
    class func introduceClass() -> String {
        return "인류의 소원은 평화입니다."
    }
}

class Student: Person {
    var grade: String = "F"
    
    func study() {
        print("Study hard ...")
    }
    
    override func speak() {
        // Student 클래스에서 Person 클래스에 정의된 speak() 메서드 재정의
        print("저는 학생입니다.")
    }
}

class UniversityStudent: Student {
    var major: String = ""
    
    // 반환 타입이 다른 두개의 introduceClass() 메서드 !
    // 스위프트에서는 메서드의 반환 타입이나 매개변수가 다르면 서로 다른 메서드로 취급한다.
    class func introduceClass() {
        print(super.introduceClass())
    }
    override class func introduceClass() -> String {
        // UniversityStudent 클래스에서 Student 클래스에 정의된 introduceClass 메서드 재정의
        return "대학생의 소원은 A+ 입니다."
    }
    
    override func speak() {
        super.speak() // 부모클래스의 메서드에 접근하기 위해 super 프로퍼티 사용
        print("대학생이죠.")
    }
}

let yagom: Person = Person()
yagom.speak()

let jay: Student = Student()
jay.speak()

let jenny: UniversityStudent = UniversityStudent()
jenny.speak()

print(Person.introduceClass())
print(Student.introduceClass())
// 서로 다른타입의 반환 값을 받아오기 위한 as 연산자.
print(UniversityStudent.introduceClass() as String)
UniversityStudent.introduceClass() as Void */

// 18.2.2 프로퍼티 재정의
// 메서드와 마찬가지로 부모클래스로부터 상속받은 인스턴스 프로퍼티나 타입 프로퍼티를 자식 클래스에서 용도에 맞게 재정의할 수 있다.
// 프로퍼티를 재정의한다는 것은 프로퍼티 자체가 아니라 프로퍼티의 접근자, 설정자, 프로퍼티 감시자 등을 재정의하는 것을 말한다.
// 재정의하려는 프로퍼티는 조상클래스 프로퍼티의 이름과 타입이 일치하여야 한다.
// 조상클래스에 없는 프로퍼티를 재정의하려고 한다면 메서드와 마찬가지로 컴파일 오류가 발생한다.

// 조상클래스에서 읽기 전용 프로퍼티였더라도 자식 클래스에서 읽고 쓰기가 가능한 프로퍼티로 재정의해줄 수 있다.
// 그러나 읽기 쓰기 모두 가능했던 프로퍼티를 읽기 전용으로 재정의해줄 수는 없다.
// 읽기 쓰기가 모두 가능한 프로퍼티를 재정의할 때 설정자만 따로 재정의해줄 수는 없으며, 접근자와 설정자를 모두 재정의해주어야 한다.
// 만약 접근자에 따로 기능 변경이 필요하지 않다면 super.someProperty와 같은 식으로 부모클래스의 접근자를 사용하여 값을 받아와 반환해주면 된다.

/*// Code. 프로퍼티 재정의
class Person {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }

    var introduction: String {
        return "이름 : \(name). 나이 : \(age) "
    }
}

class Student: Person {
    var grade: String = "F"

    override var introduction: String {
        return super.introduction + " " + "학점 : \(self.grade)"
    }

    override var koreanAge: Int {
        get{
            return super.koreanAge
    }

        set {
self.age = newValue - 1
        }
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 55
yagom.koreanAge = 56
// 오류가 발생하였는데, 읽기 전용인데 쓰는 요청을 받아 오류가 발생하였다.
//
print(yagom.introduction)
print(yagom.koreanAge)

let jay: Student = Student()
jay.name = "jay"
jay.age = 14
jay.koreanAge = 15
print(jay.introduction)
print(jay.koreanAge)*/


// 18.2.3 프로퍼티 감시자 재정의
// 프로퍼티 감시자도 프로퍼티의 접근자와 설정자처럼 재정의할 수 있다.
// 프로퍼티의 접근자와 프로퍼티 감시자는 동시에 재정의할 수 없다. 둘 다 동작하길 원한다면 재정의하는 접근자에 프로퍼티 감시자의 역할을 구현해야 한다.
/*
// Code. 프로퍼티 감시자 재정의
class Person {
    var name: String = ""
    var age: Int = 0 {
        didSet {
            print("Person age : \(self.age)")
        }
    }
 var koreanAge: Int {
        return self.age + 1
    }
    
    var fullName: String {
        get {
            return self.name
        }
        
        set {
            self.name = newValue
        }
    }
}

class Student: Person {
    var grade: String = "F"
    
    override var age: Int {
        didSet {
            print("Student age : \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
        
        didSet { }
    }
    
    override var fullName: String {
        didSet { // 프로퍼티 감시자 정의
            print("Full Name : \(self.fullName)")
        }
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 55
yagom.fullName = "Jo yagom"
print(yagom.koreanAge)

let jay: Student = Student()
jay.name = "jay"
jay.age = 14
jay.koreanAge = 15
jay.fullName = "Kim jay"
print(jay.koreanAge)


// 18.2.4 서브스크립트 재정의
// 서브스크립트도 메서드와 마찬가지로 재정의가 가능하다. 매개변수와 반환 타입이 다르면 다른 서브스크립트로 취급하므로, 자식클래스에서 재정의하려는 서브스크립트라면 부모클래스 서브스크립트의 매개변수와 반환 타입이 같아야 한다.

// Code. 서브스크립트의 재정의
class School {
    var students: [Student] = [Student]()
    
    subscript(number: Int) -> Student {
        print("School subscript")
        return students[number]
    }
}

class MiddleSchool: School {
    var middleStudents: [Student] = [Student]()

// 부모클래스(School)에게 상속받은 서브스크립트 재정의
    override subscript(index: Int) -> Student {
print("MiddleSchool subscript")
return middleStudents[index]
        }
    }

let university: School = School()
university.students.append(Student())
university[0]

let middle: MiddleSchool = MiddleSchool()
middle.middleStudents.append(Student())
middle[0]*/

// 18.2.5 재정의 방지
// 부모 클래스를 상속받는 자식클래스에서 몇몇 특성을 재정의할 수 없도록 제한하고 싶다면 재정의를 하고 싶지 않은 곳에 final 키워드를 붙이면 된다.
// 재정의를 방지한 특성을 자식클래스에서 재정의하려고 하면 컴파일 오류가 발생한다.

/*// Code. final 키워드의 사용
class Person {
    final var name: String = ""
    
    final func speak() {
        print("가나다라마바사")
    }
}

final class Student: Person {
    // 오류 ! Person 의 name은 final을 사용하여 재정의를 할 수 없도록 하였기 때문
    override var name: String {
        set {
            super.name = newValue
        }
        get {
            return "학생"
        }
    }
    
    // 오류 ! Person의 speak()는 final을 사용하여 재정의를 할 수 없도록 했기 때문
    override func speak() {
        print("저는 학생입니다.")
    }
}

// 오류 ! Student 클래스는 final을 사용하여 상속할 수 없도록 하였기 때문
class UniversityStudent: Student {}
}*/

// 18.3 클래스의 이니셜라이저 - 상속과 재정의
// 이니셜라이저에는 두 종류가 존재하게 되는데, 값 타입과 클래스이다.
// 값 타입 이니셜라이저는 이니셜라이저 위임을 위해 이니셜라이저끼리 구분할 필요가 없었지만, 클래스에서는 지정 이니셜라이저와 편의 이니셜라이저로 역할을 구분한다.
// 또한 값 타입의 이니셜라이저는 상속을 고려할 필요가 없었지만, 클래스는 상속이 가능하므로 상속받았을 때 이니셜라이저를 어떻게 재정의하는지에서도 문제가 생긴다.
// 이렇게 값과 클래스 두 종류의 이니셜라이저가 존재하고 상속이라는 클래스의 특성 때문에 다양한 패턴의 이니셜라이저가 생길 수 있기 때문에 클래스를 디자인할 때 많은 고민이 필요하다.

// 18.3.1 지정 이니셜라이저와 편의 이니셜라이저
// 지정 이니셜라이저는 클래스의 주요 이니셜라이저이다.
// 지정 이니셜라이저는 필요에 따라 부모클래스의 이니셜라이저를 호출할 수 있으며, 이니셜라이저가 정의된 클래스의 모든 프로퍼티를 초기화해야한다.
// 지정 이니셜라이저는 클래스의 이니셜라이저 중 아주 중요한 뼈대 역할을 하므로,여러개를 정의할 수도 있지만 우선 클래스에 하나 이상 정의한다.

// 모든 클래스는 하나 이상의 지정 이니셜라이저를 갖는다. 조상 클래스에서 지정이니셜라이저가 자손 클래스의 지정 이니셜라이저 역할을 충분히 할 수 있다면, 자손클래스는 지정 이니셜라이저를 갖지 않을 수도 있다.

// 편의 이니셜라이저는 초기화를 좀 더 쉽게 도와주는 역할을 한다. 편의 이니셜라이저는 지정 이니셜라이저를 자신 내부에서 호출한다. 지정 이니셜라이저의 매개변수가 많아 외부에서 일일이 전달인자를 전달하기 어렵거나 특정 목적에 사용하기 위해서 편의 이니셜라이저를 설계할 수도 있다.

// 18.3.2 클래스의 초기화 위임
// 지정 이니셜라이저와 편의 이니셜라이저 사이의 관계를 정리하기 위한 세가지 규칙
// 1. 자식클래스의 지정 이니셜라이저는 부모클래스의 지정 이니셜라이저를 반드시 호출해야 한다.
// 2. 편의 이니셜라이저는 자신을 정의한 클래스의 다른 이니셜라이저를 반드시 호출해야 한다.
// 3. 편의 이니셜라이저는 궁극적으로 지정 이니셜라이저를 반드시 호출해야 한다.

// 18.3.3 2단계 초기화
// 스위프트의 클래스 초기화는 2단계 과정을 거친다.
// 1단계로는 클래스에 정의한 각각의 저장 프로퍼티에 초깃값이 할당된다.
// 모든 저장 프로퍼티의 초기 상태가 결정되어지면 2단계인 저장 프로퍼티들을 사용자정의하게 된다.
// 2단계 과정을 거친 후 새로운 인스턴스를 사용할 준비가 끝나게 된다.
// 이러한 단계를 하는 이유는 프로퍼티를 초기화하기 전에 프로퍼티 값에 접근하는 것을 막아 초기화를 안전하게 할 수 있도록 해주기 때문이다.

// 스위프트 컴파일러는 2단계 초기화를 오류 없이 처리하기 위해 4가지 안전확인을 실행한다.
// 1. 자식 클래스의 지정 이니셜라이저가 부모클래스의 이니셜라이저를 호출하기 전에 자신의 프로퍼티를 모두 초기화했는지 확인한다.
// 2. 자식 클래스의 지정 이니셜라이저는 상속받은 프로퍼티에 값을 할당하기 전에 반드시 부모클래스의 이니셜라이저를 호출해야한다.
// 3. 편의 이니셜라이저는 자신의 클래스에 정의한 프로퍼티를 포함하여 그 어떤 프로퍼티라도 값을 할당하기 전에 다른 이니셜라이저를 호출해야 한다.
// 4. 초기화 1단계를 마치기 전까지는 이니셜라이저는 인스턴스 메서드를 호출할 수 없다. 또 인스턴스 프로퍼티의 값을 읽어들일 수도 없다. self 프로퍼티를 자신의 인스턴스를 나타내는 값으로 활용할 수도 없다.

// 4가지 안전확인에 근거하여 2단계의 초기화가 이루어지는 과정을 살펴보겠다.
// 1단계
// 1. 클래스가 지정 또는 편의 이니셜라이저를 호출한다.
// 2. 그 클래스의 새로운 인스턴스를 위한 메모리가 할당된다. 메모리는 아직 초기화되지 않은 상태이다.
// 3. 지정 이니셜라이저는 클래스에 정의된 모든 저장 프로퍼티에 값이 있는지 확인한다. 현재 클래스 부분까지의 저장 프로퍼티를 위한 메모리는 초기화되었다.
// 4. 지정 이니셜라이저는 부모클래스의 이니셜라이저가 같은 동작을 행할 수 있도록 초기화를 양도한다.
// 5. 부모클래스는 상속 체인을 따라 최상위 클래스에 도달할 때가지 이 작업을 반복한다.

// 최상위 클래스에 도달했을 때, 최상위 클래스까지의 모든 저장 프로퍼티에 값이 있다고 확인하면 해당 인스턴스의 메모리는 모두 초기화된 것이다.

// 2단계
// 1. 최상위 클래스로부터 최하위 클래스까지 상속 체인을 따라 내려오면서 지정 이니셜라이저들이 인스턴스를 제각각 사용자정의하게 된다. 이 단계에서는 self를 통해 프로퍼티 값을 수정할 수 있고, 인스턴스 메서드를 호출하는 등의 작업을 진행할 수 있다.
// 2. 마지막으로 각각의 편의 이니셜라이저를 통해 self를 통한 사용자정의 작업을 진행할 수 있다.

/*// Code. Person 클래스를 상속받은 Student 클래스
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {
self.name = name
self.age = age
        }
    }

class Student: Person {
    var major: String
    
    // Student 클래스의 지정 이니셜라이저는 부모클래스의 지정 이니셜라이저를 호출하기 전에 자신의 self 프로퍼티를 이용해 major 프로퍼티의 값을 할당한다.
    init(name: String, age: Int, major: String) {
        self.major = "Swift"
        super.init(name: name, age: age) // super.init을 통해 부모클래스의 이니셜라이저를 호출하였으며, 그 외의 상속받은 프로퍼티가 없으므로 부모의 이니셜라이저 호출 이후에 값을 할당해줄 프로퍼티가 없다.
    }
    
    convenience init(name: String) {
        // 편의 이니셜라이저인 convenience init(name:)은 차후에 따로 값을 할당할 프로퍼티가 없고, 다른 이니셜라이저를 호출했다.
        self.init(name: name, age: 7, major: "")
    }
    // 마지막으로 이니셜라이저 어디에서도 인스턴스 메서드를 호출하거나 인스턴스 프로퍼티의 값을 읽어오지 않았다.
    // 이렇게 안전확인 후 super.init(name: name, age: age)를 통해 1단계와 2단계의 초기화까지 마쳤다.
}*/

// 18.3.4 이니셜라이저 상속 및 재정의
// 부모클래스로부터 물려받은 이니셜라이저는 자식클래스에 최적화되어있지 않기 때문에 부모클래스의 이니셜라이저를 사용했을 때 자식클래스의 새로운 인스턴스가 완전하고 정확하게 초기화되지 않는 상황을 방지하고자 하므로 기본적으로 스위프트의 이니셜라이저는 부모클래스의 이니셜라이저를 상속받지 않는다.
// 안전하고 적절하다고 판단되는 특정한 상황에서는 클래스의 이니셜라이저가 상속되기도 한다(=이니셜라이저 자동 상속).

// 보통 부모클래스의 이니셜라이저와 똑같은 이니셜라이저를 자식클래스에서 사용하고 싶다면 자식클래스에서 부모의 이니셜라이저와 똑같은 이니셜라이저를 구현해주면 된다. 그러기 위해선 override 수식어를 붙여 재정의를 하는 방법이 있다.
// 반대로 부모클래스의 편의 이니셜라이저와 동일한 이니셜라이저를 자식클래스에 구현할 때는 override 수식어를 붙이지 않는다. 자식클래스에서 부모클래스의 편의 이니셜라이즈는 절때 호출할 수 없기 때문이다.(즉 재정의할 수 없다)
/*// Code. 클래스 이니셜라이저의 재정의
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
    self.name = name
    self.age = age
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 0)
    }
}

class Student: Person {
    var major: String
    
    // 지정 이니셜라이저는 재정의를 위해 override 수식어를 사용하였다.
    override init(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    // 부모클래스의 편의 이니셜라이저와 동일한 편의 이니셜라이저를 정의할 때 override 수식어를 붙이지 않았다.
    convenience init(name: String) {
        self.init(name: name, age: 7)
    }
}*/
// 기본 이니셜라이저 외에 지정 이니셜라이저를 자식클래스에서 동일한 이름으로 재정의하려면 재정의를 위한 override 수식어를 명시해주어야 한다.

// 부모클래스의 실패 가능한 이니셜라이저를 자식 클래스에서 재정의하고 싶을 때는 실패 가능한 이니셜라이저로 재정의해도 되고 필요에 따라서 실패하지 않는 이니셜라이저로 재정의해줄 수도 있다.

/*// Code. 실패 가능한 이니셜라이저의 정의
class Person {
    var name: String
    var age: Int

    init() { // 지정 이니셜라이저
        self.name = "Unknown"
        self.age = 0
    }
    
    init?(name: String, age: Int) { // 실패 가능한 이니셜라이저
        
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.age = age
    }
    
    init?(age: Int) { // 실패 가능한 이니셜라이저
        
        if age < 0 {
            return nil
        }
        self.name = "Unknown"
        self.age = age
    }
}

class Student: Person {
    var major: String
    
    override init?(name:String, age: Int) {
        // 부모클래스와 마찬가지의 실패 가능한 이니셜라이저
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    override init(age: Int) {
        // 실패하지 않는 이니셜라이저
        self.major = "Swift"
        super.init()
        }
    }*/
// 이처럼 부모클래스에서는 실패가능한 이니셜라이저였더라도 자식클래스에서는 필요에 따라 실패하지 않는 이니셜라이저로 재정의해줄 수 있다.

// 18.3.5 이니셜라이저 자동 상속
// 자식클래스에서 프로퍼티 기본값을 모두 제공한다고 가정할 때, 다음 두 가지 규칙에 따라 이니셜라이저가 자동으로 상속된다.
// 1. 자식클래스에서 별도의 지정이니셜라이저를 구현하지 않는다면, 부모클래스의 지정 이니셜라이저가 자동으로 상속된다.
// 2. 만약 1번에 따라 자식클래스에서 부모클래스의 지정 이니셜라이저를 자동으로 상속받은 경우 또는 부모클래스의 지정 이니셜라이저를 모두 재정의하여 부모클래스와 동일한 지정 이니셜라이저를 모두 사용할 수 있는 상황이라면 부모클래스의 편의 이니셜라이저가 모두 자동으로 상속된다.

/*// Code. 이니셜라이저 자동 상속
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student: Person {
    var major: String = "Swift" // major 프로퍼티에 기본값이 있고, 따로 지정 이니셜라이저를 구현해주지 않았으므로 부모클래스인 Person 클래스의 지정 이니셜라이저가 자동으로 상속된다.
    }

// 부모클래스의 지정 이니셜라이저 자동 상속
let yagom: Person = Person(name: "yagom")
let hana: Student = Student(name: "hana")
print(yagom.name)
print(hana.name)

// 부모 클래스의 지정 이니셜라이저를 모두 자동으로 상속 받았으므로 편의 이니셜라이저도 자동 상속
let wizplan: Person = Person()
let jinSung: Student = Student()
print(wizplan.name) // Unknown
print(jinSung.name) // Unknown */

/*// Code. 편의 이니셜라이저 자동 상속
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student: Person {
    var major: String
    override init(name: String) {
        // major 프로퍼티에 기본값이 없더라도 이니셜라이저에서 적절하게 초기화하였다.
        self.major = "Unknown"
        // 또한 부모클래스의 지정 이니셜라이저를 모두 재정의하여 부모클래스의 지정 이니셜라이저와 동일한 이니셜라이저를 모두 사용할 수 있다.
        super.init(name: name)
    }
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}

// 부모 클래스의 편의 이니셜라이저 자동 상속
let wizplan: Person = Person()
let jinSung: Student = Student()
print(wizplan.name)
print(jinSung.name)*/

// 18.3.6 요구 이니셜라이저
// required 수식어를 클래스의 이니셜라이저 앞에 명시해주면 이 클래스를 상속받은 자식클래스에서 반드시 해당 이니셜라이저를 구현해주어야 한다.
// 상속받을 때 반드시 재정의해야하는 이니셜라이저 앞에 required 수식어를 붙여준다.
// 다만 자식클래스에서 요구 이니셜라이저를 재정의할 때는 override 수식어 대신에 required 수식어를 사용한다.

/*// Code. 요구 이니셜라이저 정의
class Person {
    var name: String
    // 요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}
class Student: Person {
    var major: String = "Unknown" // major 프로퍼티에 기본값이 존재하므로 이니셜라이저가 자동으로 상속되었다.
}

let miJeong: Student = Student()*/


// 만약 Student 클래스에 새로운 지정 이니셜라이저를 구현한다면 부모클래스로부터 이니셜라이저가 자동으로 상속되지 않으므로 요구 이니셜라이저를 구현해주어야 한다.

/*// Code. 요구 이니셜라이저 구성
class Person {
    var name: String
    
    //요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student: Person {
    var major: String = "Unknown"
    
    // 자신의 지정 이니셜라이저 구현
    init(major: String) {
        self.major = major
        super.init()
    }
    
    required init() {
        self.major = "Unknown"
        super.init()
    }
}
class UniversityStudent: Student {
    var grade: String
    
    // 자신의 지정 이니셜라이저 구현
    init(grade: String) {
        self.grade = grade
        super.init()
}
    required init() {
        self.grade = "F"
        super.init()
    }
}

let jiSoo: Student = Student()
print(jiSoo.major)

let yagom: Student = Student(major: "Swift")
print(yagom.major)

let juHyun: UniversityStudent = UniversityStudent(grade: "A+")
print(juHyun.grade) */

// Student와 UniversityStudent 모두 자신만의 지정 이니셜라이저를 구현하였으므로 부모클래스의 이니셜라이저를 자동으로 상속받지 못한다. 그렇기 때문에 Person 클래스에 정의한 요구 이니셜라이저를 이니셜라이저 자동 상속 규칙에 부합하지 않는 자식클래스인 Student와 그의 자식 클래스인 UniversityStudent 클래스에 구현해주어야 한다.
// 이니셜라이저 자동 상속의 규칙에 부합하지 않는 한, 요구 이니셜라이저는 반드시 구현해주어야 한다.

// 부모 클래스의 일반 이니셜라이저를 자신의 클래스로부터 요구 이니셜라이저로 변경할 수도 있는데, 그럴때에는 required override를 명시해주어 재정의됨과 동시에 요구 이니셜라이저가 될 것임을 명시해주어야 한다.
// 또 편의 이니셜라이저도 요구 이니셜라이저로 변경될 수 있다.(required convienience를 명시)

// Code. 일반 이니셜라이저의 요구 이니셜라이저 정의
class Person {
    // Person 클래스에는 별다른 요구 이니셜라이저가 없다.
    var name: String
    
    init() {
        self.name = "Unknown"
    }
}

class Student: Person {
    var major: String = "Unknown"
    
    init(major: String) {
        self.major = major
        super.init()
    }
    
    // 부모 클래스의 이니셜라이저를 재정의함과 동시에 요구 이니셜라이저로 변경됨을 알린다.
    required override init() {
        self.major = "Unknown"
        super.init()
    }
    
    // 이 요구 이니셜라이저는 앞으로 계속 요구한다.
    // 편의 이니셜라이저 init(name:)이 요구 이니셜라이저로 지정되어있기 때문에 UniversityStudent 클래스에서 다시 구현해주어야 한다.
    required convenience init(name: String) {
        self.init()
        self.name = name
        }
    }

class UniversityStudent: Student {
    var grade: String
    
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    // Student 클래스에서 요구했으므로 구현해주어야 한다.
    required init() {
        self.grade = "F"
        super.init()
    }
    // Student 클래스에서 요구했으므로 구현해주어야 한다.
    required convenience init(name: String) {
        self.init()
        self.name = name
        }
    }

let yagom: UniversityStudent = UniversityStudent()
print(yagom.grade)

let juHyun: UniversityStudent = UniversityStudent(name: "JuHyun")
print(juHyun.name)


