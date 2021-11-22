/**
 *  参照渡し
 *   - inout
 */


import Foundation

public func valuedChanged(_ value: inout Int) {
    value = 100
}

// 使用例
/*
var arg = 10
valuedChanged(&arg)
print(arg)
*/
