//
//  Created by Stupivtsev Dmitriy on 06/10/2019.
//

import Foundation
import RxSwift

extension State {
    typealias Action = (State) -> State

    enum Actions {
        static func loadPage(service: @escaping Service) -> Observable<Action> {
            let currentDate = Date()
            let maxDaysNumber = 20
            let lastDays = Array(0..<maxDaysNumber).compactMap {
                Calendar(identifier: .gregorian).date(byAdding: .day, value: -$0, to: currentDate)
            }
            
            return service(Request(dates: lastDays))
                .map { dates in
                    return { state in
                        var state = state
                        state.dates = dates
                        return state
                    }
                }
        }
    }
}
