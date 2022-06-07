import Foundation

struct Countdown: Sequence, IteratorProtocol {
    var count: Int
    mutating func next() -> Int? {
        defer { count -= 1 }
        return count == 0 ? nil : count
    }
}
