//
//  Created by Stupivtsev Dmitriy on 08.10.2019.
//

import Foundation

func decoder() -> (Data) throws -> APODModel {
    return {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.YYYYMMddFormatter)
        return try decoder.decode(APODModel.self, from: $0)
    }
}
