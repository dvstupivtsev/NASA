//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift
import RxCocoa

public typealias UrlExecutor = (_ url: URL) -> Observable<Data>

public func urlExecutor(urlSession: URLSession = .shared) -> UrlExecutor {
    return { urlSession.rx.data(request: URLRequest(url: $0)) }
}
