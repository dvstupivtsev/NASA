//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation

public func setup<Type>(_ object: Type, block: (inout Type) -> Void) -> Type {
    var object = object
    block(&object)
    return object
}
