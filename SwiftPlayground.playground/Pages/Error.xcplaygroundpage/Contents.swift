/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Error
 */
enum FileError: Error {
    case fileDoesNotExist
    case noPermission
}

func contents(ofFile filename: String) throws -> String {
    throw FileError.fileDoesNotExist
}

do {
    let result: String = try contents(ofFile: "file")
    print(result)
} catch FileError.fileDoesNotExist {
    print("file not found")
} catch where error is FileError { // implicit 'error'
    print(error)
} catch {
    print(error)
}

// optional
let result: String? = try? contents(ofFile: "file")


// SR-3704
func executeClosure(closure: () throws -> Void) rethrows {
    try closure()
}

executeClosure(closure: {})
try? executeClosure(closure: { throw FileError.fileDoesNotExist })
/*:
 ----
 ## Result
 */
func contentsOrNil(ofFile filename: String) -> String? {
    return nil
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

func contents(ofFile filename: String) -> Result<String> {
    return .failure(FileError.fileDoesNotExist)
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
