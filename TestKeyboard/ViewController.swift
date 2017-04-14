//
//  ViewController.swift
//  TestKeyboard
//
//  Created by 焦相如 on 07/04/2017.
//  Copyright © 2017 jaxer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textView = UITextView(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        textView.backgroundColor = UIColor.lightGray
        self.view.addSubview(textView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

