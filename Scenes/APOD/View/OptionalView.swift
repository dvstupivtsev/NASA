//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import SwiftUI

struct OptionalView<T, View: SwiftUI.View>: SwiftUI.View {
    let value: T?
    let produce: (T) -> View
    
    init(_ value: T?, produce: @escaping (T) -> View) {
        self.value = value
        self.produce = produce
    }
    
    var body: some SwiftUI.View {
        Group {
            if value != nil {
                produce(value!)
            }
        }
    }
}
