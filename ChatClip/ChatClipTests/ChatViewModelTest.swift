//
//  ChatViewModelTest.swift
//  ChatClipTests
//
//  Created by Javier Heisecke on 2023-10-16.
//

import XCTest
@testable import ChatClip

final class ChatViewModelTest: XCTestCase {

    var viewModel = ChatViewModel(apiService: APIClient(), store: PreviewsStore())

    func testGetCountryPhoneCodes() async throws {
        viewModel.getCountryPhoneCodes()
        XCTAssertNotNil(viewModel.countryCodes)
    }

}
