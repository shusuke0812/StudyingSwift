import Foundation

/**
 * プロパティ ラッパー
 *  - プロパティに関する制御をテンプレート化できる仕組み
 *  - プロパティのデフォルト値・制限（最大値○○以下）などの制御
 *  - SwiftUIの`@State`もこの仕組み
 *  - 参考：https://github.com/myihsan/DefaultDecodableWrapper/blob/main/Sources/DefaultDecodableWrapper/DefaultDecodable.swift
 *  - 参考：https://tech.appbrew.io/entry/2020/12/25/advent_calendar_swift
 */

// MARK: - 通常のプロパティオブジェクト宣言
/// 従業員データ（デフォルト値を設定したい場合はそうでないプロパティも含めて、`init`を記述しないといけない）
public struct EmployeeBase: Decodable {
    var id: Int
    var fullName: String
    var isFullTime: Bool       // `nil`ではなくデフォルト値（false）を設定したい...
    
    public enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case isFullTime
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.isFullTime = (try? container.decode(Bool.self, forKey: .isFullTime)) ?? false // デフォルト値を設定
    }
}
// MARK: - プロパティラッパを使用したオブジェクト宣言

public struct Employee: Decodable {
    var id: Int
    var fullName: String
    @DefaultDecoded var isFullTime: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case isFullTime = "is_full_time"
    }
}
/// デフォルト値を設定するプロトコル（`Int => 0`, `String => ""`, `Array => []`, `Bool => false`)
public protocol EmptyInitializable {
    init()
}
extension Int: EmptyInitializable {}
extension String: EmptyInitializable {}
extension Array: EmptyInitializable {}
extension Bool: EmptyInitializable {}

@propertyWrapper
public struct DefaultDecoded<T: Decodable & EmptyInitializable>: Decodable {
    public var wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer(),
              let value = try? container.decode(T.self) else {
            wrappedValue = T()
            return
        }
        wrappedValue = value
    }
}

extension DefaultDecoded: Equatable where T: Equatable {}
extension DefaultDecoded: Hashable where T: Hashable {}

extension KeyedDecodingContainer {
    public func decode<T>(_ type: DefaultDecoded<T>.Type, forKey key: K) throws -> DefaultDecoded<T> where T: Decodable & EmptyInitializable {
        try DefaultDecoded<T>(from: superDecoder(forKey: key))
    }
}

// 使用例
/*

import Foundation
 
// JSONデータ格納用
public struct Employee: Decodable {
    var id: Int
    var fullName: String
    @DefaultDecoded var isFullTime: Bool
 
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case isFullTime = "is_full_time"
    }
}
// JSONファイル読み込み
func loadJsonFile() {
    guard let path = Bundle.main.path(forResource: "api_response_sample", ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    do {
        let data = try Data(contentsOf: url)
        let employeesTemp = try JSONDecoder().decode([Employee].self, from: data)
        employees = employeesTemp
    } catch {
        print(error)
    }
}

// テスト用JSONファイル（api_response_sample.json）の2つ目の要素には`is_full_time`がないが、デフォルトでfalseがEntityに代入されている
let employees: [Employee] = []
loadJsonFile()
if let isFullTime = employess.last?.isFullTime {
  dump(isFullTime)
}
 
*/
