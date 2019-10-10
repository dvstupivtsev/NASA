//
//  Created by Stupivtsev Dmitriy on 28/09/2019.
//

import SwiftUI
import RxSwift
import Grid
import URLImage
import Core

/// Astronomy Picture of the Day View
public struct View: SwiftUI.View {
    private let _bag = DisposeBag()
    private let _system = system()
    @SwiftUI.State private var _state = setup(ViewState()) { $0.isLoading = true }
    @SwiftUI.State private var _pictureToShow: ViewState.Day = .empty
    @SwiftUI.State private var _shouldShowPicture = false
    
    public var body: some SwiftUI.View {
        VStack {
            if _state.isLoading {
                ActivityIndicator(style: .large, isAnimating: _state.isLoading)
            } else {
                if _state.previousDays.isEmpty {
                    Text("Previous days are not available")
                } else {
                    Grid(0..<_state.previousDays.count) { index in
                        PreviousDayView(self._state.previousDays[index]).onTapGesture {
                            self._pictureToShow = self._state.previousDays[index]
                            self._shouldShowPicture = true
                        }
                    }.gridStyle(
                        AutoColumnsGridStyle(itemHeight: 250)
                    ).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                }
            }
        }
        .sheet(isPresented: $_shouldShowPicture, onDismiss: {
            self._pictureToShow = .empty
            self._shouldShowPicture = false
        }, content: {
            PictureView(self._pictureToShow)
        })
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
