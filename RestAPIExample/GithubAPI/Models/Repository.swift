//
//  Repository.swift
//  RestAPIExample
//
//  Created by Howard Wilson on 01/02/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

import Foundation

class Repository {
  let id: Int
  let name: String
  let fullName: String

  init() {
    id = 0
    name = ""
    fullName = ""
  }

  class func get(name: String, result: (Repository?) -> ()) {

  }
}
