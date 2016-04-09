//
//  SelectBgViewController.swift
//  DenemeGameWithBurak
//
//  Created by emre esen on 14/03/15.
//  Copyright (c) 2015 emre esen. All rights reserved.
//

import UIKit



class SelectBgViewController: UIViewController {
    
    var  SelectBgDifficulty:DiffucultyChoosing!


    @IBOutlet weak var totalPoint: UILabel!
    @IBOutlet weak var bg1: UIButton!
    @IBOutlet weak var bg2: UIButton!
    @IBOutlet weak var bg3: UIButton!
    @IBOutlet weak var bg4: UIButton!
    @IBOutlet weak var bg5: UIButton!
    @IBOutlet weak var bg6: UIButton!
    @IBOutlet weak var bg7: UIButton!
    
    
    var overlayView: UIView!
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    var tempAlert : UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    
    override func viewWillAppear(animated: Bool) {
       
        if Model.sharedInstance.sound == true {
            
            SKTAudio.sharedInstance().resumeBackgroundMusic()
            
        }
    
        
        if NSUserDefaults.standardUserDefaults().objectForKey("bgcount") != nil
        {
            
            Model.sharedInstance.bgcount = NSUserDefaults.standardUserDefaults().objectForKey("bgcount") as! Int
            
        }
        
        
        totalPoint.text = "\(Model.sharedInstance.totalscore)"
        
        
        if Model.sharedInstance.totalscore > level2UnlockValue
        {
            
            let image = UIImage(named: "UnlockBG6.png") as UIImage!
            bg2.setImage(image, forState: .Normal)
        }
        
        if Model.sharedInstance.totalscore > level3UnlockValue
        {
            
            let image = UIImage(named: "UnlockBG2.png") as UIImage!
            bg3.setImage(image, forState: .Normal)
        }
        
        if Model.sharedInstance.totalscore > level4UnlockValue
        {
            
            let image = UIImage(named: "UnlockBG3.png") as UIImage!
            bg4.setImage(image, forState: .Normal)
        }
        
        if Model.sharedInstance.totalscore > level5UnlockValue
        {
            
            let image = UIImage(named: "UnlockBG8.png") as UIImage!
            bg5.setImage(image, forState: .Normal)
        }
        
        if Model.sharedInstance.totalscore > level6UnlockValue
        {
            
            let image = UIImage(named: "UnlockBG1.png") as UIImage!
            bg7.setImage(image, forState: .Normal)
            
            
        }
        
        if Model.sharedInstance.totalscore > level7UnlockValue
        {
            let image = UIImage(named: "UnlockBG7.png") as UIImage!
            bg6.setImage(image, forState: .Normal)
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        alertView.center = CGPoint(x: 0, y: 0)
        // Initialize the animator
        animator = UIDynamicAnimator(referenceView: view)
        tempAlert = alertView
        alertView.hidden = false
        
        createAlert()
        
        
    }
   

    @IBAction func Back(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func SelectBg(sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        
        
        
            if let storyboard = storyboard {
                let gameviewController1 = storyboard.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
               
            
                gameviewController1.gVBgChoosing = BgChoosing(rawValue: sender.tag)!
                gameviewController1.gVDifficulty = SelectBgDifficulty

                
                
                if gameviewController1.gVBgChoosing.rawValue == 0
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }
                    
                    
                else if gameviewController1.gVBgChoosing.rawValue == 1 && Model.sharedInstance.totalscore > level2UnlockValue
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }
                    
                else if gameviewController1.gVBgChoosing.rawValue == 2 && Model.sharedInstance.totalscore > level3UnlockValue
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }
                else if gameviewController1.gVBgChoosing.rawValue == 3 && Model.sharedInstance.totalscore > level4UnlockValue
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }
                else  if gameviewController1.gVBgChoosing.rawValue == 4 && Model.sharedInstance.totalscore > level5UnlockValue
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }
                else if gameviewController1.gVBgChoosing.rawValue == 6 && Model.sharedInstance.totalscore > level6UnlockValue
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }
                else if gameviewController1.gVBgChoosing.rawValue == 5 && Model.sharedInstance.totalscore > level7UnlockValue
                    
                {
                    
                    navigationController?.pushViewController(gameviewController1, animated: true)
                }else{
                    
                  
                    showAlert()
                    
                }
                
                
            }
   
        
    }
    
    func createOverlay() {
        // Create a gray view and set its alpha to 0 so it isn't visible
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.grayColor()
        overlayView.alpha = 0.0
        view.addSubview(overlayView)
    }
    
    func createAlert() {

        if alertView == nil {
            tempAlert.center = CGPointZero
            alertView = tempAlert
        }
        alertView.alpha = 0.0
        alertView.layer.cornerRadius = 10;
        alertView.layer.shadowColor = UIColor.blackColor().CGColor;
        alertView.layer.shadowOffset = CGSizeMake(10, 30);
        alertView.layer.shadowOpacity = 0.9;
        alertView.layer.shadowRadius = 10.0;
      
        view.addSubview(alertView)
    }
    
    func showAlert() {

        if (alertView == nil) {
            createAlert()
        }

        createGestureRecognizer()
        
        animator.removeAllBehaviors()
        

        
        // Animate the alert view using UIKit Dynamics.
        alertView.alpha = 1.0
        
        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: alertView, snapToPoint: view.center)
        animator.addBehavior(snapBehaviour)
    }
    
    
    @IBAction func dismissBtn(sender: AnyObject) {
        
        dismissAlert()
        
    }
    
    func dismissAlert() {
        
        animator.removeAllBehaviors()
        
        let gravityBehaviour: UIGravityBehavior = UIGravityBehavior(items: [alertView])
        gravityBehaviour.gravityDirection = CGVectorMake(0.0, 10.0);
        animator.addBehavior(gravityBehaviour)
   
        let itemBehaviour: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [alertView])
        itemBehaviour.addAngularVelocity(CGFloat(-M_PI_2), forItem: alertView)
        animator.addBehavior(itemBehaviour)
     
        UIView.animateWithDuration(0.5, animations: {
            self.alertView.removeFromSuperview()
            self.alertView = nil
            })
        
    }
    
    
    func createGestureRecognizer() {
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    func handlePan(sender: UIPanGestureRecognizer) {
        
        if (alertView != nil) {
            let panLocationInView = sender.locationInView(view)
            let panLocationInAlertView = sender.locationInView(alertView)
            
            if sender.state == UIGestureRecognizerState.Began {
                animator.removeAllBehaviors()
                
                let offset = UIOffsetMake(panLocationInAlertView.x - CGRectGetMidX(alertView.bounds), panLocationInAlertView.y - CGRectGetMidY(alertView.bounds));
                attachmentBehavior = UIAttachmentBehavior(item: alertView, offsetFromCenter: offset, attachedToAnchor: panLocationInView)
                
                animator.addBehavior(attachmentBehavior)
            }
            else if sender.state == UIGestureRecognizerState.Changed {
                attachmentBehavior.anchorPoint = panLocationInView
            }
            else if sender.state == UIGestureRecognizerState.Ended {
                animator.removeAllBehaviors()
                
                snapBehavior = UISnapBehavior(item: alertView, snapToPoint: view.center)
                animator.addBehavior(snapBehavior)
                
                if sender.translationInView(view).y > 200 {
                    dismissAlert()
                }
            }
        }
        
    }

    deinit {
    }



}
