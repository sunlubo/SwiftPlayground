/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # String
 */
/*:
 ****
 ##
 */
import Foundation

var str = "Hello, playground"
let emoji = "🍎 🍌 🍊 🍉"
let char: Character = "!"

// the characters property contains a collection of the Unicode characters in the string
str.characters.count
// the utf8 property contains a collection of the UTF-8 code points
str.utf8.count
str.utf16.count

emoji.characters.count
emoji.utf8.count
emoji.utf16.count

for /*let*/character in str.characters {
    print(character, terminator: "")
}

let result = (str.characters.dropFirst(5) as AnySequence) // workaround
    .filter({ $0 != "," })
    .map({ "\($0)".uppercased() })
    .joined(separator: "-")
result

// string concat
str + "!"
str.append(char)
str.append("!!!")
str.append(contentsOf: ["!", "!", "!"])

let range = str.startIndex...str.index(str.startIndex, offsetBy: 4)
str[range]
str[range.lowerBound]
str[range.upperBound]

str.replaceSubrange(range, with: str[range].uppercased())
str.removeSubrange(str.index(str.endIndex, offsetBy: -6)..<str.endIndex)

str.lowercased()
str.uppercased()

str.hasPrefix("h")
str.hasSuffix("!")

// 文本输出流
struct ArrayStream: TextOutputStream {
    var buffer: [String] = []
    mutating func write(_ string: String) {
        buffer.append(string)
    }
}
var stream = ArrayStream()
print("Hello", to: &stream)
print("World", to: &stream)
stream.buffer

extension Data: TextOutputStream {
    public mutating func write(_ string: String) {
        string.utf8CString.dropLast().withUnsafeBufferPointer {
            append($0)
        }
    }
}
var data = Data(bytes: [65, 66, 67])
data.write("D")
data.write("E")
String(data: data, encoding: .utf8)
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
