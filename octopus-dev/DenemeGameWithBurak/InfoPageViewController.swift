//
//  InfoPageViewController.swift
//  DenemeGameWithBurak
//
//  Created by emre esen on 14/04/15.
//  Copyright (c) 2015 emre esen. All rights reserved.
//

import UIKit

class InfoPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePage(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func BackBtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        navigationController!.popViewControllerAnimated(true)
    }
 

}
