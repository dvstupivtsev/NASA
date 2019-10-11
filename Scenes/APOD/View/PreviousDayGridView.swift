//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import SwiftUI
import RxSwift
import URLImage
import Core

struct PreviousDayGridView: SwiftUI.View {
    private var _state: ViewState.Day = .empty
    
    public var body: some SwiftUI.View {
        VStack(alignment: .leading, spacing: 8) {
            OptionalView(_state.imageUrl.flatMap(URL.init(string:))) {
                // TODO: replace with another implementation, this one is laggy
                URLImage($0) {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            }.or(AnyView(Text("There is no image")))
            VStack(alignment: .leading, spacing: 4) {
                Text(_state.title).lineLimit(5).font(.caption)
                Text(_state.date).font(.caption)
            }
        }.frame(width: 155)
    }
    
    init(_ state: ViewState.Day) {
        _state = state
    }
}

#if DEBUG
struct PreviousDayGridView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        PreviousDayGridView(
            ViewState.Day(
                title: "TestMultiliiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiineTitle",
                date: "2019.10.09",
                imageUrl: "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwihvbblvY_lAhVrw8QBHUMbC64QjRx6BAgBEAQ&url=https%3A%2F%2Fwww.portoflosangeles.org%2Frecreation%2Fcatalina_island.asp&psig=AOvVaw3qTCaBD0dTnCRsIOXtB1tS&ust=1570720984297496"
            )
        )
    }
}
#endif
