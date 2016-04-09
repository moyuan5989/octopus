//
//  GameViewController.swift
//  DenemeGameWithBurak
//
//  Created by emre esen on 06/02/15.
//  Copyright (c) 2015 emre esen. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit
import Social
import StoreKit
import GoogleMobileAds

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver,GADInterstitialDelegate

{

    @IBOutlet weak var RemoveAdsBtn: UIButton!
    @IBOutlet weak var returnmainmenubutton: UIButton!
    @IBOutlet weak var soundOnBtn: UIButton!
    @IBOutlet weak var soundOffBtn: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var refreshGameBtn: UIButton!
    @IBOutlet weak var RestoreiAP: UIButton!
    
    

    @IBOutlet weak var LoadingView: UIView!
    
    
    
    
    // Variables
    var highscore = 0
    var control:Int!
    var gVBgChoosing:BgChoosing!
    var gVDifficulty:DiffucultyChoosing!
    var endgamebuton = false
    var scene = GameScene(size:CGSize(width: 1024, height: 768))
    
    
    
    // Admob
    var AdMobID:String!
    var Interstitial:GADInterstitial?
    
   let textureAtlas = SKTextureAtlas(named: "scene.atlas")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
        
        
        LoadingView.hidden = false
        SwiftSpinner.show("Octopus incoming", animated: false)
        
       
        
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayInterstitial", name: "kDisplayInterstitialNotification", object: nil)
        
        Interstitial = createAndLoadInterstitial()

        
      
        
        if NSUserDefaults.standardUserDefaults().objectForKey("AdMobAdShows") != nil
        {
            
//            AdMob_Enabled = NSUserDefaults.standardUserDefaults().objectForKey("AdMobAdShows") as! Bool
            
        }
        

            refreshGameBtn.hidden = true
            RestoreiAP.hidden = true
    
            let skView = self.view as! SKView
            
            skView.ignoresSiblingOrder = true
           // skView.showsNodeCount = true
           // skView.showsFPS = true
            
            /* Set the scale mode to scale to fit the window */
        
            scene.scaleMode = .AspectFill
            scene.gSceneBg = gVBgChoosing
            scene.gSceneDifficult = gVDifficulty
            scene.GameviewcontrollerBridge = self
        
        
        
         self.textureAtlas.preloadWithCompletionHandler { () -> Void in
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
         
           
            self.LoadingView.hidden = true
                SwiftSpinner.hide()
                
                
            skView.presentScene(self.scene)
               
                
            }
            
            
        }
        
     

    }

   
    
    @IBAction func RefreshGameFunc(sender: UIButton) {
        
        //RELOAD GAME
        RemoveAdsBtn.hidden = true
        scene.GameviewcontrollerBridge = self
        scene.reloadgame()
        refreshGameBtn.hidden = true
        soundOffBtn.hidden = true
        RestoreiAP.hidden = true
        Model.sharedInstance.ShieldAddBool = false

        
    }
 
    
    
    @IBAction func pauseAction(sender: UIButton) {
         SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        let scene1 = (self.view as! SKView).scene!
        
        pauseLabel.hidden = false
        pauseButton.hidden = true
        resumeButton.hidden = false
        scene1.paused = true
        scene.stopTimerFunc()
 
        
    }
    
    
    @IBAction func ResumeBtn(sender: UIButton)
    {
        
        SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        let scene1 = (self.view as! SKView).scene!
        
        pauseLabel.hidden = true
        pauseButton.hidden = false
        resumeButton.hidden = true
        scene1.paused = false
        scene.timerfunc()
        
    }


  
    @IBAction func SoundOnFunc(sender: AnyObject) {
        
        
        if Model.sharedInstance.sound == true
        {
            
            SKTAudio.sharedInstance().pauseBackgroundMusic()
            
            
            
            Model.sharedInstance.sound = false
            
            soundOnBtn.hidden = true
            soundOffBtn.hidden = false
            
        }
        
    }
    
    @IBAction func SoundOffFunc(sender: AnyObject) {
        
       
            
        SKTAudio.sharedInstance().resumeBackgroundMusic()
            
        
        soundOnBtn.hidden = false
        soundOffBtn.hidden = true
        Model.sharedInstance.sound = true
        
    }
    
    func saveHighscore() {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            
            
            let scoreReporter = GKScore(leaderboardIdentifier: LeaderBoard_ID) //leaderboard id here
            
            scoreReporter.value = Int64(Model.sharedInstance.score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil {
                    print("error")
                }
            })
            
        }
        
    }
    
    // social media publish
    func socialShare(sharingText sharingText: String?, sharingImage: UIImage?, sharingURL: NSURL?) {
        var sharingItems = [AnyObject]()
        
        if let text = sharingText {
            sharingItems.append(text)
        }
        if let image = sharingImage {
            sharingItems.append(image)
        }
        if let url = sharingURL {
            sharingItems.append(url)
        }
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypeCopyToPasteboard,UIActivityTypeAirDrop,UIActivityTypeAddToReadingList,UIActivityTypeAssignToContact,UIActivityTypePostToTencentWeibo,UIActivityTypePostToVimeo,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToWeibo]
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    // social media publish
    @IBAction func publishFB(sender: AnyObject) {
        socialShare(sharingText: "This is my score : \(Model.sharedInstance.score)! Beat me :) ", sharingImage: UIImage(named: "Icon-76.png"), sharingURL: NSURL(string: "https://itunes.apple.com/app/jetpack-challenge-premium/id988154168?mt=8"))
        
    }

    
    @IBAction func returnMainMenu(sender: AnyObject) {
        
        
        self.navigationController?.popViewControllerAnimated(false)
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)

        
        
            dispatch_async(dispatch_get_main_queue(), {
            
                
               
                
                Model.sharedInstance.ShieldAddBool = false
                
                self.pauseLabel.hidden = true
                self.pauseButton.hidden = true
                self.resumeButton.hidden = true
                self.scene.removeall()
         
            
            
        })
        
     

        
    }
    
    
    @IBAction func Restore_iAP(sender: AnyObject) {
        
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        }
        
        
    }
    
    
    @IBAction func RemoveAds(sender: AnyObject) {
        
        buyConsumable()
        
    }
    
    
    func buyConsumable(){
        print("About to fetch the products");
        // We check that we are allow to make the purchase.
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: iAP_ID);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String> );
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fething Products");
        }else{
            print("can't make purchases");
        }
    }
    
    // Helper Methods
    
    func buyProduct(product: SKProduct){
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment);
        
    }
    
    
    // Delegate Methods for IAP
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("got the request from Apple")
        let count : Int = response.products.count
        if (count>0) {
            let validProduct: SKProduct = response.products[0]
            if (validProduct.productIdentifier == iAP_ID) {
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("nothing")
        }
    }
    
    
    func request(request: SKRequest, didFailWithError error: NSError) {
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        print("Received Payment Transaction Response from Apple");
    
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                    IAP()
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .Failed:
                    print("Purchased Failed");
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                     case .Restored:
                        IAP()
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    SweetAlert().showAlert("Purchased is Restored Successfully")
                    
                default:
                    break;
                }
            }
        }
        
    }
    
    
    func IAP()
    {
        

            AdMob_Enabled = false
            NSUserDefaults.standardUserDefaults().setObject(AdMob_Enabled, forKey: "AdMobAdShows")
        
    }
    
    
    func createAndLoadInterstitial()->GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: AdMob_ID)
        
        interstitial.delegate = self
        
        
        interstitial.loadRequest(GADRequest())
        return interstitial
    }
    
    
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        Interstitial = createAndLoadInterstitial()
    }
    
    func interstitialWillDismissScreen(ad: GADInterstitial!) {
        Interstitial = createAndLoadInterstitial()
    }
    
    func displayInterstitial() {
        if let _ = Interstitial?.isReady {
            Interstitial?.presentFromRootViewController(self)
        }
    }
    

    
    deinit {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        
        
    }

   
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Fade
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
 
  
}
