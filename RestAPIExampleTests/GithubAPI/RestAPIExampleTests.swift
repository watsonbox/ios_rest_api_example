//
//  PopAPITests.swift
//  popchef
//
//  Created by Howard Wilson on 02/02/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

import XCTest

class RestAPIExampleTests: XCTestCase {
  override func setUp() {
    super.setUp()

    // Add a catch-all stub to ensure that no real API requests are made during test run
    // See also: https://github.com/AliSoftware/OHHTTPStubs/wiki/Usage-Examples#stack-multiple-stubs-and-remove-installed-stubs
    catchAllRequests()
  }

  override func tearDown() {
    OHHTTPStubs.removeAllStubs()

    super.tearDown()
  }

  func stubRequest(url: String, json: AnyObject!, statusCode: Int32 = 200) {
    return stubRequest(url, response: OHHTTPStubsResponse(JSONObject: json, statusCode: statusCode, headers: nil))
  }

  func stubRequest(url: String, response: OHHTTPStubsResponse) {
    OHHTTPStubs.stubRequestsPassingTest({ (request: NSURLRequest!) -> Bool in
      return request.URLString == url
      }, withStubResponse: { (request: NSURLRequest!) -> OHHTTPStubsResponse in
        return response
    })
  }

  func catchAllRequests() {
    OHHTTPStubs.stubRequestsPassingTest({ (request: NSURLRequest!) -> Bool in
      return true
      }, withStubResponse: { (request: NSURLRequest!) -> OHHTTPStubsResponse in
        XCTFail("Real web requests are not allowed: " + request.URLString)
        return OHHTTPStubsResponse()
    })
  }
}
