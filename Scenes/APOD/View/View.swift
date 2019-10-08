//
//  Created by Stupivtsev Dmitriy on 28/09/2019.
//

import SwiftUI
import RxSwift

/// Astronomy Picture of the Day View
public struct View: SwiftUI.View {
    private let _bag = DisposeBag()
    private let _system = system()
    @SwiftUI.State private var _state = ViewState()
    
    public var body: some SwiftUI.View {
        List {
            Section(footer: EmptyView().foregroundColor(.white)) {
                ForEach(_state.dates, id: \.date) {
                    Cell($0)
                }
            }
        }
        .onAppear(perform: _startSystem)
    }
    
    private func _startSystem() {
        _system(.loadPage)
            .subscribe(onNext: _updateState(action:))
            .disposed(by: _bag)
    }
    
    private func _updateState(action: ViewState.Action) {
        _state = action(_state)
    }
    
    public init() {}
}
