//
//  GameScene.swift
//  DenemeGameWithBurak
//
//  Created by emre esen on 06/02/15.
//  Copyright (c) 2015 emre esen. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var cointexture : SKTexture!
    var bgTexture : SKTexture!
    var stageParticle : SKEmitterNode!
    var playerEmitter1 = SKEmitterNode()
    var redcointexture : SKTexture!
    var flyherotex1 : SKTexture!
    
    var shieldTexture : SKTexture!
    var shieldItemTexture : SKTexture!
    var coinherotex1 : SKTexture!
    
    var redcoinherotex1 : SKTexture!
    
    var runherotex1 : SKTexture!
    
    var deadherotex1 : SKTexture!
    
    var rocketherotex1 : SKTexture!
    
    var rocketExptex1 : SKTexture!
    
    var Electriclighting1 : SKTexture!
    
    var MineTexture1 : SKTexture!
    var MineTexture2 : SKTexture!
    
    // SKTextures Array for animateWithTextures
    
    var HeroFlyTexturesArray = [SKTexture]()
    var HeroDeathTexturesArray = [SKTexture]()
    var HeroRunTexturesArray = [SKTexture]()
    var CoinTexturesArray = [SKTexture]()
    var RocketTexturesArray = [SKTexture]()
    var RocketExplodeTexturesArray = [SKTexture]()
    var ElectricTexturesArray = [SKTexture]()
    
    

    
    
    
    
    
    // Classes
    var animations = AnimationClass()
    
    
    // Variables
    var moveShipY1 = SKAction()
    var gameover = 0
    var emit = false
    var emitFrameCount = 0
    var maxEmitFrameCount = 30
    var range1 :CGFloat = 0.50
    var playerCurrentPosition = CGPoint() // For Emitter
    var GameviewcontrollerBridge: GameViewController!
    var gSceneBg:BgChoosing!
    var gSceneDifficult:DiffucultyChoosing!
    
    // Timers
    var TimerAddCoin = NSTimer()
    var TimerAddMine = NSTimer()
    var TimerAddElectriclighting = NSTimer()
    var TimerRoketAdd = NSTimer()
    var TimerRedCoinAdd = NSTimer()
    var TimerAddShieldItem = NSTimer()
   
    // BitMasks
    
    var herogroup : UInt32 = 0x1 << 1
    var coingroup : UInt32 = 0x1 << 2
    var redCoinGroup : UInt32 = 0x1 << 4
    var objectgroup : UInt32 = 0x1 << 3
    var groundgroup : UInt32 = 0x1 << 5
    var rocketgroup : UInt32 = 0x1 << 6
    var shieldgroup : UInt32 = 0x1 << 7
    
   
    // LabelNodes
    
    var tabtoplayLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var highscoreLabel2 = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var stageLabel = SKLabelNode()
    var gameoverLabel = SKLabelNode()
    
    
    // Sprites Objects
    
    var coinobject = SKNode()
    var redCoinObject = SKNode()
    var groundobject = SKNode()
    var shieldObject = SKNode()
    var shieldItemObject = SKNode()
    var movingObject = SKNode()
    var rocketObject = SKNode()
    var gameoverObject = SKNode()
    var emitterObject = SKNode()
    var playerEmitterObject = SKNode()
    var heroobject = SKNode()
    var labelobject = SKNode()
    var bgobject = SKNode()
    
    
    // SpriteNodes
    
    var hero = SKSpriteNode()
    var rocket = SKSpriteNode()
    var coin = SKSpriteNode()
    var redCoin = SKSpriteNode()
    var shield = SKSpriteNode()
    var Electriclighting = SKSpriteNode()
    var Mine = SKSpriteNode()
    var bg = SKSpriteNode()
    var shielditem = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    
    // Sounds
    var ElectricDeadPreload = SKAction()
    var ElectricCreatePreload = SKAction()
    var RocketCreatePreload = SKAction()
    var RocketExplosionPreload = SKAction()
    var BackgroundPreload = SKAction()
    var ShieldOnPreload = SKAction()
    var ShieldOffPreload = SKAction()
    var PickCoinPreload = SKAction()
    var PressBtnPreload = SKAction()
    
  
 
   
   
   
    override func didMoveToView(view: SKView) {
      
        
        // background Texture
        
        bgTexture = SKTexture(imageNamed: "bg01.png")
        
        //Emitters
        stageParticle = SKEmitterNode(fileNamed: "StageEmitter.sks")!
        playerEmitter1 = SKEmitterNode(fileNamed: "engine.sks")!
        
        //Coins Texture
        
        cointexture = SKTexture(imageNamed: "coin.jpg")
        redcointexture = SKTexture(imageNamed: "coin.jpg")
        coinherotex1 = SKTexture(imageNamed: "Coin0.png")
        
        redcoinherotex1 = SKTexture(imageNamed: "Coin0.png")
        
        
        // shields and shield item texture
        
        shieldTexture = SKTexture(imageNamed: "shield.png")
        shieldItemTexture = SKTexture(imageNamed: "shielditem.png")
        
        // Hero textures
        
        flyherotex1 = SKTexture(imageNamed: "Fly0.png")
        
        
        
        runherotex1 = SKTexture(imageNamed: "Run0.png")
        
        
        deadherotex1 = SKTexture(imageNamed: "Dead0.png")
        
        
        // Rocket Textures
        
        rocketherotex1 = SKTexture(imageNamed: "Rocket0.png")
        
        
        
        
        rocketExptex1 = SKTexture(imageNamed: "RocketExplode0.png")
        
        
        // Electriclight Textures
        
        Electriclighting1 = SKTexture(imageNamed: "Electriclighting0.png")
        
        // Mines Textures
        
        MineTexture1 = SKTexture(imageNamed: "metalball1.png")
        MineTexture2 = SKTexture(imageNamed: "metalball2.png")
        

        
        
        self.physicsWorld.contactDelegate = self
        
        
        createObjects()
     
        
        if Model.sharedInstance.totalscore > 500 {
            
            Model.sharedInstance.rateBool = true
            
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("highScore") != nil
        {
            Model.sharedInstance.highcore = NSUserDefaults.standardUserDefaults().objectForKey("highScore") as! Int
            highscoreLabel.text = "\(Model.sharedInstance.highcore)"
            
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("totalscore") != nil
        {
            
            Model.sharedInstance.totalscore = NSUserDefaults.standardUserDefaults().objectForKey("totalscore") as! Int
            
            
        }
       
     
       if gameover == 0 {
           
            CreateGame()
        }
        
       
        self.PickCoinPreload = SKAction.playSoundFileNamed("PickCoin.mp3", waitForCompletion: false)
        self.ElectricDeadPreload = SKAction.playSoundFileNamed("electricDead.mp3", waitForCompletion: false)
        self.ElectricCreatePreload = SKAction.playSoundFileNamed("electricCreate.wav", waitForCompletion: false)
        self.RocketExplosionPreload = SKAction.playSoundFileNamed("RocketExplosion.wav", waitForCompletion: false)
        self.RocketCreatePreload = SKAction.playSoundFileNamed("RocketCreate.wav", waitForCompletion: false)
        self.ShieldOnPreload = SKAction.playSoundFileNamed("shieldOn.mp3", waitForCompletion: false)
        self.ShieldOffPreload = SKAction.playSoundFileNamed("shieldOff.mp3", waitForCompletion: false)
        
        

    
        
    }
    
 
    
    func createObjects()
    {
        
     
        
        // Add all objects to self
        
        self.addChild(movingObject)
        self.addChild(rocketObject)
        self.addChild(coinobject)
        self.addChild(redCoinObject)
        self.addChild(groundobject)
        self.addChild(heroobject)
        self.addChild(labelobject)
        self.addChild(bgobject)
        self.addChild(gameoverObject)
        self.addChild(emitterObject)
        self.addChild(playerEmitterObject)
        self.addChild(shieldObject)
        self.addChild(shieldItemObject)
    }
    
    func CreateGame()
    {
        
        createBg()
        makeground()
        makesky()
        bg.zPosition = -1
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.createhero()
            self.timerfunc()
            self.AddElectriclighting()
            self.createplayerEmitter()
           
            
        }
        addtaptoplayfunc()
        addstage()
        addscore()
        GameviewcontrollerBridge.soundOnBtn.hidden = true
        GameviewcontrollerBridge.returnmainmenubutton.hidden = true
        highscoreLabel2.hidden = true
        GameviewcontrollerBridge.ShareButton.hidden = true
        GameviewcontrollerBridge.refreshGameBtn.hidden = true
        self.GameviewcontrollerBridge.RestoreiAP.hidden = true
        GameviewcontrollerBridge.soundOffBtn.hidden = true
        
       
        if labelobject.children.count != 0
        {
            labelobject.removeAllChildren()
        }
    }
    
    
    func stopTimerFunc()
        
    {
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
    }
    
    
    func addcoin()
        
    {
        
        
        
        coin = SKSpriteNode(texture: cointexture)
        
        CoinTexturesArray = [SKTexture(imageNamed: "Coin0"),SKTexture(imageNamed: "Coin1"),SKTexture(imageNamed: "Coin2")]
        
        
        let coinAnimation = SKAction.animateWithTextures(CoinTexturesArray, timePerFrame: 0.1)
        
        let flyhero = SKAction.repeatActionForever(coinAnimation)
        coin.runAction(flyhero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        coin.size.width = 40
        coin.size.height = 40
        coin.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: coin.size.width - 20 , height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + cointexture.size().height + 90 + pipeOffset )
        let movecoin = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatActionForever(SKAction.sequence([movecoin,removeAction]))
       
        coin.runAction(dusmanMovebgForever)
        
        coin.physicsBody?.dynamic = false
        coin.physicsBody?.categoryBitMask = coingroup
        coin.zPosition = 1
        coinobject.addChild(coin)
        
        
    }
    
    func addShield()
        
    {
        shield = SKSpriteNode(texture: shieldTexture)
        if Model.sharedInstance.sound == true
            
        {
        runAction(ShieldOnPreload)
            
        }
        shield.zPosition = 1
        shieldObject.addChild(shield)
        
    }
    
    func addShieldItem()
        
    {
        shielditem = SKSpriteNode(texture: shieldItemTexture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        shielditem.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: shielditem.size.width - 20 , height: shielditem.size.height - 20))
        shielditem.physicsBody?.restitution = 0
        shielditem.position = CGPoint(x: self.size.width + 50, y: 0 + shieldItemTexture.size().height + self.size.height/2 + pipeOffset)
        let movecoin = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatActionForever(SKAction.sequence([movecoin,removeAction]))
        
        shielditem.runAction(dusmanMovebgForever)
        
        animations.scaleZdirection(shielditem)
        shielditem.setScale(1.1)
        
        shielditem.physicsBody?.dynamic = false
        shielditem.physicsBody?.categoryBitMask = shieldgroup
        shielditem.zPosition = 1
        shieldItemObject.addChild(shielditem)
        
    }
    
    
    func redCoinAdd() {
        
        redCoin = SKSpriteNode(texture:redcointexture)
        
        CoinTexturesArray = [SKTexture(imageNamed: "Coin0"),SKTexture(imageNamed: "Coin1"),SKTexture(imageNamed: "Coin2")]
        
        let coinAnimation1 = SKAction.animateWithTextures(CoinTexturesArray, timePerFrame: 0.1)
        
        let flyhero1 = SKAction.repeatActionForever(coinAnimation1)
        redCoin.runAction(flyhero1)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        redCoin.size.width = 40
        redCoin.size.height = 40
        redCoin.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: coin.size.width - 10 , height: coin.size.height - 10))
        redCoin.physicsBody?.restitution = 0
        redCoin.position = CGPoint(x: self.size.width + 50, y: 0 + cointexture.size().height + 90 + pipeOffset )
        let movecoin = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatActionForever(SKAction.sequence([movecoin,removeAction]))
        
        
        redCoin.runAction(dusmanMovebgForever)
        animations.scaleZdirection(redCoin)
        animations.redColorAnimation(redCoin, animDuration: 0.5)
        redCoin.setScale(1.3)
        redCoin.physicsBody?.dynamic = false
        redCoin.physicsBody?.categoryBitMask = redCoinGroup
        redCoin.zPosition = 1
        redCoinObject.addChild(redCoin)
        
        
        
    }
    
   
    func createEmitterFunc()
        
    {
        stageParticle = SKEmitterNode(fileNamed: "StageEmitter.sks")!
        stageParticle.position = stageLabel.position
        emitterObject.zPosition = 1
        
        emitterObject.addChild(stageParticle)
    }
    
    func createScoreEmitterFunc()
        
    {
        stageParticle = SKEmitterNode(fileNamed:"StageEmitter.sks")!
        stageParticle.position = scoreLabel.position
        emitterObject.zPosition = 1
        emitterObject.addChild(stageParticle)
        
    }
    
    func createplayerEmitter()
        
    {
       playerEmitter1 = SKEmitterNode(fileNamed:"engine.sks")!
        playerEmitterObject.zPosition = 1
        playerEmitterObject.addChild(playerEmitter1)
        
    }
    
    
    func addHero(Herotipi: SKSpriteNode, atPosition position: CGPoint) -> SKSpriteNode {
        
        hero = SKSpriteNode(texture: flyherotex1)
        
        HeroFlyTexturesArray = [SKTexture(imageNamed: "Fly0"),SKTexture(imageNamed: "Fly1"),SKTexture(imageNamed: "Fly2"),SKTexture(imageNamed: "Fly3"),SKTexture(imageNamed: "Fly4")]
        
        let HeroFlyAnimation = SKAction.animateWithTextures(HeroFlyTexturesArray, timePerFrame: 0.1)
        
        hero.position = position
        let flyhero = SKAction.repeatActionForever(HeroFlyAnimation)
        hero.runAction(flyhero)
        hero.size.height = 84
        hero.size.width = 120
        hero.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: hero.size.width - 40 , height: hero.size.height - 30))
        
        hero.physicsBody?.categoryBitMask = herogroup
        hero.physicsBody?.contactTestBitMask = coingroup | objectgroup | groundgroup|rocketgroup|redCoinGroup|shieldgroup
        hero.physicsBody?.collisionBitMask = groundgroup
        
        hero.physicsBody!.dynamic = true
        hero.physicsBody?.allowsRotation = false
        hero.zPosition = 1
        
        heroobject.addChild(hero)
        return hero
    }
    
    func addstage()
        
    {
        
        stageLabel.text = "Stage 1"
        stageLabel.position = CGPoint(x: CGRectGetMaxX(self.frame) - 60, y: CGRectGetMaxY(self.frame) - 140)
        stageLabel.fontSize = 30
        
        stageLabel.fontColor = UIColor.whiteColor()
        stageLabel.fontName = "Chalkduster"
        stageLabel.zPosition = 1
        
        self.addChild(stageLabel)
    }
    
    func addtaptoplayfunc()
        
    {
        
        tabtoplayLabel.text = "Tap to Fly!!"
        tabtoplayLabel.position = CGPoint(x: CGRectGetMidX(self.frame) , y: CGRectGetMidY(self.frame))
        tabtoplayLabel.fontSize = 50
        tabtoplayLabel.fontColor = UIColor.whiteColor()
        tabtoplayLabel.fontName = "Chalkduster"
        tabtoplayLabel.zPosition = 1
        
        self.addChild(tabtoplayLabel)
    }
    
    
    func addscore()
        
    {
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame) - 200)
        scoreLabel.fontSize = 60
        
        scoreLabel.fontColor = UIColor.whiteColor()
        scoreLabel.zPosition = 1
        
        self.addChild(scoreLabel)
    }
    
    
    func showhighscoreLabelfunc()
    {
        highscoreLabel2.position = CGPoint(x: CGRectGetMaxX(self.frame) - 100, y: CGRectGetMaxY(self.frame) - 150)
        highscoreLabel2.fontSize = 30
        highscoreLabel2.fontName = "Chalkduster"
        highscoreLabel2.fontColor = UIColor.whiteColor()
        highscoreLabel2.text = "HighScore"
        highscoreLabel2.zPosition = 1
        
        labelobject.addChild(highscoreLabel2)
    }
    
    
    func showhighscore()
        
    {
        
        highscoreLabel = SKLabelNode()
        highscoreLabel.position = CGPoint(x: CGRectGetMaxX(self.frame) - 100, y: CGRectGetMaxY(self.frame) - 210)
        highscoreLabel.fontSize = 50
        highscoreLabel.fontName = "Chalkduster"
        highscoreLabel.fontColor = UIColor.whiteColor()
        highscoreLabel.hidden = true
        highscoreLabel.zPosition = 1
        
        labelobject.addChild(highscoreLabel)
        
        
    }
    
    func createhero()
        
    {
        
        
        let heroooo = hero
        
        addHero(heroooo, atPosition: CGPoint(x: self.size.width/4, y: 0 + flyherotex1.size().height + 400))
    }
    
    
    func makeground()
    {
        ground = SKSpriteNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, self.frame.size.height / 4 + self.frame.size.height / 8))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = groundgroup
        ground.zPosition = 1
        
        groundobject.addChild(ground)
        
    }
    
    func makesky()
    {
        sky = SKSpriteNode()
        
        sky.position = CGPoint(x: 0, y: CGRectGetMaxX(self.frame))
        sky.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width + 100, self.frame.size.height - 100))
        sky.physicsBody?.dynamic = false
        sky.zPosition = 1
        
        movingObject.addChild(sky)
        
    }
    
    
    func createBg()
    {
        switch gSceneBg.rawValue
        {
        case 0:
           bgTexture = SKTexture(imageNamed: "bg01.png")
        case 1:
            bgTexture = SKTexture(imageNamed: "bg02.png")
        case 2:
           bgTexture = SKTexture(imageNamed: "bg03.png")
        case 3:
            bgTexture = SKTexture(imageNamed: "bg04.png")
        case 4:
           bgTexture = SKTexture(imageNamed: "bg05.png")
        case 5:
            bgTexture = SKTexture(imageNamed: "bg06.png")
        case 6:
           bgTexture = SKTexture(imageNamed: "bg07.png")
        default:
            bgTexture = SKTexture(imageNamed: "bg07.png")
        }
        
        let movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 3)
        
        let replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let movebgForever = SKAction.repeatActionForever(SKAction.sequence([movebg,replacebg]))
        
        
        for var i:CGFloat=0; i<3; i++
        {
            
            bg = SKSpriteNode(texture: bgTexture)
            
            bg.position = CGPoint(x: size.width/4 + bgTexture.size().width * i, y: size.height/2)
            bg.size.height = self.frame.height
            bg.runAction(movebgForever)
            bg.zPosition = 0
            
            bgobject.addChild(bg)
        }
        
        
    }
    
    
    func LevelUp()
    {
        if 1 <= Model.sharedInstance.score && Model.sharedInstance.score < 10
        {
            
            coinobject.speed = 1.05
            redCoinObject.speed = 1.1
            movingObject.speed = 1.05
            rocketObject.speed = 1.05
            self.speed = 1.05
            stageLabel.text = "Stage 1"
            
            
            
        }
        else if  10 <= Model.sharedInstance.score && Model.sharedInstance.score < 16
        {
            
            stageLabel.text = "Stage 2"
            coinobject.speed = 1.1
            redCoinObject.speed = 1.15
            movingObject.speed = -1.1
            rocketObject.speed = 1.1
            
            self.speed = 1.1
            
            
            
        }else if  16 <= Model.sharedInstance.score && Model.sharedInstance.score < 36
        {
            
            
            stageLabel.text = "Stage 3"
            coinobject.speed = 1.15
            redCoinObject.speed = 1.25
            movingObject.speed = 1.15
            rocketObject.speed = 1.15
            
            self.speed = 1.15
            
            
            
        }
        else if 36 <= Model.sharedInstance.score && Model.sharedInstance.score < 60
        {
            
            
            stageLabel.text = "Stage 4"
            coinobject.speed = 1.18
            redCoinObject.speed = 1.28
            movingObject.speed = 1.18
            rocketObject.speed = 1.18
            
            self.speed = 1.18
            
            
            
        } else if 60 <= Model.sharedInstance.score && Model.sharedInstance.score < 80
        {
            
            
            stageLabel.text = "Stage 5"
            coinobject.speed = 1.22
            redCoinObject.speed = 1.32
            movingObject.speed = -1.22
            self.speed = 1.22
            rocketObject.speed = 1.22
            
            
            
            
        } else if 80 <= Model.sharedInstance.score && Model.sharedInstance.score < 150
        {
            
            
            stageLabel.text = "Stage 6"
            coinobject.speed = 1.25
            redCoinObject.speed = 1.35
            movingObject.speed = 1.25
            rocketObject.speed = 1.25
            
            self.speed = 1.25
            
            
            
        } else if 150 <= Model.sharedInstance.score && Model.sharedInstance.score < 190
        {
            
            
            stageLabel.text = "Stage 7"
            coinobject.speed = 1.28
            redCoinObject.speed = 1.38
            movingObject.speed = -1.28
            rocketObject.speed = 1.28
            
            self.speed = 1.28
            
            
            
        } else if 190 <= Model.sharedInstance.score && Model.sharedInstance.score < 300
        {
            
            
            stageLabel.text = "Stage 8"
            coinobject.speed = 1.3
            redCoinObject.speed = 1.35
            movingObject.speed = 1.3
            rocketObject.speed = 1.3
            
            self.speed = 1.3
            
            
            
        } else if 300 <= Model.sharedInstance.score && Model.sharedInstance.score < 500
        {
            
            
            stageLabel.text = "Stage 9"
            coinobject.speed = 1.35
            redCoinObject.speed = 1.40
            movingObject.speed = 1.35
            self.speed = 1.35
            rocketObject.speed = 1.35
            
            
            
            
        } else if 500 <= Model.sharedInstance.score
        {
            
            
            stageLabel.text = "Stage 10"
            coinobject.speed = 1.5
            redCoinObject.speed = 1.60
            movingObject.speed = 1.5
            rocketObject.speed = 1.5
            
            self.speed = 1.5
          
        }
       
    }
    
    func timerfunc()
        
    {
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
        TimerAddCoin = NSTimer.scheduledTimerWithTimeInterval(2.62, target: self, selector: Selector("addcoin"), userInfo: nil, repeats: true)
        TimerRedCoinAdd = NSTimer.scheduledTimerWithTimeInterval(8.246, target: self, selector: Selector("redCoinAdd"), userInfo: nil, repeats: true)
        
        
        
        switch gSceneDifficult.rawValue
        {
            // easy mode
        case 0:
            
            TimerAddMine = NSTimer.scheduledTimerWithTimeInterval(4.245, target: self, selector: Selector("AddMine"), userInfo: nil, repeats: true)
            TimerAddElectriclighting = NSTimer.scheduledTimerWithTimeInterval(5.234, target: self, selector: Selector("AddElectriclighting"), userInfo: nil, repeats: true)
            TimerRoketAdd = NSTimer.scheduledTimerWithTimeInterval(3.743, target: self, selector: Selector("RoketAdd"), userInfo: nil, repeats: true)
            
            
            TimerAddShieldItem = NSTimer.scheduledTimerWithTimeInterval(20.246, target: self, selector: Selector("addShieldItem"), userInfo: nil, repeats: true)
            
            // medium mode
        case 1:
            
            TimerAddMine = NSTimer.scheduledTimerWithTimeInterval(3.245, target: self, selector: Selector("AddMine"), userInfo: nil, repeats: true)
            TimerAddElectriclighting = NSTimer.scheduledTimerWithTimeInterval(3.234, target: self, selector: Selector("AddElectriclighting"), userInfo: nil, repeats: true)
            TimerRoketAdd = NSTimer.scheduledTimerWithTimeInterval(2.743, target: self, selector: Selector("RoketAdd"), userInfo: nil, repeats: true)
            
            TimerAddShieldItem = NSTimer.scheduledTimerWithTimeInterval(30.246, target: self, selector: Selector("addShieldItem"), userInfo: nil, repeats: true)
            
            // hard mode
        case 2:
            
            
            
            TimerAddMine = NSTimer.scheduledTimerWithTimeInterval(2.945, target: self, selector: Selector("AddMine"), userInfo: nil, repeats: true)
            TimerAddElectriclighting = NSTimer.scheduledTimerWithTimeInterval(3.034, target: self, selector: Selector("AddElectriclighting"), userInfo: nil, repeats: true)
            TimerRoketAdd = NSTimer.scheduledTimerWithTimeInterval(2.543, target: self, selector: Selector("RoketAdd"), userInfo: nil, repeats: true)
            
            TimerAddShieldItem = NSTimer.scheduledTimerWithTimeInterval(40.246, target: self, selector: Selector("addShieldItem"), userInfo: nil, repeats: true)
            
            // medium for quick play mode
        default:
            TimerAddMine = NSTimer.scheduledTimerWithTimeInterval(3.245, target: self, selector: Selector("AddMine"), userInfo: nil, repeats: true)
            TimerAddElectriclighting = NSTimer.scheduledTimerWithTimeInterval(3.234, target: self, selector: Selector("AddElectriclighting"), userInfo: nil, repeats: true)
            TimerRoketAdd = NSTimer.scheduledTimerWithTimeInterval(2.743, target: self, selector: Selector("RoketAdd"), userInfo: nil, repeats: true)
            
            TimerAddShieldItem = NSTimer.scheduledTimerWithTimeInterval(30.246, target: self, selector: Selector("addShieldItem"), userInfo: nil, repeats: true)
            
            
        }
        
        
    }
    
    func setTimer(methodName:String, time:NSTimeInterval ) -> NSTimer
        
    {
        let timerset = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: Selector(methodName), userInfo: nil, repeats: true)
        
        return timerset
    }
    
    
    func AddMine()
    {
        
        Mine = SKSpriteNode(texture: MineTexture1)
        let minesRandom = arc4random() % UInt32(2)
        if minesRandom == 0
        {
            Mine = SKSpriteNode(texture: MineTexture1)
        }else
        {
            Mine = SKSpriteNode(texture: MineTexture2)
            
        }
        Mine.size.width = 70
        Mine.size.height = 62
        Mine.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24)
        let moveMayinX = SKAction.moveToX ( -self.frame.size.width / 4 , duration: 4)
        Mine.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Mine.size.width - 40 , height: Mine.size.height - 30))
        
        Mine.physicsBody?.categoryBitMask = objectgroup
        
        Mine.physicsBody?.dynamic = false
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatActionForever(SKAction.sequence([moveMayinX,removeAction]))
        
        
        
        animations.rotateAnimationsToAngle(Mine, animDuration: 0.2)
        Mine.runAction(dusmanMovebgForever)
        Mine.zPosition = 1
        
        movingObject.addChild(Mine)
    }
    
    
    func RoketAdd()
        
    {
        
        rocket = SKSpriteNode(texture: rocketherotex1)
        rocket.size.width = 180
        rocket.size.height = 55
        
        if Model.sharedInstance.sound == true
            
        {
        runAction(RocketCreatePreload) // sound
        }
        
        let movementRandom = arc4random() % 8
        if movementRandom == 0 {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 + 220)
        }else if movementRandom == 1
        {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 - 220)
        }else if movementRandom == 2
        {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 + 120)
        }else if movementRandom == 3
        {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 - 120)
        }else if movementRandom == 4
        {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 + 50)
        }
        else if movementRandom == 5
        {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2 - 50)
        }
            
        else
            
        {
            rocket.position = CGPoint(x: self.frame.width + 100, y: self.frame.height / 2)
            
        }
        
        let movefuze = SKAction.moveToX( -self.frame.size.width / 4 , duration: 4)
        
        RocketTexturesArray = [SKTexture(imageNamed: "Rocket0"),SKTexture(imageNamed: "Rocket1"),SKTexture(imageNamed: "Rocket2"),SKTexture(imageNamed: "Rocket3"),SKTexture(imageNamed: "Rocket4"),SKTexture(imageNamed: "Rocket5")]
        
        let RocketAnimation = SKAction.animateWithTextures(RocketTexturesArray, timePerFrame: 0.1)
        
        let flyFuze = SKAction.repeatActionForever(RocketAnimation)
        
        rocket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: rocket.size.width - 20 , height: rocket.size.height - 10))
        
        rocket.physicsBody?.categoryBitMask = rocketgroup
        
        rocket.physicsBody?.dynamic = false
        
        let maxAspectRatio:CGFloat = 16.0/9.0 // iPhone 5"
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-maxAspectRatioHeight)/2.0
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height-playableMargin*2)
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatActionForever(SKAction.sequence([movefuze,removeAction]))
        
        switch stageLabel.text!
        {
        case "Stage 1":
            range1 = 0.10
            
            
        case "Stage 2":
            range1 = 0.13
            
        case "Stage 3":
            range1 = 0.15
        case "Stage 4":
            range1 = 0.18
            
        case "Stage 5":
            range1 = 0.24
            
        case "Stage 6":
            range1 = 0.28
        case "Stage 7":
            range1 = 0.35
            
        case "Stage 8":
            range1 = 0.40
            
        case "Stage 9":
            range1 = 0.45
        case "Stage 10":
            range1 = 0.50
            
        default:
            range1 = 0.50
            
        }
        
        
        rocket.runAction(SKAction.repeatAction(
            
            SKAction.sequence([
                
                SKAction.moveByX(0, y: CGRectGetHeight(playableRect) * range1, duration: 1.0),
                SKAction.moveByX(0, y: -CGRectGetHeight(playableRect) * range1, duration: 1.0)
                ]), count:4
            ))
        
        
        
        rocket.runAction(dusmanMovebgForever)
        rocket.runAction(flyFuze)
        
        rocket.zPosition = 1
        
        rocketObject.addChild(rocket)
        
    }
    
    
    func AddElectriclighting()
    {
        if Model.sharedInstance.sound == true
        {
        
        runAction(ElectricCreatePreload) // Sound
        }
        
        Electriclighting = SKSpriteNode(texture: Electriclighting1)
        
        var scaleValue:CGFloat = 0.3
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 5)
        let scaleRandom = arc4random() % UInt32(5)
        
        if scaleRandom == 1 {scaleValue = 0.9}
        else if scaleRandom == 2 {scaleValue = 0.6}
        else if scaleRandom == 3 {scaleValue = 0.8}
        else if scaleRandom == 4 {scaleValue = 0.7}
        else if scaleRandom == 0 {scaleValue = 1.0}
        
        
        
        let pipeOffset =   self.frame.size.height / 4 + 30 - CGFloat(movementAmount)
        let randomPosition = arc4random() % 2
        Electriclighting.physicsBody?.restitution = 0
        Electriclighting.setScale(scaleValue)
        
        ElectricTexturesArray = [SKTexture(imageNamed: "Electriclighting0"),SKTexture(imageNamed: "Electriclighting1"),SKTexture(imageNamed: "Electriclighting2"),SKTexture(imageNamed: "Electriclighting3")]
        
        let electricAnimation = SKAction.animateWithTextures(ElectricTexturesArray, timePerFrame: 0.1)
        
        let electricAnimationForever = SKAction.repeatActionForever(electricAnimation)
        
        
        if randomPosition == 0
        {
            
            Electriclighting.position = CGPoint(x: self.size.width + 50, y: 0 + Electriclighting1.size().height/2 + 90 + pipeOffset )
            Electriclighting.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Electriclighting.size.width - 40 , height: Electriclighting.size.height - 20))
        }else
        {
            Electriclighting.position = CGPoint(x: self.size.width + 50, y: self.frame.size.height - Electriclighting1.size().height/2 - 90 - pipeOffset )
            Electriclighting.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Electriclighting.size.width - 40 , height: Electriclighting.size.height - 20))
            
            
            
        }
        
        
        Electriclighting.physicsBody?.dynamic = false
        let movementRandom = arc4random() % 9
        if movementRandom == 0 {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 + 220 , duration: 4)
        }else if movementRandom == 1
        {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 - 220 , duration: 5)
        }else if movementRandom == 2
        {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 - 150 , duration: 4)
        }else if movementRandom == 3
        {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 + 150 , duration: 5)
        }else if movementRandom == 4
        {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 + 50 , duration: 4)
        }
        else if movementRandom == 5
        {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 - 50 , duration: 5)
        }
            
        else
            
        {
            moveShipY1 = SKAction.moveToY (self.frame.height / 2 , duration: 4)
            
        }
        
        let moveAction = SKAction.moveByX(-self.frame.width - 300, y: 0, duration: 6)
        
        
        Electriclighting.runAction(electricAnimationForever)
        Electriclighting.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock() {
                    self.Electriclighting.runAction(SKAction.rotateByAngle(π*2, duration:0.5))
                },
                SKAction.waitForDuration(20.0)
                ])
            ))
        Electriclighting.runAction(moveAction)
        Electriclighting.runAction(moveShipY1)
        Electriclighting.physicsBody?.categoryBitMask = objectgroup
        Electriclighting.zPosition = 1
        movingObject.addChild(Electriclighting)
    }
    
   
    func stopgame()
        
    {
        coinobject.speed = 0
        movingObject.speed = 0
        heroobject.speed = 0
        rocketObject.speed = 0
        
    }
    
    func removeall()
        
    {
        
      

        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        
        gameover = 0
        
        if labelobject.children.count != 0
        {
            labelobject.removeAllChildren()
        }
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
       
        
       

        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.removeFromSuperview()
    
        self.view?.presentScene(nil)
        GameviewcontrollerBridge = nil
      
    }
    
    deinit {
    }
    
    
    func reloadgame()
        
    {
       
        
        if Model.sharedInstance.sound == true {
            
            SKTAudio.sharedInstance().resumeBackgroundMusic()
            
        }
        
        coinobject.removeAllChildren()
        emitterObject.removeAllChildren()
        gameoverObject.removeAllChildren()
        gameoverObject.removeFromParent()
        stageLabel.text = "Stage 1"
        gameover = 0
        scene?.paused = false
        
        movingObject.removeAllChildren()
        rocketObject.removeAllChildren()
        heroobject.removeAllChildren()
        coinobject.speed = 1
        heroobject.speed = 1
        movingObject.speed = 1
        rocketObject.speed = 1
        self.speed = 1
        
        gameoverLabel.hidden = true
        if labelobject.children.count != 0
        {
            labelobject.removeAllChildren()
        }
        makeground()
        makesky()
        createhero()
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        createplayerEmitter()
        GameviewcontrollerBridge.returnmainmenubutton.hidden = true
        GameviewcontrollerBridge.soundOnBtn.hidden = true
        GameviewcontrollerBridge.pauseButton.hidden = false
        stageLabel.hidden = false
        highscoreLabel2.hidden = true
        GameviewcontrollerBridge.ShareButton.hidden = true
        showhighscore()
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
        timerfunc()
        
        
        
        
    }
    
    func addgameovertext()
    {
        gameoverLabel = SKLabelNode()
        gameoverLabel.text = "GAME OVER"
        gameoverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 100)
        gameoverLabel.fontSize = 50
        gameoverLabel.fontName = "MarkerFelt-Wide"
        gameoverLabel.fontColor = UIColor.redColor()
        self.addChild(gameoverLabel)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        let RocketNode = contact.bodyA.categoryBitMask == rocketgroup ? contact.bodyA.node : contact.bodyB.node
        let objectNode = contact.bodyA.categoryBitMask == objectgroup ? contact.bodyA.node : contact.bodyB.node
        
        if Model.sharedInstance.score > Model.sharedInstance.highcore
        {
            Model.sharedInstance.highcore = Model.sharedInstance.score
        }
        
        NSUserDefaults.standardUserDefaults().setObject(Model.sharedInstance.highcore, forKey: "highScore")
        
        highscoreLabel2 = SKLabelNode()
        
        if contact.bodyA.categoryBitMask == objectgroup || contact.bodyB.categoryBitMask == objectgroup
        {
            hero.physicsBody?.velocity = CGVectorMake(0 , 0)
            
            
            
          
            
            
            
            if Model.sharedInstance.shieldBool == false
            {
                shakeAndFlashAnimation()
                
            
                
                // set highscore for Gamecenter
                
                if Model.sharedInstance.sound == true
                {
                runAction(ElectricDeadPreload) // sound
                }
                
                playerEmitterObject.removeAllChildren()
                emitterObject.removeAllChildren()
                
                Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                GameviewcontrollerBridge.saveHighscore()
                
                
          
                
                hero.physicsBody?.allowsRotation = false
                
                
             
                
                
                self.coinobject.removeAllChildren()
                self.redCoinObject.removeAllChildren()
                self.groundobject.removeAllChildren()
                self.shieldObject.removeAllChildren()
                self.movingObject.removeAllChildren()
                self.rocketObject.removeAllChildren()
                self.shieldItemObject.removeAllChildren()
                self.emitterObject.removeAllChildren()
                
                Model.sharedInstance.ShieldAddBool = false
                self.stopgame()
                
                TimerAddCoin.invalidate()
                TimerAddMine.invalidate()
                TimerAddElectriclighting.invalidate()
                TimerRoketAdd.invalidate()
                TimerRedCoinAdd.invalidate()
                TimerAddShieldItem.invalidate()
                
                HeroDeathTexturesArray = [SKTexture(imageNamed: "Dead0"),SKTexture(imageNamed: "Dead1"),SKTexture(imageNamed: "Dead2"),SKTexture(imageNamed: "Dead3"),SKTexture(imageNamed: "Dead4"),SKTexture(imageNamed: "Dead5"),SKTexture(imageNamed: "Dead6")]
                
                let herodDeathAnimation = SKAction.animateWithTextures(HeroDeathTexturesArray, timePerFrame: 0.2)
                
                
                hero.runAction(herodDeathAnimation)
                showhighscore()
                gameover = 1
                
                
                
                let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                    Int64(0.5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    
                    self.scene?.paused = true
                    
                    
                    if iAP_Enabled == true
                    {
                        self.GameviewcontrollerBridge.RemoveAdsBtn.hidden = false
                        self.GameviewcontrollerBridge.RestoreiAP.hidden = false
                    }
                    else
                    {
                        self.GameviewcontrollerBridge.RemoveAdsBtn.hidden = true
                        self.GameviewcontrollerBridge.RestoreiAP.hidden = true
                        
                    }
                    
                    self.heroobject.removeAllChildren()
                    self.showhighscoreLabelfunc()
                    
                    
                    if Model.sharedInstance.sound == true
                    {
                        self.GameviewcontrollerBridge.soundOnBtn.hidden = false // ses kapalı
                        self.GameviewcontrollerBridge.soundOffBtn.hidden = true
                        
                    }else
                        
                    {
                        self.GameviewcontrollerBridge.soundOffBtn.hidden = false
                        self.GameviewcontrollerBridge.soundOnBtn.hidden = true
                        
                    }
                    
                    self.GameviewcontrollerBridge.refreshGameBtn.hidden = false
                    self.GameviewcontrollerBridge.returnmainmenubutton.hidden = false
                    self.GameviewcontrollerBridge.pauseButton.hidden = true
                    self.GameviewcontrollerBridge.resumeButton.hidden = true
                    self.stageLabel.hidden = true
                  
                    
                    if Model.sharedInstance.score > Model.sharedInstance.highcore
                    {
                        Model.sharedInstance.highcore = Model.sharedInstance.score
                    }
                    self.highscoreLabel.hidden = false
                    self.highscoreLabel2.hidden = false
                    self.GameviewcontrollerBridge.ShareButton.hidden = false
                    self.highscoreLabel.text = "\(Model.sharedInstance.highcore)"
                    
                    
                    
                    Model.sharedInstance.ADCount = Model.sharedInstance.ADCount + 1
                    NSUserDefaults.standardUserDefaults().setObject(Model.sharedInstance.ADCount, forKey: "ADCount")
                    
                    
                        if Model.sharedInstance.ADCount >= Show_AdMobAd_TimePerFinishGame
                            
                        {
                            
                            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                Int64(1 * Double(NSEC_PER_SEC)))
                            dispatch_after(delayTime, dispatch_get_main_queue()) {
                                
                                if AdMob_Enabled == true
                                {
                                NSNotificationCenter.defaultCenter().postNotificationName("kDisplayInterstitialNotification", object: nil)
                                    
                                    Model.sharedInstance.ADCount = 0
                                    NSUserDefaults.standardUserDefaults().setObject(Model.sharedInstance.ADCount, forKey: "ADCount")
                                }
                                
                                
                                
                            }
                        }
                    
                    
                  
                    
                }
                
                
                SKTAudio.sharedInstance().pauseBackgroundMusic()
            }else
                
            {
                objectNode?.removeFromParent()
                
                shieldObject.removeAllChildren()
                Model.sharedInstance.shieldBool = false
                if Model.sharedInstance.sound == true
                    
                {
              runAction(ShieldOffPreload)
                }
            }
            
        }
        
        if contact.bodyA.categoryBitMask == rocketgroup || contact.bodyB.categoryBitMask == rocketgroup {
            hero.physicsBody?.velocity = CGVectorMake(0 , 0)
            
            
            if Model.sharedInstance.shieldBool == false
            {
                if  gameover == 0
                {
                    
                 
                    
                        shakeAndFlashAnimation()
                 
                    GameviewcontrollerBridge.saveHighscore()
                    if Model.sharedInstance.sound == true
                        
                    {
                 runAction(RocketExplosionPreload)
                    }
                    
                    Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                    
           
                    RocketExplodeTexturesArray = [SKTexture(imageNamed: "RocketExplode0"),SKTexture(imageNamed: "RocketExplode1"),SKTexture(imageNamed: "RocketExplode2"),SKTexture(imageNamed: "RocketExplode3"),SKTexture(imageNamed: "RocketExplode4"),SKTexture(imageNamed: "RocketExplode5"),SKTexture(imageNamed: "RocketExplode6")]
                    
                    let RocketExplodeAnimation = SKAction.animateWithTextures(RocketExplodeTexturesArray, timePerFrame: 0.1)
                    
                    let RocketExp = SKAction.repeatActionForever(RocketExplodeAnimation)
                    
                    
                    RocketNode?.runAction(RocketExp)
                    
                    
                    playerEmitterObject.removeAllChildren()
                    emitterObject.removeAllChildren()
                    
                    
                    
                    
                    
                    self.coinobject.removeAllChildren()
                    self.movingObject.removeAllChildren()
                    self.shieldItemObject.removeAllChildren()
                    
                    TimerAddCoin.invalidate()
                    TimerAddMine.invalidate()
                    TimerAddElectriclighting.invalidate()
                    TimerRoketAdd.invalidate()
                    TimerRedCoinAdd.invalidate()
                    TimerAddShieldItem.invalidate()// redCoin
                    
                    HeroDeathTexturesArray = [SKTexture(imageNamed: "Dead0"),SKTexture(imageNamed: "Dead1"),SKTexture(imageNamed: "Dead2"),SKTexture(imageNamed: "Dead3"),SKTexture(imageNamed: "Dead4"),SKTexture(imageNamed: "Dead5"),SKTexture(imageNamed: "Dead6")]
                    
                    let herodDeathAnimation = SKAction.animateWithTextures(HeroDeathTexturesArray, timePerFrame: 0.2)
                    
                    
                    hero.runAction(herodDeathAnimation)
                    
                    showhighscore()
                    gameover = 1
                    
                    
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                        Int64(0.5 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue()) {
                        
                        self.scene?.paused = true
                        if iAP_Enabled == true
                        {
                            self.GameviewcontrollerBridge.RemoveAdsBtn.hidden = false
                            self.GameviewcontrollerBridge.RestoreiAP.hidden = false
                        }
                        else
                        {
                            self.GameviewcontrollerBridge.RemoveAdsBtn.hidden = true
                            self.GameviewcontrollerBridge.RestoreiAP.hidden = true
                            
                            
                        }
                        self.heroobject.removeAllChildren()
                        self.showhighscoreLabelfunc()
                        
                        
                        
                        
                        
                        if Model.sharedInstance.sound == true
                        {
                            self.GameviewcontrollerBridge.soundOnBtn.hidden = false // ses kapalı
                            self.GameviewcontrollerBridge.soundOffBtn.hidden = true
                            
                        }else
                        {
                            self.GameviewcontrollerBridge.soundOffBtn.hidden = false
                            self.GameviewcontrollerBridge.soundOnBtn.hidden = true
                            
                        }
                        
                        self.GameviewcontrollerBridge.refreshGameBtn.hidden = false
                        self.GameviewcontrollerBridge.returnmainmenubutton.hidden = false
                        self.GameviewcontrollerBridge.pauseButton.hidden = true
                        self.GameviewcontrollerBridge.resumeButton.hidden = true
                        self.stageLabel.hidden = true
                        
                        
                        
                        if Model.sharedInstance.score > Model.sharedInstance.highcore
                        {
                            Model.sharedInstance.highcore = Model.sharedInstance.score
                        }
                        self.highscoreLabel.hidden = false
                        
                        
                        
                        
                        
                        self.highscoreLabel2.hidden = false
                        self.GameviewcontrollerBridge.ShareButton.hidden = false
                        self.highscoreLabel.text = "\(Model.sharedInstance.highcore)"
                        Model.sharedInstance.ShieldAddBool = false
                        
                        
                        self.stopgame()
                        
                     
                        
                        Model.sharedInstance.ADCount = Model.sharedInstance.ADCount + 1
                        NSUserDefaults.standardUserDefaults().setObject(Model.sharedInstance.ADCount, forKey: "ADCount")
                        
                        
                        
                        if Model.sharedInstance.ADCount >= Show_AdMobAd_TimePerFinishGame
                            
                        {
                            
                            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                Int64(1 * Double(NSEC_PER_SEC)))
                            dispatch_after(delayTime, dispatch_get_main_queue()) {
                                
                                if AdMob_Enabled == true
                                {
                                    NSNotificationCenter.defaultCenter().postNotificationName("kDisplayInterstitialNotification", object: nil)
                                    
                                    Model.sharedInstance.ADCount = 0
                                    NSUserDefaults.standardUserDefaults().setObject(Model.sharedInstance.ADCount, forKey: "ADCount")
                                }
                                
                                
                                
                            }
                        }

                        
                        
                    }
                 
                    
                    SKTAudio.sharedInstance().pauseBackgroundMusic()
                    
                    
                }
            }else
            {
                RocketNode?.removeFromParent()
                shieldObject.removeAllChildren()
                Model.sharedInstance.shieldBool = false
                if Model.sharedInstance.sound == true
                    
                {
                runAction(ShieldOffPreload)
                }
            }
            
            
            
        }
        
        
        
        
        
        if contact.bodyA.categoryBitMask == groundgroup || contact.bodyB.categoryBitMask == groundgroup {
            
            if  gameover == 0
            {
                
                playerEmitter1.hidden = true

                HeroRunTexturesArray = [SKTexture(imageNamed: "Run0"),SKTexture(imageNamed: "Run1"),SKTexture(imageNamed: "Run2"),SKTexture(imageNamed: "Run3"),SKTexture(imageNamed: "Run4"),SKTexture(imageNamed: "Run5"),SKTexture(imageNamed: "Run6")]
                
                let heroRunAnimation = SKAction.animateWithTextures(HeroRunTexturesArray, timePerFrame: 0.1)
                
                let HeroWalk = SKAction.repeatActionForever(heroRunAnimation)
                
                hero.runAction(HeroWalk)
            }
            
            
            
        }
        
        
        if contact.bodyA.categoryBitMask == shieldgroup || contact.bodyB.categoryBitMask == shieldgroup{
            LevelUp()
            let shieldNode = contact.bodyA.categoryBitMask == shieldgroup ? contact.bodyA.node : contact.bodyB.node
            
            if Model.sharedInstance.shieldBool == false {
                if Model.sharedInstance.sound == true
                    
                {
                runAction(PickCoinPreload)
                }
                
                shieldNode?.removeFromParent()
                addShield()
                Model.sharedInstance.shieldBool = true
            }
            
            
        }
        
        
        
        
        if contact.bodyA.categoryBitMask == coingroup || contact.bodyB.categoryBitMask == coingroup{
            LevelUp()
            let coinNode = contact.bodyA.categoryBitMask == coingroup ? contact.bodyA.node : contact.bodyB.node
            if Model.sharedInstance.sound == true
                
            {
            runAction(PickCoinPreload)
            }
         
            switch stageLabel.text!
            {
           
            case "Stage 1":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 1
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
                
                
            case "Stage 2":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                
            case "Stage 3":
                
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
                
            case "Stage 4":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                
            case "Stage 5":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 7
                }
                
            case "Stage 6":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 7
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
            case "Stage 7":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 7
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 9
                }
                
            case "Stage 8":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 9
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                
            case "Stage 9":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 9
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 11
                }
            case "Stage 10":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 11
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                
            default:
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 11
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                
            }
            scoreLabel.text = "\(Model.sharedInstance.score)"
            
            
            
            
            
            coinNode?.removeFromParent()
            
            
            
        }
        
        
        if contact.bodyA.categoryBitMask == redCoinGroup || contact.bodyB.categoryBitMask == redCoinGroup{
            LevelUp()
            let redCoinNode = contact.bodyA.categoryBitMask == redCoinGroup ? contact.bodyA.node : contact.bodyB.node
            if Model.sharedInstance.sound == true
                
            {
            runAction(PickCoinPreload)
            }
            
            switch stageLabel.text!
            {
                
            case "Stage 1":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                
                
            case "Stage 2":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                
            case "Stage 3":
                
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                
            case "Stage 4":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                
            case "Stage 5":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 14
                }
                
            case "Stage 6":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 14
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 16
                }
            case "Stage 7":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 14
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 16
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 18
                }
                
            case "Stage 8":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 16
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 18
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                
            case "Stage 9":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 18
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 22
                }
            case "Stage 10":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 22
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 24
                }
                
            default:
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 22
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 24
                }
                
                
                
            }
            
            scoreLabel.text = "\(Model.sharedInstance.score)"
            
            
            redCoinNode?.removeFromParent()
            
            
            
        }
        
        
        NSUserDefaults.standardUserDefaults().setObject(Model.sharedInstance.totalscore, forKey: "totalscore")
        
        
    }
    
    
    func shakeAndFlashAnimation() {
        
        let aView = UIView(frame: self.view!.frame)
        aView.backgroundColor = UIColor.whiteColor()
        self.view!.addSubview(aView)
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            aView.alpha = 0.0
            }, completion: { (done) -> Void in
                aView.removeFromSuperview()
        })
        
        //Shake animation
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( CATransform3D:CATransform3DMakeTranslation(-15, 5, 5 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation( 15, 5, 5 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 7/100
        
        self.view!.layer.addAnimation( anim, forKey:nil )
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
       playerEmitter1.hidden = false
        
        if gameover == 0 {
            
            if tabtoplayLabel.hidden == false
            {
                tabtoplayLabel.hidden = true
            }
            
            hero.physicsBody?.velocity = CGVectorMake(0 , 0)
            
            hero.physicsBody?.applyImpulse(CGVectorMake(0, 180))
        
            if  gameover == 0
            {
                
                HeroFlyTexturesArray = [SKTexture(imageNamed: "Fly0"),SKTexture(imageNamed: "Fly1"),SKTexture(imageNamed: "Fly2"),SKTexture(imageNamed: "Fly3"),SKTexture(imageNamed: "Fly4")]
                
                let HeroFlyAnimation = SKAction.animateWithTextures(HeroFlyTexturesArray, timePerFrame: 0.1)
                
                let flyhero = SKAction.repeatActionForever(HeroFlyAnimation)
                hero.runAction(flyhero)
            }
            
            
        }
        
        
        
    }
    
    override func didFinishUpdate() {
        playerEmitter1.position = hero.position - CGPoint(x: 30, y: 5)
        shield.position = hero.position + CGPoint(x: 40, y: 5)
        }
    
  
    
    
   
}
