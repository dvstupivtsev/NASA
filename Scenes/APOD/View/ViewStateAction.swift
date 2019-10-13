//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation
import Prelude
import Core

extension ViewState {
    typealias Action = (ViewState) -> ViewState

    enum Actions {
        static func loading() -> Action {
            return {
                setup($0) { $0.isLoading = true }
            }
        }
        
        static func loaded(
            dates: [APODModel],
            dateFormatter: @escaping (Date) -> String = DateFormatter.YYYYMMddFormatter.string(from:)
        ) -> Action {
            return {
                setup($0) {
                    $0.isLoading = false
                    let days = dates.map {
                        ViewState.Day(
                            title: $0.title,
                            date: dateFormatter($0.date),
                            imageUrl: $0.highQualityImageUrlString ?? $0.imageUrlString
                        )
                    }
                    $0.currentDay = days.first
                    $0.previousDays = Array(days.dropFirst())
                }
            }
        }
    }
}
