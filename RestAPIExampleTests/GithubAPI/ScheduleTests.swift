//
//  ScheduleTests.swift
//  popchef
//
//  Created by Howard Wilson on 02/02/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

import XCTest
import RestAPIExample

class ScheduleTests: RestAPIExampleTests {
  func testGetRepository() {
    stubRequest(
      "http://api.github.com/repos/watsonbox/pocketsphinx-ruby",
      json: [
        "id": 25201289,
        "name": "pocketsphinx-ruby",
        "full_name": "watsonbox/pocketsphinx-ruby"
      ]
    )

    let expectation = expectationWithDescription("Should return a Repository object")

    Repository.get("watsonbox/pocketsphinx-ruby") { repository in
      XCTAssertNotNil(repository)
      XCTAssertEqual(repository!.id, 25201289)
      XCTAssertEqual(repository!.name, "pocketsphinx-ruby")
      XCTAssertEqual(repository!.fullName, "watsonbox/pocketsphinx-ruby")

      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(2.0, handler: nil)
  }
}
