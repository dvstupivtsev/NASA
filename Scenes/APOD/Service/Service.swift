//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift
import Core

typealias Service = (Request) -> Observable<[APOD]>

func service(
    requestExecutor: @escaping Core.RequestExecutor = Core.requestExecutor(),
    dateFormatter: @escaping (Date) -> String = DateFormatter.YYYYMMddFormatter.string(from:),
    decoder: @escaping (Data) throws -> APOD = decoder()
) -> Service {
    return {
        let requests = $0.dates
            .map { Core.Request(name: "planetary/apod", parameters: ["date": dateFormatter($0), "hd": true] ) }
            .map(requestExecutor)
        
        return Observable.from(requests)
            .merge()
            .map(decoder)
            .catchError { _ in .empty() }
            .toArray()
            .map { $0.sorted { $0.date > $1.date } }
            .asObservable()
    }
}
