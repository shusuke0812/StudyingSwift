import Foundation

/**
 * Observerパターン
 * - 通知元（通知開始`subscribe`・通知終了`unsubscribe`）= `Observable` or `Subject`
 * - 通知先（通知受け取り`notify`）= `Observer`
 */

// MARK: - Observable
public protocol ObservableType {
    associatedtype E
    func subscribe<O: ObserverType>(obs: O) where O.E == E
    func unsubscribe<O: ObserverType>(obs: O) where O.E == E
}
public class Observable<Element>: ObservableType {
    public typealias E = Element
    public func subscribe<O: ObserverType>(obs: O) where O.E == E { fatalError("not implemented") }
    public func unsubscribe<O: ObserverType>(obs: O) where O.E == E { fatalError("not implemented") }
}
public class ConcreateObservable: Observable<Bool> {
    // 通知先を保持する
    private var observers: [ObjectIdentifier: Observer<Bool>] = [:]
    // 状態が更新したら`Observer`へ通知する
    public var isChanged: Bool = false {
        didSet {
            observers.forEach { x in x.value.notify(value: isChanged) }
        }
    }
    /// 通知開始
    public override func subscribe<O>(obs: O) where O : ObserverType, O.E == Bool {
        self.observers[ObjectIdentifier(obs)] = Observer(handler: obs.notify)
    }
    /// 通知終了
    public override func unsubscribe<O>(obs: O) where O : ObserverType, O.E == Bool {
        self.observers[ObjectIdentifier(obs)] = nil
    }
}
// MARK: - Observer
public protocol ObserverType: AnyObject {
    associatedtype E
    func notify(value: E)
}
public class Observer<Element>: ObserverType {
    public typealias E = Element
    public typealias Handler = (E) -> Void
    private let handler: Handler
    
    public init(handler: @escaping Handler) {
        self.handler = handler
    }
    public func notify(value: E) { handler(value) }
}

