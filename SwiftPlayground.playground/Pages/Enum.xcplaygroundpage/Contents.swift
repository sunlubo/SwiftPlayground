/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Enum
 */
/*:
 ----
 ## 关联值
 */
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

let productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

if case .QRCode(let v) = Barcode.QRCode("12345") {
    print(v)
}

//guard case .QRCode(let v) = Barcode.QRCode("12345") else {
//    return
//}
/*:
 ----
 ## 原始值
 */
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let tab = ASCIIControlCharacter(rawValue: "\t")
tab?.rawValue

enum Gender: String {
    case male
    case female
}
extension Gender: CustomStringConvertible {
    var description: String {
        switch self {
        case .male:
            return "男"
        case .female:
            return "女"
        }
    }
}

let man = Gender.male
man.rawValue
man.description
/*:
 ----
 ## 递归
 */
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 表明所有成员都是可递归的
//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

// 要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, .number(2))

evaluate(product)
/*:
 ----
 ## Other
 */
func add(a: Int, b: Int) -> Int { return a + b }

add(a: 1, b: 2)
add(a:b:)(1, 2)

let fn = add(a:b:) // (Int, Int) -> Int
fn(1, 2)


enum Foo {
    case bar(x: Int, y: Int)
}

let barInit1 = Foo.bar // (Int, Int) -> Foo
//let barInit2 = Foo.bar(x:y:) // error

let bar1 = barInit1(x: 0, y: 1)
//let bar2 = barInit1(0, 1) // error

if case let .bar(x: p, y: q) = Foo.bar(x: 0, y: 1) {
    print(p, q)
}

if case let .bar(wat) = Foo.bar(x: 0, y: 1) {
    print(wat.y)
}

// note: there's no label in the following pattern
if case let .bar(p, q) = Foo.bar(x: 0, y: 1) {
    print(p, q) // 0 1
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
