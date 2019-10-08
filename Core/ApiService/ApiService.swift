//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

public typealias RequestExecutor = (_ request: Request) -> Observable<Data>

public enum ApiService {
    private static let _apiKey = "8rtvIryjdio1SlssQ3HtUrCPJdeVeCYel6Jg7LPW"
    private static let _baseURLString = "https://api.nasa.gov/"
    
    public static func create(urlExecutor: @escaping UrlExecutor) -> RequestExecutor {
        return {
            let joinedParams = $0.parameters
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
            
            let urlString = "\(_baseURLString)\($0.name)?\(joinedParams)&appid=\(_apiKey)"
            
            return URL(string: urlString)
                .map(urlExecutor) ?? .error(NSError())
        }
    }
}
