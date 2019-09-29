//
//  Created by Stupivtsev Dmitriy on 28/09/2019.
//

import SwiftUI
import RxSwift

/// Astronomy Picture of the Day View
public struct View: SwiftUI.View {
    private let _bag = DisposeBag()
    private let _input = PublishSubject<Input>()
    
    public var body: some SwiftUI.View {
        List {
            Text("Test")
        }
    }
    
    public init() {
        let viewSystem = system(
            input: _input,
            dependencies: Dependencies(apiExecutor: Service.create())
        )
            
        viewSystem
            .subscribe()
            .disposed(by: _bag)
    }
}
