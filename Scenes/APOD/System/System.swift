//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift
import RxFeedback
import Core

typealias Output = ViewState.Action
typealias System = (Input) -> Observable<Output>

func system(
    requestExecutor: @escaping Service = service(),
    scheduler: SchedulerType = MainScheduler.instance
) -> System {
    let input = PublishSubject<Input>()
    let system = _system(
        input: input.asObservable(),
        requestExecutor: requestExecutor,
        scheduler: scheduler
    )
    
    return { request in
        Observable.create { observer in
            let disposable = system.subscribe(observer)
            input.onNext(request)

            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}

private func _system(
    input: Observable<Input>,
    requestExecutor: @escaping Service,
    scheduler: SchedulerType
) -> Observable<ViewState.Action> {
    return Observable.system(
        initialState: State(),
        reduce: { state, action in action(state) },
        scheduler: scheduler,
        feedback: [
            react(request: { $0.isLoading }, effects: {
                $0 ? State.Actions.loadPage(service: requestExecutor) : .empty()
            }),
            react(request: { $0 }, effects: { _ -> Observable<State.Action> in
                input.flatMap { inputEvent -> Observable<State.Action> in
                    switch inputEvent {
                    case .loadPage:
                        return .just { setup($0) { $0.isLoading = true } }
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
