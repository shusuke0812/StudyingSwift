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
 
// タスクが終了・キャンセルしたときに呼ばれる
operation1.completionBlock = {
    print("operation1 runs completion")
}

let queue = OperationQueue()
let mainQueue = OperationQueue.main // MainThreadで同期実行

queue.maxConcurrentOperationCount = 1　// スレッド実行数, `1`の場合は同期処理

queue.addOperation(operation1)
queue.addOperation(operation2)
// 補足：operation1.addOperation(operation3)とすると`operation3`の終了を待ってから`operation1`が実行される。1が3に依存している。

if operation1.isExecuting {
    operation2.cancel()
}
queue.addOperation(operation3)
*/
