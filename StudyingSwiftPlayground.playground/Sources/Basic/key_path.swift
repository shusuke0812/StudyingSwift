
import Foundation

public struct User {
    public var name: String
    public var age: Int
    public var company: String
    
    public init(name: String, age: Int, company: String) {
        self.name = name
        self.age = age
        self.company = company
    }
}

/*
let user = User(name: "taro", age: 20, company: "sany")
let keyPath: KeyPath<User, String> = \.name

print(user[keyPath: keyPath])
*/
