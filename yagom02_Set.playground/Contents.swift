import Foundation

//Set
//배열과 마찬가지로 대괄호를 사용하여 세트 안의 값 설정
var names: Set<String> = ["yagom", "chulsoo", "younghee", "yagom"]

//배열과 마찬가지의 값 설정을 하였기 때문에, 타입 추론을 사용하게 되면 컴파일러는 Set가 아닌 Array로 타입을 지정.

var numbers = [100,200,300]
print(type(of: numbers)) //Array<Int>

print(names.isEmpty)
print(names.count)

//집합의 연산을 통한 세트의 활용.
let englishClassStudents: Set<String> = ["John", "chulsoo", "yagom"]
let koreanClassStudents: Set<String> = ["jenny", "yagom", "chulsoo", "hana", "minsoo"]

//교집합.
let intersetSet: Set<String> = englishClassStudents.intersection(koreanClassStudents)

//여집합의 합 (배타적 논리합)
let symmetricDiffSet: Set<String> =
englishClassStudents.symmetricDifference(koreanClassStudents)

//합집합
let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents)

//차집합
let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents)

print(unionSet.sorted())

let 새: Set<String> = ["비둘기", "닭", "기러기"]
let 포유류: Set<String> = ["사자", "호랑이", "곰"]
let 동물: Set<String>  = 새.union(포유류)

print(새.isDisjoint(with: 포유류)) // 서로 배타적인 관계인지.
print(새.isSubset(of: 동물))// 새가 동물의 부분집합인가요?
print(동물.isSuperset(of: 포유류))//동물은 포유류의 전체집합인가요?
print(동물.isSuperset(of: 새)) //동물은 새의 전체집합인가요?


//enum
//c언어는 열거형의 각 항목값이 정수 타입으로 기본 지정되지만, 스위프트의 열거형에서는 각 항목이 그 자체의 고유값으로 될 수 있다.

//School 열거형의 선언 및 열거형의 원시값 일부 지정 및 자동 처리.
enum School: String {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college
    case university
    case graduate
}
 let highestEducationLevel: School = School.university
print("저의 최종학력은 \(highestEducationLevel.rawValue) 졸업입니다.")

print(School.elementary.rawValue)
print(School.college.rawValue)

enum Numbers: Int {
    case zero
    case one
    case two
    case ten = 10
}

print("\(Numbers.zero.rawValue), \(Numbers.one.rawValue), \(Numbers.two.rawValue),\(Numbers.ten.rawValue)")

//연관 값
//열거형 내의 항목(case)이 자신과 연관된 값을 가질 수 있다. 다른 항목이 연관 값을 갖는다고 해서 모든 항목이 연관값을 가질 필요는 없다.

//연관 값을 갖는 열거형
//enum MainDish {
//    case pasta(taste: String)
//    case pizza(dough: String, topping: String)
//    case chicken(withSauce: Bool)
//    case rice
//}


//여러 열거형의 응용
enum PastaTaste {
    case cream, tomato
}

enum PizzaDough {
    case cheeseCrust, thin, original
}

enum PizzaTopping {
    case pepperoni, cheese, bacon
}

enum MainDish {
    case pasta(taste: PastaTaste)
    case pizza(dough: PizzaDough, topping: PizzaTopping)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: PastaTaste.tomato)
dinner = MainDish.pizza(dough: PizzaDough.cheeseCrust, topping:PizzaTopping.bacon)



//알고리즘 공부를 할 때 필요한 순환 열거형
//사실 왜하는지 잘 모르겠다만 산술연산, 이진 탐색 트리와 같은 순환 알고리즘을 구현할 때 유용하다.

//특정 항목에 순환 열거형 항목 명시
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}

//순환 열거형의 사용
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression)-> Int{
    switch expression {
    case .number(let value):
        return value
        
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left)*evaluate(right)
    }
}

let result: Int = evaluate(final)
print("(5+4)*2=\(result)")
