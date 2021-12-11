/**
 * RawRepresentable
 * - String, Int, Float以外でも値を持たせたり、呼び出せたりできるようにするプロトコル
 */

import UIKit

public enum Color {
    case primary
    case sub
}

extension Color: RawRepresentable {
    public typealias RawValue = UIColor
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red:   self = .primary
        case UIColor.blue:  self = .sub
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .primary:  return UIColor.red
        case .sub:      return UIColor.blue
        }
    }
}
