/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Type
 */
/*:
 ****
 ## 变/常量声明与类型推断
 */
var variable = "variable" // variable
let constant = "constant" // constant

let str1 = "hello" // type inferred
let str2: String = "hello" // explicit type declaration

let double = 1.0 // in default, floating-point literal is 'Double'
let float1: Float = 1.0
let float2 = 1.0 as Float // specify the type of a literal expression
/*:
 ****
 ## 基本类型 - Int、Float、Double、Bool、String
 */
let integer = 1
let float = 1.0 as Float
let double_ = 1.0
let bool = true
let string = "hello, swift"

// 数值型字面量
let decimalInteger = 17             // 十进制的17
let binaryInteger = 0b10001         // 二进制的17
let octalInteger = 0o21             // 八进制的17
let hexadecimalInteger = 0x11       // 十六进制的17
let decimalDouble = 12.1875         // 十进制的12.1875
// 十进制浮点数也可以有一个可选的指数，通过大写或者小写的 e 来指定
let exponentDouble = 1.21875e1      // 指数形式
// 十六进制浮点数必须有一个指数，通过大写或者小写的 p 来指定
let hexadecimalDouble = 0xC.3p0     // 十六进制形式：12.3 x 2^0

// 可读性
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
/*:
 ****
 ## 集合 - Array、Set、Dictionary
 */
let array = [1, 2, 3] // ordered
let set = [1, 2, 3] as Set // unordered
let dictionary = ["name": "sun", "age": 23] as [String: Any]

var mutableArray = [String]()
mutableArray.append("hello")
mutableArray.append(contentsOf: [", ", "world"])
mutableArray.joined()

let immutableArray = [String]()
/*:
 ****
 ## 元组
 */
let http404Error = (404, "Not Found") // => (Int, String)
let http200Status = (statusCode: 200, description: "OK") // => (statusCode: Int, description: String)

var result1 = http404Error // => (Int, String)
var result2 = http200Status // => (statusCode: Int, description: String)
var result3: (Int, String) = http200Status // => (Int, String)

result3 = result1 // http404Error
result1 = result2 // http200Status
result2 = result3 // http404Error

result2.statusCode // output: 404
result2.description // output: "Not Found"
// <==>
// let result2: (statusCode: Int, description: String) = result3
// result2.statusCode // output: 404
// result2.description // output: "Not Found"

// 如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线标记
let (statusCode, _) = http404Error

// 通过下标取值
print("The status code is \(http404Error.0)") // output: "The status code is 404"
print("The status message is \(http404Error.1)") // output: "The status message is Not Found"

// 通过标签取值
print("The status code is \(http200Status.statusCode)") //output: "The status code is 200"
/*:
 ****
 ## 可选值
 */
var serverResponseCode: Int? = 404 // => Int?
serverResponseCode = nil
var surveyAnswer: String? // surveyAnswer 被自动设置为 nil

// 强制解析
var convertedNumber = Int("123")
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// output: "convertedNumber has an integer value of 123."

// 可选值绑定
var possibleNumber = "123"
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
// output: "'123' has an integer value of 123"
/*:
 ****
 ## 一等类型
 */
// 函数与闭包
func addFunc(a: Int, b: Int) -> Int {
    return a + b
}
addFunc(a: 1, b: 2)

let addClosure: (Int, Int) -> Int = { a, b in a + b }
addClosure(1, 2)

// 枚举
enum Gender: Int {
    case male
    case female
}
let man = Gender.male

// 结构体
struct Point {
    let x: Float
    let y: Float
}
let point = Point(x: 1, y: 1)

// 类
class Book {
    let title: String
    let author: String
    let price: Double
    
    init(title: String, author: String, price: Double) {
        self.title = title
        self.author = author
        self.price = price
    }
}
let book = Book(title: "Swift Programming Guide", author: "Apple Inc.", price: 0.00)
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
