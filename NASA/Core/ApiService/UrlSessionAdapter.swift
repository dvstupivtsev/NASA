//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

typealias UrlExecutor = (_ url: URL) -> Observable<Data>

enum UrlSessionAdapter {
    static func create(urlSession: URLSession) -> UrlExecutor {
        return { urlSession.rx.data(request: URLRequest(url: $0)) }
    }
}
