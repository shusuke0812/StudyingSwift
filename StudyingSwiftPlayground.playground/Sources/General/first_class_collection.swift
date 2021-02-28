import Foundation

/**
 * ファーストクラスコレクション
 *  - 配列を直接触らずに専用のデータ型を用意する方法（クラスでラップする方法）　※ 下記はクラスではなく値型だが、こういう使い方もある
 *  - メリット：配列と配列に対する処理を一元化できる、配列をイミュータブルにできる　など
 */

/// GitHub Search APIのレスポンス型
public struct GitHubRepo: Codable {
    let id: Int
    let fullName: String
    
    public init(id: Int, fullName: String) {
        self.id = id
        self.fullName = fullName
    }
}
/// GitHubRepoの配列をラップしたファーストクラスコレクション
public struct GitHubRepoList: Codable {
    private(set) var list: [GitHubRepo]
    
    public init(list: [GitHubRepo]) {
        self.list = list
    }
    /// 一番大きいIDのリポジトリを取得する（
    /// （所感：このような配列操作はViewModelに書かずにファーストクラスコレクションにまとめた方が良い？）
    public mutating func getMaxIdRepo() -> Int? {
        return self.list.map({ $0.id }).max()
    }
}
