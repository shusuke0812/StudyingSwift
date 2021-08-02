import UIKit

/// GitHubで使われている言語別アイコンカラー一覧
enum LanguageIconColor {
    case swift
    case cpp
    case objectiveC
    case kotlin
    case shell
    case other
    
    init(language: String) {
        switch language {
        case "Swift":       self = .swift
        case "C++":         self = .cpp
        case "Objective-C": self = .objectiveC
        case "Kotlin":      self = .kotlin
        case "Shell":       self = .shell
        default:            self = .other
        }
    }
    /**
     * カラーリテラル
     * - 使い方：`color literal` と入力すればXcodeが自動で補完してくれるので後はHex、RGBなどで色を指定するだけ。
     * - メモ：Storyboardやアプリを実行しなくても色が見えるので分かりやすい。ただし、Hexで検索しても出てこないというデメリットもある。
     */
    var color: UIColor {
        switch self {
        case .swift:        return #colorLiteral(red: 1, green: 0.6745098039, blue: 0.2705882353, alpha: 1)
        case .cpp:          return #colorLiteral(red: 0.9529411765, green: 0.2941176471, blue: 0.4901960784, alpha: 1)
        case .objectiveC:   return #colorLiteral(red: 0.262745098, green: 0.5568627451, blue: 1, alpha: 1)
        case .kotlin:       return #colorLiteral(red: 0.9450980392, green: 0.5568627451, blue: 0.2, alpha: 1)
        case .shell:        return #colorLiteral(red: 0.537254902, green: 0.8784313725, blue: 0.3176470588, alpha: 1)
        case .other:        return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

let colors = [LanguageIconColor.swift.color, LanguageIconColor.kotlin.color]
let cgColors = colors.map { $0.cgColor }
