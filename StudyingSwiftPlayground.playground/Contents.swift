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
