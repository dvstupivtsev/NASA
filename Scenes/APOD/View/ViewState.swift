//
//  Created by Stupivtsev Dmitriy on 06/10/2019.
//

import Foundation

struct ViewState {
    var dates = [Day]()
    var isLoading = false
    
    struct Day {
        let title: String
        let date: String
        let imageUrl: String?
        
        static var empty: Day {
            return Day(title: "", date: "", imageUrl: nil)
        }
    }
}
