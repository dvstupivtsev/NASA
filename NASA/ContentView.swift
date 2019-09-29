//
//  Created by Stupivtsev Dmitriy on 22/09/2019.
//

import SwiftUI
import APOD

struct ContentView: SwiftUI.View {
    var body: some SwiftUI.View {
        TabView {
            APOD.View()
                .tabItem {
                    Text("Image")
                }
        }
    }
}

extension ContentView {
    struct Previews: PreviewProvider {
        static var previews: some SwiftUI.View {
            ContentView()
        }
    }
}
