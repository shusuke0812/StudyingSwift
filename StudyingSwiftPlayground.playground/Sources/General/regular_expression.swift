import Foundation

// TODO: 作成中

/**
 * 正規表現のあれこれ
 * preg（perform regular expression）：正規表現にマッチしているか
 * 参考：swift+Extensionを使ったパターンマッチメソッド、https://qiita.com/KikurageChan/items/807e84e3fa68bb9c4de6
 * 　　：文字コードを指定しなかったときの誤動作例、https://tinybeans.net/blog/2016/03/14-110954
 */


public extension String {
    /// 正規表現にマッチした文字列の置換を行う（PHP 例： preg_replace( $正規表現パターン , $置換後の文字列 , $置換対象の文字列 ) ）
    /// - Parameters:
    ///   - pattern: 正規表現
    ///   - replaceMent: 置換後の文字列
    func pregReplace(pattern: String, replaceMent: String, options: NSRegularExpression.Options = []) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: replaceMent)
        } catch {
            debugPrint("\(error)")
            return self
        }
    }
}

public enum RegEx {
    public static let replace: String = "/([^ ]+)/"
}
