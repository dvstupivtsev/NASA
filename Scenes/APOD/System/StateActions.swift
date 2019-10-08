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
            let lastDays = Array(0..<20).compactMap {
                Calendar(identifier: .gregorian).date(byAdding: .day, value: -$0, to: currentDate)
            }
            
            return service(Request(dates: lastDays))
                .map { strings in
                    return { state in
                        var state = state
                        state.dates = strings
                        return state
                    }
                }
        }
    }
}
