import UIKit

// Chapter 8. 옵셔널

// 옵셔널은 값이 있을 수도, 없을 수도 있음을 나타내는 표현이다.
// 변수나 상수에서 꼭 값이 있음을 보장할 수 없음을 나타낸다.

// 8.1 옵셔널 사용
// ""로 빈 문자열을 만들었다면 이것도 문자열이 비어있다는 값을 표현하는 것이지 값이 없는게 아니다.
// 변수 또는 상수에 정말 값이 없을 경우에만 nil로 표현한다.

// 옵셔널을 읽을 때 '해당 변수 또는 상수에는 값이 없을 수 있다. 즉, 변수 또는 상수가 nil일 수도 있으므로 사용에 주의해라'는 뜻을 가지고 있다.

// 코드 8-1 오류가 발생하는 nil 할당.
//var myName: String? = "yagom"
//print(myName)
//
//myName = nil
//print(myName)

// 왜 굳이 nil을 사용해야 할까 ?
// 1. 전달하려는 전달 값이 잘못된 값일 경우 제대로 처리하지 못한 것을 나타내기 위해
// 2. 매개변수를 굳이 넘겨주지 않아도 되는 경우

// 옵셔널 열거형의 정의
//public enum Optional<Wrapped> : ExpressibleByNilLiteral {
//    case none // nil 일 경우
//    case some(Wrapped) // 값이 있는 경우는 some이지만, 연관값으로는 wrapped가 있다.
//    // 옵셔널에 값이 있으면 some의 연관 값인 Wrapped에 값이 할당된다. 값이 옵셔널이라는 열거형 안에 감싸져 있는 모습이다.
//    public init(_ some: Wrapped)
//}
    // switch를 통한 옵셔널 값의 확인
    func checkOptionalValue(value optionalValue: Any?){
        switch optionalValue {
        case .none:
            print("This Optional variable is nil")
        case .some(let value):
            print("Value is \(value)")
        }
    }
    
    var myName1: String? = "yagom"
    checkOptionalValue(value: myName1)
    
    myName1 = nil
    checkOptionalValue(value: myName1)

// 여러 케이스의 조건을 통해 검사를 한다면 더욱 옵셔널의 필요성을 알게 될 것 같다.

// switch를 통한 옵셔널 값의 확인

let numbers: [Int?] = [2,nil,-4,nil,100]

for number in numbers {
    switch number {
    case .some(let value) where value < 0:
        print("Negative value!! \(value)")
    case .some(let value) where value > 10:
        print("Large value !! \(value)")
    case .some(let value):
        print("Value \(value)")
    case .none:
        print("nil")
    }
}

// 8.2 옵셔널 추출
// 열거형의 some 케이스로 옵셔널의 값을 옵셔널이 아닌! 값(value)으로 추출하는 옵셔널 추출방법.

// 8.2.1 강제 추출
// 옵셔널 강제 추출이란 옵셔널의 값을 강제로 꺼내는 방법
// 옵셔널의 값을 강제로 추출하려면 느낌표를 붙여 강제로 추출을 하게 되는데, 옵셔널 안에 값이 없다면(=nil이라면), 런타임 오류가 발생한다.

// 코드. 옵셔널 값의 강제 추출
var gangName: String? = "yagom"

// 옵셔널이 아닌 변수에는 옵셔널 값이 들어갈 수 없으므로 추출하여 할당하여야 한다.
var yagom: String = gangName!

gangName = nil
//yagom = gangName!

// if 구문인 조건문을 활용하여 안전하게 처리 한 방법
if gangName != nil {
    print("My name is \(gangName!)")
} else {
    print("myName == nil")
}

// 8.2.2 옵셔널 바인딩
// nil을 체크하고, 안전한 추출을 가능하게 하기 위함.

// 옵셔널 바인딩을 사용한 옵셔널 값의 추출

var optionalName: String? = "yagom"

// 옵셔널 바인딩을 통한 임시 상수 할당
if let name = optionalName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}

// 옵셔널 바인딩을 통한 임시 변수 할당 과정 추가
if var name = optionalName {
    name = "wizplan" // 변수이므로 내부에서 변경이 가능합니다.
    // name이라는 임시 상수 사용.
    print("My name is \(name)")
} else {
    print("myName == nil")
}

// 8-8 옵셔널 바인딩을 사용한 여러 개의 옵셔널 값의 추출
var myName_op: String? = "yagom"
var yourName_op: String? = nil

//// friend에 바인딩이 되지 않으므로 실행되지 않습니다.
//if let name_op = myName_op, let friend_op = yourName_op {
//    print("We are friend!")
//}

yourName_op = "eric"

if let name_op = myName_op, let friend_op = yourName_op {
    print("We are friend! \(name_op) & \(friend_op)")
}

// 8.2.3 암시적 추출 옵셔널
// nil을 할당하고 싶지만, 옵셔널 바인딩으로 매번 값을 추출하기 귀찮거나 로직상 nil 때문에 런타임 오류가 발생하지 않을 것 같다는 확신이 들 때 nil을 할당해줄 수 있는 옵셔널이 아닌 변수나 상수가 필요하다.

// 옵셔널을 표시할 때에는 물음표를 사용했지만, 암시적 추출 옵셔널을 사용할 때는 타입 뒤에 느낌표가 필요하다.
// 암시적 옵셔널로 지정된 타입은 일반 값처럼 사용할 수 있으나, 옵셔널이기 때문에 nil도 할당해줄 수 있다.
// nil이 할당되어 있을 때 접근을 시도하면 런타임 오류가 난다.

// 암시적 추출 옵셔널의 사용
var maName: String! = "yagom"
print(maName)
maName = nil

// 암시적 추출 옵셔널도 옵셔널이므로 당연히 바인딩을 사용할 수 있다.
if var named =  maName {
    print("My name is \(named)")
} else {
    print("myName == nil")
}
//maName이라는 변수에는 nil이 할당되어있으므로, isEmpty를 했을 때에 오류가 발생한다.
//maName.isEmpty
