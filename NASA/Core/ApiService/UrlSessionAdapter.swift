//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

typealias UrlExecutor = (_ url: URL) -> Observable<Data?>

enum UrlSessionAdapter {
    static func create(urlSession: URLSession) -> UrlExecutor {
        return { url in
            Single<Data?>.create { event in
                urlSession.dataTask(with: url) { data, response, error in
                    if let error = error {
                        event(.error(error))
                    } else {
                        event(.success(data))
                    }
                }.resume()
                
                return Disposables.create()
            }.asObservable()
        }
    }
}
