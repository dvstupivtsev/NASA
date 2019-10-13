//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation

struct APODModel: Codable, Equatable {
    let title: String
    let date: Date
    let imageUrlString: String?
    let highQualityImageUrlString: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case date
        case imageUrlString = "url"
        case highQualityImageUrlString = "hdurl"
    }
}
