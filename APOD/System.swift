//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift
import RxFeedback

typealias System = Observable<Output>

func system(
    input: Observable<Input>,
    scheduler: SchedulerType = MainScheduler.instance,
    dependencies: Dependencies
) -> System {
    return Observable.system(
        initialState: State(),
        reduce: Reducer.create(),
        scheduler: scheduler,
        feedback: [
            react(request: { $0 }, effects: { _ -> Observable<Event> in
                input.map { inputEvent -> Event in
                    switch inputEvent {
                    case let .load(dates):
                        return .load(dates: dates)
                    }
                }
            })
        ]
    ).map {
        if $0.isLoading {
            return .showLoading
        } else {
            return .present(source: $0.dates)
        }
    }
}
