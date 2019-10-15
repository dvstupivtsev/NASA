//
//  Created by Stupivtsev Dmitriy on 13.10.2019.
//

import XCTest
import RxSwift
import RxTest
import Core
@testable import APOD

class StateActionLoadPageTests: XCTestCase {
    func test_action() {
        let currentDate = Date(timeIntervalSince1970: 1570975125)
        let expectedDates = [
            currentDate,
            currentDate + .day(-1),
            currentDate + .day(-2),
            currentDate + .day(-3),
            currentDate + .day(-4),
            currentDate + .day(-5),
            currentDate + .day(-6),
            currentDate + .day(-7),
            currentDate + .day(-8),
            currentDate + .day(-9),
            currentDate + .day(-10),
            currentDate + .day(-11),
            currentDate + .day(-12),
            currentDate + .day(-13),
            currentDate + .day(-14),
            currentDate + .day(-15),
            currentDate + .day(-16),
            currentDate + .day(-17),
            currentDate + .day(-18),
            currentDate + .day(-19)
        ]
        
        var serviceReceivedRequest: APOD.Request!
        var serviceCallsCount = 0
        let serviceReturnValue = [
            APODModel(
                title: "title",
                date: Date(timeIntervalSince1970: 1570911111),
                imageUrlString: "imageUrlString",
                highQualityImageUrlString: "highQualityImageUrlString"
            )
        ]
        
        let service: Service = {
            serviceReceivedRequest = $0
            serviceCallsCount += 1
            return .just(serviceReturnValue)
        }
        
        let subject = State.Actions.loadPage(service: service, currentDate: currentDate)
        
        let initialState = State(
            dates: [
                APODModel(
                    title: "",
                    date: Date(timeIntervalSince1970: 1570900000),
                    imageUrlString: "",
                    highQualityImageUrlString: ""
                )
            ],
            isLoading: true
        )
        
        let expected = State(
            dates: serviceReturnValue,
            isLoading: false
        )
        
        let scheduler = TestScheduler(initialClock: 0)
        
        let result = scheduler.start {
            subject.map { $0(initialState) }
        }
        
        XCTAssertEqual(serviceReceivedRequest, APOD.Request(dates: expectedDates))
        XCTAssertEqual(result.events, [.next(200, expected), .completed(200)])
    }
}
