//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation

func decoder() -> (Data) throws -> APOD {
    return {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.YYYYMMddFormatter)
        return try decoder.decode(APOD.self, from: $0)
    }
}
