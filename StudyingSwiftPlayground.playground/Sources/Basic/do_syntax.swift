import Foundation

/**
 * do文を使ったスコープ内プロパティの定義
 *  - ある範囲でのみ有効な定数／変数を定義したい時に使う（doブロック内で定義したプロパティはそのブロック内でのみ有効）
 *  - そのため、do文を使ってクラスのインスタンス化を行うと最終的にはdeinitまで呼ばれる
 */

open class Prof {
    let name: String
    
    public init(name: String) {
        self.name = name
        print("init: " + self.name)
    }
    // インスタンスが解放される直前に１度だけ呼ばれる
    deinit {
        print("deinit: " + self.name)
    }
}

// 使用例
/*
let prof = Prof(name: "Tarou")
do {
    let prof = Prof(name: "Hanako") <- このインスタンスはdoスコープ内のみで有効なので実行後に解放される（deinitが呼ばれる）
}
*/
