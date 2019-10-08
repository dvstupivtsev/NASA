//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift
import Core

typealias Service = (Request) -> Observable<[String]>

private let urlString = "planetary/apod"

func service(
    requestExecutor: @escaping Core.RequestExecutor = Core.requestExecutor(),
    dateFormatter: @escaping (Date) -> String = DateFormatter.YYYYMMDDFormatter.string(from:)
) -> Service {
    return {
        let requests = $0.dates
            .map { Core.Request(name: urlString, parameters: ["date": dateFormatter($0), "hd": false] ) }
            .map(requestExecutor)
        
        return Observable.from(requests)
            .merge()
            .map { _ in "success" }
            .catchErrorJustReturn("failure")
            .toArray()
            .asObservable()
    }
}

private extension DateFormatter {
    static let YYYYMMDDFormatter = setup(DateFormatter()) {
        $0.dateFormat = "YYYY-MM-dd"
    }
}
