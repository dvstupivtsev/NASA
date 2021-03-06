//
//  Created by Stupivtsev Dmitriy on 22/09/2019.
//

import UIKit
import SwiftUI

func windowRouter(scene: UIWindowScene) -> UIWindow {
    let window = UIWindow(windowScene: scene)
    window.rootViewController = UIHostingController(rootView: ContentView())
    window.makeKeyAndVisible()
    return window
}
