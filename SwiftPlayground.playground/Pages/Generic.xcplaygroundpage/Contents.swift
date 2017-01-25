/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # 关联类型与泛型
 */
import Foundation

class A {}
class B: A {}

/*:
 ----
 ## 关联类型
 */
protocol _Sequence { // 协议只能使用关联类型，不能使用泛型
    associatedtype Iterator: IteratorProtocol // 协议约束
    // associatedtype Index == Int // 类型约束，没有必要存在
    // associatedtype SubSequence: Sequence // unsupport recursive constraints on associated types
    // where SubSequence.Iterator.Element == Iterator.Element // SE-0142: Permit where clauses to constrain associated types
}
protocol _Collection {
    associatedtype IndexDistance: SignedInteger = Int // 指定默认关联类型
}

struct IntegerIterator: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}
struct _SequenceImp: _Sequence {
    typealias Iterator = IntegerIterator
}


protocol Proto1 {
    associatedtype AssocType
}
protocol Proto2: Proto1 {
    associatedtype AssocType
}

struct SomeStruct: Proto2 {
    typealias AssocType = Int
}


protocol P1 {
    associatedtype AT
}
extension P1 where AT: A {
    func fn() {}
}

class SomeClass: P1 {
    typealias AT = B
}

let obj = SomeClass()
obj.fn()
/*:
 ----
 ### 扩展 - 关联类型（协议）
 */
// extension ProtocolName where #associatedtype == #ConcreteType // 关联类型必须为对应类型
extension Sequence where Iterator.Element == Int {}

// extension ProtocolName where #associatedtype: #ProtocolName // 关联类型必须实现对应协议
extension Sequence where Iterator.Element: Integer {}

// extension ProtocolName where #associatedtype: #ClassType // 关联类型为对应类型及其子类型
extension Sequence where Iterator.Element: NSDictionary {}

// extension IteratorProtocol: EmptyProtocol {} // error: extension of protocol 'IteratorProtocol' cannot have an inheritance clause
/*:
 ----
 ## 泛型
 */
// struct TypeName<#GenericType: #ProtocolName> // T为实现指定协议的类型
struct S1<T: Integer> {} // T为满足Integer协议的类型
let s1 = S1<Int>()

// struct TypeName<#GenericType: #CassType> // T为指定类型及其子类型
struct S2<T: A> {} // T为类型A及A的子类
let s2 = S2<A>()
let s3 = S2<B>()

// struct TypeName<#GenericType: #ValueType> // unsupport

// struct TypeName<#GenericType> where #condition // 泛型必须满足where子句指定的条件
struct S3<T: Sequence, U: Sequence> where T.Iterator.Element == U.Iterator.Element {} // T、U为满足Sequence协议的类型，并且两者的Element类型一致
let s4 = S3<[Int], [Int]>()


func log<T>(msg: T) { print(msg) }
func fn<T: Equatable, U: Equatable>(t: T, u: U) {}

func outer<T>(t: T) -> T {
    func inner<U>(u: U) -> (T, U) {
        return (t, u)
    }
    return inner(u: (t, t)).0
}

class Base<T> {
    let t: T
    init(t: T) {
        self.t = t
    }
}

class Derived<T>: Base<T> {
    // init(t: T) is now synthesized to call super.init(t: t)
}

let derived = Derived(t: 1) // Derived<Int>

class Meat {}
class Chunks<T> {}
class Molerat {}

func f<Food: Chunks<Meat>, Meat: Molerat>(f: Food, m: Meat) {}
f(f: Chunks(), m: Molerat())
/*:
 ----
 ### 扩展 - 泛型
 */
protocol EmptyProtocol {}

// extension TypeName where #genericType == #ConcreteType // 泛型必须为对应类型，swift 3.1
// extension Array where Element == Int {} // 类型约束，swift 3.1

// extension TypeName where #genericType: #ProtocolName // 泛型必须实现对应协议
extension Array where Element: Integer {} // 协议约束

// extension TypeName where #genericType: #ClassType // 泛型为对应类型及其子类型
extension Array where Element: NSDictionary {}

// extension TypeName: #ProtocolName // 通过扩展实现协议
extension Array: EmptyProtocol {}

// extension TypeName: #ProtocolName where #genericType == #ConcreteType // SE-0143: Conditional conformances
// extension Array: EmptyProtocol where Element == Int {}

// extension TypeName: #ProtocolName where #genericType: #ProtocolName // SE-0143: Conditional conformances
// extension Array: Equatable where Element: Equatable {}

// extension TypeName: #ProtocolName where #genericType: #ClassType // SE-0143: Conditional conformances
// extension Array: EmptyProtocol where Element: NSDictionary {}
/*:
 ----
 ### 泛型别名
 */
typealias StringDictionary<T> = Dictionary<String, T>
typealias IntFunction<T> = (T) -> Int
typealias MatchingTriple<T> = (T, T, T)
typealias BackwardTriple<T1, T2, T3> = (T3, T2, T1)
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
