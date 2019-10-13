//
//  Created by Stupivtsev Dmitriy on 13.10.2019.
//

import XCTest
@testable import APOD

class ViewStateActionsLoadedTests: XCTestCase {
    func test_isLoading() {
        let subject = ViewState.Actions.loaded(dates: [], dateFormatter: { _ in "" })
        let initialState = ViewState(
            currentDay: nil,
            previousDays: [],
            isLoading: true
        )
        
        XCTAssertFalse(subject(initialState).isLoading)
    }
    
    func test_with_empty_dates() {
        let subject = ViewState.Actions.loaded(dates: [], dateFormatter: { _ in "" })
        let initialState = ViewState(
            currentDay: .init(title: "", date: "", imageUrl: ""),
            previousDays: [.init(title: "1", date: "", imageUrl: "")],
            isLoading: true
        )
        
        let expected = ViewState(
            currentDay: nil,
            previousDays: [],
            isLoading: false
        )
        
        XCTAssertEqual(subject(initialState), expected)
    }
    
    func test_with_one_date() {
        let dateFormatterReturnValue = "TestFormattedDate"
        let dates = [
            APODModel(
                title: "title",
                date: Date(timeIntervalSince1970: 1570975125),
                imageUrlString: "imageUrlString",
                highQualityImageUrlString: "highQualityImageUrlString"
            )
        ]
        let subject = ViewState.Actions.loaded(
            dates: dates,
            dateFormatter: { _ in dateFormatterReturnValue }
        )
        
        let initialState = ViewState(
            currentDay: .init(title: "", date: "", imageUrl: ""),
            previousDays: [.init(title: "1", date: "", imageUrl: "")],
            isLoading: true
        )
        
        let expected = ViewState(
            currentDay: .init(
                title: dates[0].title,
                date: dateFormatterReturnValue,
                imageUrl: dates[0].highQualityImageUrlString
            ),
            previousDays: [],
            isLoading: false
        )
        
        XCTAssertEqual(subject(initialState), expected)
    }
    
    func test_with_multiple_dates() {
        let dateFormatterReturnValue = "TestFormattedDate"
        let dates = [
            APODModel(
                title: "title1",
                date: Date(timeIntervalSince1970: 1570975125),
                imageUrlString: "imageUrlString",
                highQualityImageUrlString: "highQualityImageUrlString"
            ),
            APODModel(
                title: "title2",
                date: Date(timeIntervalSince1970: 1570985125),
                imageUrlString: "imageUrlString",
                highQualityImageUrlString: nil
            ),
            APODModel(
                title: "title3",
                date: Date(timeIntervalSince1970: 1570995125),
                imageUrlString: nil,
                highQualityImageUrlString: nil
            )
        ]
        let subject = ViewState.Actions.loaded(
            dates: dates,
            dateFormatter: { _ in dateFormatterReturnValue }
        )
        
        let initialState = ViewState(
            currentDay: .init(title: "", date: "", imageUrl: ""),
            previousDays: [.init(title: "1", date: "", imageUrl: "")],
            isLoading: true
        )
        
        let expected = ViewState(
            currentDay: .init(
                title: dates[0].title,
                date: dateFormatterReturnValue,
                imageUrl: dates[0].highQualityImageUrlString
            ),
            previousDays: [
                .init(
                    title: dates[1].title,
                    date: dateFormatterReturnValue,
                    imageUrl: dates[1].imageUrlString
                ),
                .init(
                    title: dates[2].title,
                    date: dateFormatterReturnValue,
                    imageUrl: nil
                )
            ],
            isLoading: false
        )
        
        XCTAssertEqual(subject(initialState), expected)
    }
}
