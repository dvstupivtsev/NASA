//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

typealias RequestExecutor = (Request) -> Observable<[String]>

struct Request {
    let dates: [Date]
}

func service() -> RequestExecutor {
    return { _ in
        .just(["123", "456"])
    }
}
