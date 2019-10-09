//
//  Created by Stupivtsev Dmitriy on 09.10.2019.
//

import UIKit
import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
    private let _style: UIActivityIndicatorView.Style
    private let _isAnimating: Bool
    
    public init(style: UIActivityIndicatorView.Style, isAnimating: Bool) {
        _style = style
        _isAnimating = isAnimating
    }

    public func makeUIView(
        context: UIViewRepresentableContext<ActivityIndicator>
    ) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: _style)
    }

    public func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>
    ) {
        _isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
