//
//  Created by Stupivtsev Dmitriy on 22/09/2019.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            APODView()
                .tabItem {
                    Text("Image")
                }
        }
    }
}

extension ContentView {
    struct Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
