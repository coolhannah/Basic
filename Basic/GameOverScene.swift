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
    var highLabel = SKLabelNode()
    
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
    
        label.text = "your score: \(jump.jumps)"
        label.fontColor = UIColor.cyanColor()
        label.position = CGPoint(x: view.bounds.width/3, y: view.bounds.height * 2/3)
        
        highLabel.text = "high score: \(highScore)"
        highLabel.fontColor = UIColor.lightTextColor()
        highLabel.position = CGPoint(x: view.bounds.width/3, y: view.bounds.height/3)
        
        let gameOverBkgd = SKTexture(imageNamed: "gameOverBkgd")
        gameOverBkgd.filteringMode = .Nearest
        let bkgd = SKSpriteNode(texture: gameOverBkgd, size: view.bounds.size)
        bkgd.position = CGPoint(x: view.bounds.width / 2 , y: view.bounds.height/2)
        

        let sky = Sky(view: view)
        let ground = Ground(view: view)
        
        self.addChild(sky)
        self.addChild(ground)
        self.addChild(bkgd)
        self.addChild(label)
        self.addChild(highLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.removeAllChildren()
        jump.jumps = 0
        let quickNode = SKNode()
        self.addChild(quickNode)
        let waiting = SKTexture(imageNamed: "waiting")
        waiting.filteringMode = .Nearest
        let waits = SKSpriteNode(texture: waiting, size: viewer.bounds.size)
        waits.position = CGPoint(x: viewer.bounds.width/2, y: viewer.bounds.height/2)
        quickNode.addChild(waits)
        let trans = SKAction.runBlock({
                self.transition()
            })
        let wait = SKAction.waitForDuration(0.01)
        quickNode.runAction(SKAction.sequence([wait, trans]))
    }
    
    func transition() {
        
        let gameScene = GameScene(size: self.viewer.bounds.size)
        gameScene.scaleMode = .AspectFill
        
        // Configure the view that this class controls
        let skView = self.viewer as SKView
        skView.ignoresSiblingOrder = true
        
        var trans : SKTransition = SKTransition.fadeWithDuration(0.25)
        
        //display the game scene through our main view
        skView.presentScene(gameScene, transition: trans)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}