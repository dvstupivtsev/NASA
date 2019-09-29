//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

struct Request: Equatable {
    let name: String
    let parameters: [String: String]
}
