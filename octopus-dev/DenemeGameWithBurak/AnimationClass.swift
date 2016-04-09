//
//  AnimationClass.swift
//  DenemeGameWithBurak
//
//  Created by BURAK YILDIZ on 14.03.2015.
//  Copyright (c) 2015 emre esen. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class AnimationClass {
    
    
    
    
    var sprite1: SKSpriteNode!
    var animDuration1: NSTimeInterval!
    
    init(var sprite: SKSpriteNode!, var animDuration: NSTimeInterval!) {
        
        sprite = self.sprite1
        animDuration = self.animDuration1
        
        
    }
    
    init()
    {
    }
   
    
    
    ///////////////////ROTATE ANIMATIONS/////////////////////////////////
    
    func rotateAnimationsbyAngle (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Kedi
        // Hızlı Dönme Animasyonu(Soldan Sağa) Mayın için kullanılabilir.
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.rotateByAngle(π*5, duration: animDuration)))
        
    }
    
    func rotateAnimationsToAngle (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Köpek
        // Yön Değiştiren Dönme Animasyonu
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.rotateToAngle(π/2, duration: animDuration),
                SKAction.rotateToAngle(π, duration: animDuration),
                SKAction.rotateToAngle(-π/2, duration: animDuration),
                SKAction.rotateToAngle(π, duration: animDuration),
                ])
            ))
        
    }
    
    func rotateAnimationsToAngleShort (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Kaplumbağa
        // Yön Değiştiren Dönme Animasyonu
        
        // rotateToAngle(duration:shortestUnitArc:)
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.rotateToAngle(π/2, duration: animDuration, shortestUnitArc:true),
                SKAction.rotateToAngle(π, duration: animDuration, shortestUnitArc:true),
                SKAction.rotateToAngle(-π/2, duration: animDuration, shortestUnitArc:true),
                SKAction.rotateToAngle(π, duration: animDuration, shortestUnitArc:true),
                ])
            ))
    }
    
    
    
    //////////////////ROTATE ANIMATION END /////////////////////////
    
    
    
    
    ///////////////RESIZE ANIMATIONS///////////////////////
    
    
    func resizeByWidth (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Kedi
        // x Ekseninde size değişir
        
        
        // resizeByWidth(height:duration:)
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.resizeByWidth(sprite.size.width, height: -sprite.size.height/2, duration: animDuration),
                SKAction.resizeByWidth(-sprite.size.width, height: sprite.size.height/2, duration: animDuration)
                ])
            ))
    }
    
    
    func resizeHeight (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Köpek
        // Y ekseninde Size Değişir
        
        
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.resizeToWidth(10, height: 200, duration: animDuration),
                SKAction.resizeToWidth(sprite.size.width, height: sprite.size.height, duration: animDuration)
                ])
            ))
        
    }
    
    func resizeWidtHeight (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Kaplumbağa
        // X ve Y ekseninde size değişir
        
        
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.group([
                    SKAction.resizeToWidth(sprite.size.width*2, duration: animDuration),
                    SKAction.resizeToHeight(sprite.size.height/2, duration: animDuration)
                    ]),
                SKAction.group([
                    SKAction.resizeToWidth(sprite.size.width, duration: animDuration),
                    SKAction.resizeToHeight(sprite.size.height, duration: animDuration)
                    ])
                ])
            ))
        
    }
    
    
    ///////////////////RESIZE ANIMATIONS END//////////////////////////
    
    
    
    
    
    ////////////////SCALE ANIMATIONS //////////////////////
    
    
    func scaleZdirection (sprite: SKSpriteNode)  {
        
        //Kedi
        // Ekranın içinden dışa doğru büyür
        
        
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.scaleBy(2.0, duration: 0.5),
              //  SKAction.scaleBy(2.0, duration: 0.5), // now effectively at 4x
                SKAction.scaleTo(1.0, duration: 1.0),
                ])
            ))
        
    }
    
    func scaleYdirection (sprite: SKSpriteNode)  {
        
        //Köpek
        // X Ekseninde İçe Doğru İncelme
        
        
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.scaleXBy(0.25, y:1.25, duration:0.5),
                SKAction.scaleXBy(0.25, y:1.25, duration:0.5), // now effectively xScale 0.0625, yScale 1.565
                SKAction.scaleXTo(1.0, y:1.0, duration:1.0),
                ])
            ))
        
    }
    
    func scaleXdirection (sprite: SKSpriteNode)  {
        
        //Köpek
        // Enine uzama
        
        
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.group([
                    SKAction.scaleXTo(3.0, duration:1.0),
                    SKAction.scaleYTo(0.5, duration:1.0)
                    ]),
                SKAction.group([
                    SKAction.scaleXTo(1.0, duration:1.0),
                    SKAction.scaleYTo(1.0, duration:1.0)
                    ])
                ])
            ))
    }
    
    
    ///////////////// SCALE ANIMATIONS END////////////////
    
    
    
    ////////////////// COLOR ANIMATIONS ////////////////
    
    
    
    func redColorAnimation (sprite: SKSpriteNode, animDuration: NSTimeInterval)  {
        
        //Kaplumbağa
        // X ve Y ekseninde size değişir
        
        
        sprite.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: animDuration),
                SKAction.colorizeWithColorBlendFactor(0.0, duration: animDuration)
                ])
            ))
        
    }
    
    
    
    
    
    
}