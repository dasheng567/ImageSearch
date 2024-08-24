//
//  Created by Chen on 8/24/24.
//

import XCTest

@testable import ImageSearch

final class ImageSearchViewModelTests: XCTestCase {
    private var sut: ImageSearchViewModel!  // System Under Test

    override func setUp() {
        super.setUp()
        sut = ImageSearchViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
