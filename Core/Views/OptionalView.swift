//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import SwiftUI

public struct OptionalView<T, View: SwiftUI.View>: SwiftUI.View {
    private let _value: T?
    private let _produce: (T) -> View
    
    public init(_ value: T?, produce: @escaping (T) -> View) {
        _value = value
        _produce = produce
    }
    
    public var body: some SwiftUI.View {
        Group {
            if _value != nil {
                _produce(_value!)
            }
        }
    }
}
