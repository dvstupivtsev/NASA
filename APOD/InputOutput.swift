//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation

enum Input {
    case load(dates: [Date])
}

enum Output {
    case showLoading
    case present(source: [String])
}
