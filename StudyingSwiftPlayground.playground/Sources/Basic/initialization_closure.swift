/**
 *  Initialization Closure（クロージャーを使ったプロパティのデフォルト値設定）
 *   - プロパティが属する型が初期化される時にクロージャーが呼び出されてその戻り値がプロパティのデフォルト値になる
 *   - UIをコードで書く際にも使われる
 *   - ドキュメント：https://docs.swift.org/swift-book/LanguageGuide/Initialization.html
 */

import Foundation
import UIKit

/// 白と黒が縦と横に交互に続く８×８のチェスボードの色`boardColor`プロパティ（黒：`false`、白：`true`）
public struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack.toggle()
            }
            isBlack.toggle()
        }
        return temporaryBoard
    }()
    
    public init(){}
    
    public func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
/// UILabelの初期化例
class ViewController: UIViewController {
    private let label: UILabel = {
        let labelTemp = UILabel()
        labelTemp.text = "test label"
        return labelTemp
    }()
}
