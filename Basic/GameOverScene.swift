//
//  GameOverScene.swift
//  Basic
//
//  Created by Aaron Chen on 12/31/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene : SKScene {
    
    var viewer = SKView()
    var label = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        viewer = view
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if(userDefaults.objectForKey("user") == nil) {
            userDefaults.setValue(jump.jumps, forKey: "user")
            userDefaults.synchronize()
        }
        else {
            let highScore = userDefaults.integerForKey("user")
            if(highScore < jump.jumps) {
                userDefaults.setValue(jump.jumps, forKey: "user")
                userDefaults.synchronize()
            }
        }
        
        let highScore = userDefaults.integerForKey("user")
        
        if(jump.jumps == 1) {
            label.text = "\(jump.jumps) jump! High Score: \(highScore) "
        }
        else {
        label.text = "\(jump.jumps) jumps! High Score: \(highScore) "
        }
        label.fontColor = UIColor.whiteColor()
        label.fontName = "Comic Sans"
        label.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        self.addChild(label)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        jump.jumps = 0
        let gameScene = GameScene(size: viewer.bounds.size)
        gameScene.scaleMode = .AspectFill
        
        // Configure the view that this class controls
        let skView = self.viewer as SKView
        skView.ignoresSiblingOrder = true

        var trans : SKTransition = SKTransition.fadeWithDuration(0.5)
        
        //display the game scene through our main view
        skView.presentScene(gameScene, transition: trans)
    }
    
    override func update(currentTime: NSTimeInterval) {
    
    }
    
}