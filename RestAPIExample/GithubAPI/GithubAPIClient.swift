//
//  GithubAPIClient.swift
//  RestAPIExample
//
//  Created by Howard Wilson on 30/01/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

import Foundation

protocol ResponseObjectSerializable {
  init(data: JSON)
}

protocol GithubAPIErrorDelegate {
  func popAPIError(error: NSError, code: String?, message: String?)
}

typealias GithubAPIFailureHandler = (error: NSError, code: String?, message: String?) -> ()

class GithubAPIClient {
  /// Use PopAPIClient.sharedInstance singleton to call the API
  class var sharedInstance: GithubAPIClient {
    get { return GithubAPIClientSharedInstance }
  }

  var baseURL = "https://api.github.com"
  var errorDelegate: GithubAPIErrorDelegate?

  func getSingleObject<T: ResponseObjectSerializable>(#path: String, parameters: [String : AnyObject]? = nil, result: (T?) -> (), failure: GithubAPIFailureHandler? = nil) {
    buildRequest(baseURL + path, parameters: parameters).validate().responseJSON() {
      _, response, json, error in self.handleSingleObject(response, json: json, error: error, result, failure)
    }
  }

  private func buildRequest(url: String, method: String = "GET", parameters: [String : AnyObject]? = nil) -> Alamofire.Request {
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)

    request.HTTPMethod = method

    return Alamofire.request(Alamofire.ParameterEncoding.JSON.encode(request, parameters: parameters).0)
  }

  private func handleResponse(response: NSHTTPURLResponse?, json: AnyObject?, error: NSError?, result: () -> (), failure: GithubAPIFailureHandler?) {
    if let error = error {
      self.publishError(error, json: json == nil ? nil : JSON(json!), failure: failure)
    } else {
      result()
    }
  }

  private func handleSingleObject<T: ResponseObjectSerializable>(response: NSHTTPURLResponse?, json: AnyObject?, error: NSError?, result: (T?) -> (), failure: GithubAPIFailureHandler?) {
    if let error = error {
      self.publishError(error, json: json == nil ? nil : JSON(json!), failure: failure)
    } else if let json: AnyObject = json {
      result(T(data: JSON(json)))
    } else {
      result(.None)
    }
  }

  func publishError(error: NSError, json: JSON?, failure: GithubAPIFailureHandler? = nil) {
    failure?(error: error, code: json?["error"].string, message: json?["message"].string)
    errorDelegate?.popAPIError(error, code: json?["error"].string, message: json?["message"].string)
  }
}

let GithubAPIClientSharedInstance = GithubAPIClient()
