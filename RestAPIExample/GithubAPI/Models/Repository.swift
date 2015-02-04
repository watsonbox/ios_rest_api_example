//
//  Repository.swift
//  RestAPIExample
//
//  Created by Howard Wilson on 01/02/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

class Repository : ResponseObjectSerializable {
  let id: Int
  var name: String
  var fullName: String

  required init(data: JSON) {
    id = data["id"].int!
    name = data["name"].string!
    fullName = data["full_name"].string!
  }

  class func get(name: String, result: (Repository?) -> (), failure: GithubAPIFailureHandler? = nil) {
    GithubAPIClient.sharedInstance.getSingleObject(path: "/repos/\(name)", result: result, failure: failure)
  }
}
