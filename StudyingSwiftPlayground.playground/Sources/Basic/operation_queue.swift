import Foundation

open class MyOperation: Operation {
    let number: Int
    
    public init(number: Int) {
        self.number = number
    }
    
    open override func main() {
        Thread.sleep(forTimeInterval: 1)
        print(number)
    }
}
