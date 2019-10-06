//
//  Created by Stupivtsev Dmitriy on 06/10/2019.
//

import Foundation

func setup<Type>(_ object: Type, block: (inout Type) -> Void) -> Type {
    var object = object
    block(&object)
    return object
}

struct ViewState {
    var dates = [Day]()
    var isLoading = false
    
    struct Day {
        let name: String
    }
}

extension ViewState {
    typealias Action = (ViewState) -> ViewState

    enum Actions {
        static func loading() -> Action {
            return {
                setup($0) { $0.isLoading = true }
            }
        }
        
        static func loaded(dates: [String]) -> Action {
            return {
                setup($0) {
                    $0.isLoading = false
                    $0.dates = dates.map(Day.init(name:))
                }
            }
        }
    }
}
