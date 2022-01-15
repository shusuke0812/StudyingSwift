import UIKit

/**
 * 関数型を使った配列の加工
 */

public class CollectionOperator {
    private let _array = [1, 2, 3, 4, 5, 6]
    private let _nilArray = [1, nil, 3, 4, nil, 6]
    private let _names = ["Vivien", "Marlon", "Kim", "Karl"]
    
    /// 組み合わせ
    public func sample() {
        let array = _array
                        .map { $0 * 2 }
                        .filter { $0 < 6 }
        print(array)
    }
    
    /// 配列内の全要素を変えたい
    public func mapSample() {
        let array = _array.map { $0 * 5 }

        let lowercaseNames = _names.map { $0.lowercased() }
        let nameCounts = _names.map { $0.count }
        
        print(array)
        print(lowercaseNames)
        print(nameCounts)
    }
    
    /// 配列内の全要素を使って何かをしたい
    public func forEachSample() {
        _names.forEach { name in
            print(name)
        }
    }
    
    /// 配列内の要素を条件によって絞り込む
    public func filterSample() {
        let array = _array.filter { $0 < 3 }
        print(array)
    }
    
    /// 配列内の要素をまとめる
    public func reduceSample() {
        let arraySum = _array.reduce(0) { (num1, num2) -> Int in
            num1 + num2
        }
        print(arraySum)
    }
    
    /// 配列の要素と要素インデックスを取得する
    public func enumerateSample() {
        _array.enumerated().forEach {
            print("index: \($0.0), value: \($0.1)")
        }
    }
    
    /// 配列の要素からnilでないものをマップする
    public func compactMapSample() {
        let array = _nilArray.compactMap { $0 }
        print(array)
    }
}

