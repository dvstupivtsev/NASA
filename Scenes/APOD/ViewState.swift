//
//  Created by Stupivtsev Dmitriy on 06/10/2019.
//

import Foundation

struct ViewState {
    var dates = [Day]()
    var isLoading = false
    
    struct Day {
        let name: String
    }
}
