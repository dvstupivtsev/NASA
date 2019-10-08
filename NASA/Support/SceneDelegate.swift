//
//  Created by Stupivtsev Dmitriy on 22/09/2019.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let windowScene = scene as? UIWindowScene
        window = windowScene.map(windowRouter(scene:))
    }
}

