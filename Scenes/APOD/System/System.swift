//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift
import RxFeedback

typealias System = Observable<ViewState.Action>

func system(
    input: Observable<Input>,
    scheduler: SchedulerType = MainScheduler.instance,
    dependencies: Dependencies
) -> System {
    return Observable.system(
        initialState: State(),
        reduce: { state, action in action(state) },
        scheduler: scheduler,
        feedback: [
            react(request: { $0 }, effects: { _ -> Observable<State.Action> in
                input.flatMap { inputEvent -> Observable<State.Action> in
                    switch inputEvent {
                    case .loadPage:
                        return State.Actions.loadPage(service: dependencies.apiExecutor)
                    }
                }
            })
        ]
    ).map {
        if $0.isLoading {
            return ViewState.Actions.loading()
        } else {
            return ViewState.Actions.loaded(dates: $0.dates)
        }
    }
}
