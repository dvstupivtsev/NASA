//
//  Created by Stupivtsev Dmitriy on 29/09/2019.
//

import Foundation
import RxSwift

public struct Request: Equatable {
    let name: String
    let parameters: [String: Any]
    
    public init(name: String, parameters: [String : Any]) {
        self.name = name
        self.parameters = parameters
    }
    
    public static func == (lhs: Request, rhs: Request) -> Bool {
        lhs.name == rhs.name
    }
}
