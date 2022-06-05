/**
 * Doc
 * - WWDC：https://developer.apple.com/videos/play/wwdc2015/226/
 * - 参考１：https://www.macneko.com/entry/cancel-operation-in-operationqueue
 * - 参考２：https://tiny-wing.hatenablog.com/category/swift?page=1449738361
 */

import Foundation

open class MyOperation: Operation {
    let number: Int
    
    public init(number: Int) {
        self.number = number
    }
    
    open override func main() {
        if isCancelled {
            return
        }
        sleep(2)
        print("number = \(number), \(Date().timeIntervalSince1970)")
    }
}

// MARK: - Source
/*
 
import Foundation

let operation1 = MyOperation(number: 1)
let operation2 = MyOperation(number: 2)
let operation3 = MyOperation(number: 3)

let queue = OperationQueue()

queue.maxConcurrentOperationCount = 1

queue.addOperation(operation1)
queue.addOperation(operation2)

if operation1.isExecuting {
    operation2.cancel()
}
queue.addOperation(operation3)
*/
