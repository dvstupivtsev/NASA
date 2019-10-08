//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

public struct Request: Equatable {
    public let name: String
    public let parameters: [String: String]
}
