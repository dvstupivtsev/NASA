//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import SwiftUI
import URLImage

struct Cell: SwiftUI.View {
    private var _state: ViewState.Day = .empty
    
    public var body: some SwiftUI.View {
        HStack {
            OptionalView(_state.imageUrl.flatMap(URL.init(string:))) {
                // TODO: replace with another implementation, this one is laggy
                URLImage($0) {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                .frame(width: 100, height: 100)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(_state.title)
                Text(_state.date)
            }
        }
    }
    
    init(_ state: ViewState.Day) {
        _state = state
    }
}
