//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation

enum Reducer {
    static func create() -> (State, Event) -> State {
        return { state, _ in state }
    }
}
