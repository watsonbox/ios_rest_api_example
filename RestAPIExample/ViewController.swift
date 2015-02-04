//
//  ViewController.swift
//  RestAPIExample
//
//  Created by Howard Wilson on 27/01/2015.
//  Copyright (c) 2015 Howard Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    Repository.get("watsonbox/pocketsphinx-ruby") { repository in
      self.textView.text = repository?.description
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
