//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation
import Core

extension DateFormatter {
    static let YYYYMMddFormatter = setup(DateFormatter()) {
        $0.dateFormat = "YYYY-MM-dd"
    }
}
