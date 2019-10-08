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
