//
//  Created by Stupivtsev Dmitriy on 10.10.2019.
//

import SwiftUI
import URLImage
import Core

struct PictureView: SwiftUI.View {
    private let _day: ViewState.Day
    @Environment(\.presentationMode) private var _presentationMode: Binding<PresentationMode>
    
    var body: some SwiftUI.View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button("Close") {
                        self._presentationMode.wrappedValue.dismiss()
                    }.padding(.trailing, 12).padding(.top, 12)
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(_day.title).lineLimit(5)
                }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                OptionalView(_day.imageUrl.flatMap(URL.init(string:))) {
                    URLImage($0) {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    }
                }
            }
        }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
    
    init(_ day: ViewState.Day) {
        _day = day
    }
}
