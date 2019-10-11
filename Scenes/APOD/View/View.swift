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
    @SwiftUI.State private var _collectionStyle: CollectionStyle = .collection
    
    public var body: some SwiftUI.View {
        VStack {
            if _state.isLoading {
                ActivityIndicator(style: .large, isAnimating: _state.isLoading)
            } else {
                VStack {
                    self._currentDayImage()
                    
                    if _state.previousDays.isEmpty {
                        Text("Previous days are not available")
                    } else {
                        self._collection(style: self._collectionStyle)
                    }
                }
                .padding(.top, 30)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
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
    
    private func _currentDayImage() -> some SwiftUI.View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Picture of the day")
                .font(.title)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            OptionalView(_state.currentDay?.imageUrl.flatMap(URL.init(string:))) {
                URLImage($0) {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }.onTapGesture {
                    guard let day = self._state.currentDay else { return }
                    self._pictureToShow = day
                    self._shouldShowPicture = true
                }
            }.or(
                AnyView(
                    Text("There is no image for current day")
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                )
            )
        }
    }
    
    private func _collection(style: CollectionStyle) -> some SwiftUI.View {
        let view: AnyView
        switch style {
        case .collection:
            view = AnyView(
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(self._state.previousDays, id: \.date) { day in
                            PreviousDayGridView(day).onTapGesture {
                                self._pictureToShow = day
                                self._shouldShowPicture = true
                            }
                        }
                    }
                }
            )
        case .list:
            view = AnyView(
                List {
                    ForEach(self._state.previousDays, id: \.date) { day in
                        PreviousDayListView(day).onTapGesture {
                            self._pictureToShow = day
                            self._shouldShowPicture = true
                        }
                    }
                }
            )
        }
        
        return VStack(alignment: .leading, spacing: 8) {
            Text("Previous days")
                .font(.headline)
                .fontWeight(.bold)
            if false {
                Picker(selection: $_collectionStyle, label: Text("")) {
                    Text(CollectionStyle.collection.rawValue).tag(CollectionStyle.collection)
                    Text(CollectionStyle.list.rawValue).tag(CollectionStyle.list)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            view
        }.padding(EdgeInsets(top: 20, leading: 12, bottom: 0, trailing: 12))
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

private extension View {
    enum CollectionStyle: String {
        case collection = "Collection", list = "List"
    }
}
