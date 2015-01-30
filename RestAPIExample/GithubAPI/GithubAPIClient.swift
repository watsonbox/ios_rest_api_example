//
//  GithubAPIClient.swift
//  RestAPIExample
//
//  Created by Howard Wilson on 30/01/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

class GithubAPIClient {
  /// Use PopAPIClient.sharedInstance singleton to call the API
  class var sharedInstance: GithubAPIClient {
    get { return GithubAPIClientSharedInstance }
  }
}

let GithubAPIClientSharedInstance = GithubAPIClient()
