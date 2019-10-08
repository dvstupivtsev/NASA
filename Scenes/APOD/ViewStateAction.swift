//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation
import Prelude
import Core

extension ViewState {
    typealias Action = (ViewState) -> ViewState

    enum Actions {
        static func loading() -> Action {
            return {
                setup($0) { $0.isLoading = true }
            }
        }
        
        static func loaded(dates: [APOD]) -> Action {
            return {
                setup($0) {
                    $0.isLoading = false
                    $0.dates = dates.compactMap(^\.title).map(Day.init(name:))
                }
            }
        }
    }
}
