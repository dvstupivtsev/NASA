//
//  Created by Stupivtsev Dmitriy on 13.10.2019.
//

import XCTest
@testable import APOD

class DecoderTests: XCTestCase {
    func test_with_invalid_data() {
        let subject = decoder()
        let result = try? subject(Data())
        
        XCTAssertNil(result)
    }
    
    func test_with_valid_data() {
        let model = APODModel(
            title: "title",
            date: Date(timeIntervalSince1970: 1570975125),
            imageUrlString: "imageUrlString",
            highQualityImageUrlString: "highQualityImageUrlString"
        )
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.YYYYMMddFormatter)
        let data = try! encoder.encode(model)
        
        let subject = decoder()
        let result = try? subject(data)
        let expected = APODModel(
            title: "title",
            date: Date(timeIntervalSince1970: 1570914000),
            imageUrlString: "imageUrlString",
            highQualityImageUrlString: "highQualityImageUrlString"
        )
        
        XCTAssertEqual(result, expected)
    }
}
