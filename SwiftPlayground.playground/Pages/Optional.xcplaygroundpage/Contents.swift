/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Optional
 */
var array = ["one", "two", "three"]
switch array.index(of: "four") {
case .some(let idx):
    array.remove(at: idx)
case .none:
    break
}
// or:
if case .some(let idx) = array.index(of: "four") {
    array.remove(at: idx)
}
// or:
switch array.index(of: "four") {
case let idx?:
    array.remove(at: idx)
case nil:
    break
}
// or:
if let idx = array.index(of: "four") {
    array.remove(at: idx)
}
/*:
 ****
 ## 隐式解析
 */
let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString
/*:
 ****
 ## 可选链
 */
struct Person {
    let residence: Residence?
}
struct Residence {
    var numberOfRooms = 1
}

let john = Person(residence: Residence())
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
/*:
 ****
 ## FP
 */
let strNumbers = ["1", "2", "3", "foo"]
let v1 = strNumbers.first.map { Int($0) } // Int??
let v2 = strNumbers.first.flatMap { Int($0) } // Int?

extension Optional {
    
    func _map<U>(transform: (Wrapped) -> U) -> U? {
        if let value = self {
            return transform(value)
        }
        return nil
    }
    
    func _flatMap<U>(transform: (Wrapped) -> U?) -> U? {
        if let value = self, let transformed = transform(value) {
            return transformed
        }
        return nil
    }
}
let v3 = strNumbers.first._map { Int($0) } // Int??
let v4 = strNumbers.first._flatMap { Int($0) } // Int?
/*:
 ****
 ## Dictionary
 */
var dictWithNils: [String: Int?] = [
    "one": 1,
    "two": 2,
    "none": nil
]

// read
dictWithNils["zero"]
dictWithNils["one"]
dictWithNils["none"]

// add 'non-nil'
dictWithNils["zero"] = 0
dictWithNils

// remove
dictWithNils["two"] = nil // If you assign nil as the value for the given key, the dictionary removes that key and its associated value.
dictWithNils

// add 'nil'
dictWithNils["two"] = Optional(nil)
dictWithNils
dictWithNils["three"] = .some(nil)
dictWithNils

// update
dictWithNils["one"]? = nil // 如果字典中存在'one'键，将其对应的值替换为nil
dictWithNils
dictWithNils["four"]? = nil // 如果字典中不存在'one'键，则不进行任何操作
dictWithNils
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
