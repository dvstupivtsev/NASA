//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation
import Core

extension ViewState {
    typealias Action = (ViewState) -> ViewState

    enum Actions {
        static func loading() -> Action {
            return {
                setup($0) { $0.isLoading = true }
            }
        }
        
        static func loaded(dates: [String]) -> Action {
            return {
                setup($0) {
                    $0.isLoading = false
                    $0.dates = dates.map(Day.init(name:))
                }
            }
        }
    }
}
