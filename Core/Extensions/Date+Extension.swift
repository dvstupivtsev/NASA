//
//  Created by Stupivtsev Dmitriy on 09.10.2019.
//

import Foundation

extension Date {
    public enum Component {
        case year(Int)
        case month(Int)
        case day(Int)
        case hour(Int)
        case minute(Int)
        case second(Int)
    }
    
    public static func + (lhs: Date, rhs: Component) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        switch rhs {
        case let .year(value):
            return calendar.date(byAdding: .year, value: value, to: lhs) ?? lhs
        case let .month(value):
            return calendar.date(byAdding: .month, value: value, to: lhs) ?? lhs
        case let .day(value):
            return calendar.date(byAdding: .day, value: value, to: lhs) ?? lhs
        case let .hour(value):
            return calendar.date(byAdding: .hour, value: value, to: lhs) ?? lhs
        case let .minute(value):
            return calendar.date(byAdding: .minute, value: value, to: lhs) ?? lhs
        case let .second(value):
            return calendar.date(byAdding: .second, value: value, to: lhs) ?? lhs
        }
    }
}
