import UIKit

// 12. 접근제어
// 접근제어란 코드끼리 상호작용을 할 때 파일 간 또는 모듈 간에 접근을 제한할 수 있는 기능.
// 접근제어는 코드의 상세 구현을 숨기고, 허용된 기능만 사용하는 심플한 인터페이스를 제공할 수 있다.

// 12.1.1 접근제어의 필요성
// 캡슐화와 은닉화를 구현하는 이유는 외부에서 보거나 접근하면 안되는 코드가 있기 때문이다.
// 불필요한 접근으로 인해 전체 코드가 노출될 가능성이 있을 때 접근제어를 이용한다.


// 12.1.2 모듈과 소스파일
// 모듈 : 배포할 코드의 묶음 단위
// 소스파일 : 하나의 스위프트 소스 코드 파일

// 12.2 접근수준
// 접근 수준 명시 키워드 다섯가지 : open, public, internal, fileprivate, private

// 12.2.1 공개 접근수준 public
// public 키워드로 접근수준이 지정된 요소는 어디서든 쓰일 수 있다.(모듈 외부까지도 사용 가능)
// public 으로 접근을 하는 수준으로는 주로 프레임워크에서 외부와 연결될 인터페이스를 구현하는데 많이 쓰인다.
// 우리가 사용하고 있는 스위프트의 기본 요소는 모두 public으로 구현되어있다.

// 12.2.2 개방 접근수준 open
// open 키워드의 접근수준은 공개 접근수준 이상으로 높은 접근수준이다.
// !!!!!!!!!! 클래스와 클래스 멤버에서만 사용 가능하다 !!!!!!!!!!

// public과 비슷하지만 다른 차이점이 존재한다.
// 1. 개방 접근수준(=open)을 제외한 다른 모든 접근수준의 클래스나 클래스 멤버는 그 클래스나 클래스 멤버가 정의된 모듈안에서만 사용가능하다.
// 즉, open를 사용하면 클래스나 클래스 멤버가 정의된 모듈 밖에서도 사용가능하다는 것 !!!
// 클래스를 개방 접근수준으로 명시하는 것은 그 클래스를 다른 모듈에서도 부모클래스로 사용하겠다는 목적으로 클래스를 설계하고 코드를 작성했음을 의미한다.

// Foundation 프레임워크에 정의되어있는 개방 접근수준의 NSString 클래스
//open class NSString : NSObject, NSCopying, NSMutableCopying, NSSecureCoding {
//    open var length: Int { get }
//    open func character(at index: Int) -> unichar
//    public init()
//    public init?(coder aDecoder: NSCoder)
//}

// 12.2.3 내부 접근수준 internal
// internal으로 접근을 하는 수준으로는 기본적으로 모든 요소에 암묵적으로 지정하는 기본 접근수준이다.
// 내부 접근수준으로 지정된 요소는 소스파일이 속해 있는 모듈 어디에서든 쓰일 수 있다.

// 12.2.4 파일외부비공개 접근수준 fileprivate
// 파일외부비공개 접근수준으로 지정된 요소는 그 요소가 구현된 소스파일 내부에서만 사용할 수 있다.
// 해당 소스파일 외부에서 값이 변경되거나 함수를 호출하면 부작용이 생길 수 있다.

// 12.2.5 비공개 접근수준 private
// 가장 한정적인 접근수준으로써, 그 기능을 정의하고 구현한 범위 내에서만 사용할 수 있다.
// 비공개 접근수준으로 지정한 기능은 같은 소스파일안에 구현한 다른 타입이나 기능에서도 사용할 수 없다.

// 12.3 접근제어 구현
// 접근제어는 접근수준을 지정해서 구현할 수 있다.
// 기본 접근수준은 internal이다.

// Code. 접근수준을 명기한 각 요소들의 예
//open class OpenClass {
//    open var openProperty: Int = 0
//    public var publicProperty: Int = 0
//    internal var internalProperty: Int = 0
//    fileprivate var filePrivateProperty: Int = 0
//    private var privateProperty: Int = 0
//
//    open func openMethod() {}
//    public func publicMethod() {}
//    internal func internalMethod() {}
//    fileprivate func fileprivateMethod() {}
//    private func privateMethod() {}
//}
//
//public class PublicClass {}
//public struct PublicStruct {}
//public enum PublicEnum {}
//public var publicVariable = 0
//public let publicConstant = 0
//public func publicFunction() {}
//
//internal class InternalClass {}
//internal struct InternalStruct {}
//internal enum InternalEnum {}
//internal var internalVariable = 0
//internal let internalConstant = 0
//internal func internalFunction() {}
//
//fileprivate class FilePrivateClass {}
//fileprivate struct FilePrivateStruct {}
//fileprivate enum FilePrivateEnum {}
//fileprivate var FilePrivateVariable = 0
//fileprivate let FilePrivateConstant = 0
//fileprivate func FilePrivateFunction() {}
//
//private class PrivateClass {}
//private struct PrivateStruct {}
//private enum PrivateEnum {}
//private var PrivateVariable = 0
//private let PrivateConstant = 0
//private func PrivateFunction() {}

// 12.4 접근제어 구현 참고사항
// 상위 요소보다 하위 요소가 더 높은 접근수준을 가질 수 없다.

// Code. 접근수준에 따른 접근 결과
// AClass.swift 파일과 Common.swift 파일이 같은 모듈에 속해 있을 경우를 가정.

//
//class AClass {
//    func internalMethod() {}
//    fileprivate func filePrivateMethod() {}
//    var internalProperty = 0
//    fileprivate var filePrivateProperty = 0
//}
//
//let aInstance: AClass = AClass()
//aInstance.internalMethod()
//aInstance.filePrivateMethod()
//aInstance.internalProperty = 1
//aInstance.filePrivateProperty = 1

// 12.5 private와 fileprivate
// fileprivate 접근수준으로 지정한 요소는 같은 파일 어떤 코드에서도 접근할 수 있다.
// private 접근수준으로 지정한 요소는 파일 내부에 다른 타입의 코드가 있더라도 접근 불가능하지만, 자신을 확장하는 익스텐션과 같은 코드가 같은 파일에 존재할 경우에는 접근할 수 있다.

// 12.6 읽기 전용 구현
// 구조체 또는 클래스를 사용하여 저장 프로퍼티를 구현할 때는 허용된 접근수준에서 프로퍼티 값을 가져갈 수 있으나, 읽기만을 전용으로 하려고 할 때에는 요소의 접근 키워드 뒤에 (set)을 표현하면 설정자의 접근수준만 더 낮도록 지정할 수 있다.

// Code. 설정자의 접근수준 지정
public struct SomeType {
    // 비공개 접근수준 저장 프로퍼티 count
    private var count: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicStoredProperty
    public var publicStoredProperty: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicGetOnlyStoredProperty
    // 설정자는 비공개 접근수준
    public private(set) var publicGetOnlyStoredProperty: Int = 0
    
    // 내부 접근수준 저장 프로퍼티 internalComputedProperty
    internal var internalComputedProperty: Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    
    public subscript() -> Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    // 설정자는 내부 접근수준
    public internal(set) subscript(some: Int) -> Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
}

var someInstance: SomeType = SomeType()

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance.publicStoredProperty)
someInstance.publicStoredProperty = 100

// 외부에서 접근자만 사용 가능
print(someInstance.publicGetOnlyStoredProperty)

