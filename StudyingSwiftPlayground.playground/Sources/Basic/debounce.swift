import Combine
import Foundation

/**
 * debounce で `POST`の過剰呼び出しを抑制する
 *  - POST呼び出しの制限理由：
 *    - 🚧準備中🚧
 */

public enum GitHubError: Error {
    case notFound
}

struct GitHubSearchRepository {
    static func saveFavorite(repositoryName: String, completion: @escaping (Result<Void, GitHubError>) -> Void) {
        if repositoryName.isEmpty {
            completion(.failure(.notFound))
        } else {
            completion(.success(()))
        }
    }
}

public class GitHubSearchWithDebounce {
    
    private let subject: PassthroughSubject<Void, Never>
    private var cancellable: Cancellable?
    
    public init() {
        self.subject = PassthroughSubject<Void, Never>()
        self.cancellable = nil
    }
    
    public func config(repositoryName: String, completion: @escaping (Result<Void, GitHubError>) -> Void) {
        cancellable = subject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { index in
                print ("time=\(DateHelper.now()), call saveFavorite")
                GitHubSearchRepository.saveFavorite(repositoryName: repositoryName) { result in
                    switch result {
                    case .success():
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
    }
    
    public func execute() {
        guard cancellable != nil else { return }
        subject.send()
    }
}

// 使用例
/*
let bounces:[(Int,TimeInterval)] = [
    (0, 0),
    (1, 0.25),  // 0.25s interval since last index
    (2, 1),     // 0.75s interval since last index
    (3, 1.25),  // 0.25s interval since last index
    (4, 1.5),   // 0.25s interval since last index
    (5, 2)      // 0.5s interval since last index
]

let githubDebounce = GitHubSearchWithDebounce()
githubDebounce.config(repositoryName: "test") { result in
    switch result {
    case .success():
        print("DEBUG: success")
    case .failure(_):
        print("DEBUG: error")
    }
}

for bounce in bounces {
    DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
        githubDebounce.execute()
    }
}
*/
