import UIKit

// 17. 서브스크립트
// 서브스크립트는 단축 문법을 정의한다고 생각할 수 있는데, 별도의 설정자나 접근자와 같은 메서드를 구현하지 않아도 인덱스를 통해 값을 설정하거나 가져올 수 있다.
// 한 타입에 여러 개의 서브스크립트를 정의할 수 있으며 다른 타입을 인덱스로 갖는 여러개의 서브스크립트를 중복 정의할 수도 있다.

// 17.1 서브스크립트 문법
// 서브스크립트는 인스턴스의 이름 뒤에 대괄호로 감싼 값을 써줌으로써 인스턴스 내부의 특정값에 접근할 수 있다.
// 서브스크립트는 subscript 키워드를 사용하여 정의하고, 인스턴스 메서드와 비슷하게 매개변수의 갯수, 타입, 반환 타입등을 지정하며, 읽고 쓰기가 가능하도록 구현하거나 읽기 전용으로만 구현할 수 있다.(접근자와 설정자를 사용할 수 있는 연산 프로퍼티의 형태와 유사하다.)

//// Code. 서브스크립트 정의 문법
//subscript(index: Int) -> Int {
//    get {
//        // 적절한 서브스크립트 결괏값 반환
//    }
//    set(newValue) {
//        // 적절한 설정자 역할 수행
//    }
//}

//// Code. 읽기 전용 서브스크립트 정의 문법
//subscript(index: Int) -> Int {
//    get {
//        // 적절한 서브스크립트 값 반환
//    }
//}
//
//subscript(index: Int) -> Int {
//    // 적절한 서브스크립트 결괏값 반환
//}

// 17.2 서브스크립트 구현
// 서브스크립트는 자신이 가지는 시퀀스나 컬렉션, 리스트 등의 요소를 반환하고 설정할 때 주로 사용된다.
/*
// Code. School 클래스 서브스크립트 구현
struct Student {
    var name: String
    var number: Int
}

class School {
    
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    // 읽기 전용 서브스크립트 : 학생의 번호를 전달인자로 전달받아 자신이 students 프로퍼티의 인덱스에 맞는 Student 인스턴스를 반환한다.
    subscript(index: Int) -> Student? {
        if index < self.number {
            return self.students[index]
        }
        return nil
    }
}
let highSchool: School = School()
highSchool.addStudents(names: "MiJeong", "JuHyun", "JiYoung", "SeongUk", "MoonDuk")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)")
*/
// 17.3 복수 서브스크립트
// 다양한 매개변수 타입을 사용하여 서브스크립트를 구현하면 여러 용도로 서브스크립트를 사용할 수 있다.

// Code. 복수의 서브스크립트 구현
struct Student {
    var name: String
    var number: Int
}

class School {
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    subscript(index: Int) -> Student? { // 첫 번째 서브스크립트
            // 학생의 번호를 전달받아 해당하는 학생이 있다면 Student 인스턴스를 반환하거나 특정 번호에 학생을 할당하는 서브스크립트
        get {
            if index < self.number {
                return self.students[index] 
            }
            return nil
    }

        set {
            guard var newStudent: Student = newValue else {
                return
            }
            
            var number: Int = index // 특정 번호에 학생을 할당
            
            if index > self.number {
                number = self.number
                self.number += 1
            }
            
            newStudent.number = number
            self.students[number] = newStudent
        }
    }
    
    subscript(name: String) -> Int? { // 두 번째 서브스크립트
            // 학생의 이름을 전달받아 해당하는 학생이 있다면 번호를 반환하거나 특정 이름의 학생을 해당 번호에 할당하는 서브스크립트
        get {
            return self.students.filter{ $0.name == name }.first?.number
    }

        set {
            guard var number: Int = newValue else {
                return // 학생이 있다면 번호 반환
            }
            
            if number > self.number {
                number = self.number
                self.number += 1
            }
            
            let newStudent: Student = Student(name: name, number: number)
            self.students[number] = newStudent // 특정 이름의 학생을 해당 번호에 할당
        }
    }
    subscript(name: String, number: Int) -> Student? { // 세 번째 서브스크립트
        return self.students.filter{ $0.name == name && $0.number == number }.first
        // 이름과 번호를 전달받아 해당하는 학생이 있다면 찾아서 Student 인스턴스 반환
    }
}

let highSchool: School = School()
highSchool.addStudents(names: "MiJeong", "JuHyun", "JiYoung", "SeongUk", "MoonDuk")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)")
Optional("JuHyun")

print(highSchool["MiJeong"])
print(highSchool["DongJin"])

highSchool[0] = Student(name: "HongEui", number: 0)
highSchool["MangGu"] = 1

print(highSchool["JuHyun"])
print(highSchool["MangGu"])
print(highSchool["SeongUk", 3])
print(highSchool["HeeJin", 3])


// '복수의 서브스크립트 구현'코드 에서 확인할 수 있듯이, 서브스크립트는 인스턴스 이름 뒤에 대괄호만 써서 편리하게 내부 값에 접근하고 설정해줄 수 있다.
