//
//  DifficultyViewController.swift
//  DenemeGameWithBurak
//
//  Created by emre esen on 13/04/15.
//  Copyright (c) 2015 emre esen. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }
    
    
    @IBAction func Back(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)


    }
    
    @IBAction func selectDifficulty(sender: AnyObject) {
        
        
        SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        if let storyboard = storyboard {
            let gameviewController1 = storyboard.instantiateViewControllerWithIdentifier("SelectBgViewController") as! SelectBgViewController
            
            

            gameviewController1.SelectBgDifficulty = DiffucultyChoosing(rawValue: sender.tag)!

            
            navigationController?.pushViewController(gameviewController1, animated: true)

            
        }

        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
    }
    
    

}
