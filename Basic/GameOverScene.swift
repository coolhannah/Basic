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
        label.fontColor = UIColor.whiteColor()
        label.position = CGPoint(x: view.bounds.width/3, y: view.bounds.height * 2/3)
        
        highLabel.text = "high score: \(highScore)"
        highLabel.fontColor = UIColor.lightTextColor()
        highLabel.position = CGPoint(x: view.bounds.width/3, y: view.bounds.height/3)
        
        let gameOverBkgd = SKTexture(imageNamed: "gameOverBkgd")
        gameOverBkgd.filteringMode = .Nearest
        let bkgd = SKSpriteNode(texture: gameOverBkgd, size: view.bounds.size)
        bkgd.position = CGPoint(x: view.bounds.width / 2 , y: view.bounds.height/2)
        
        let blue = SKSpriteNode(imageNamed: "blue")
        blue.position = bkgd.position
        blue.size = view.bounds.size
        self.addChild(blue)
        self.addChild(bkgd)
        self.addChild(label)
        self.addChild(highLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.removeAllChildren()
        jump.jumps = 0
        transition()
        let quickNode = SKNode()
        self.addChild(quickNode)
        
        let hopper = SKTexture(imageNamed: "TordyHopper")
        hopper.filteringMode = .Nearest
        
        let hopText = SKSpriteNode(texture: hopper, size: CGSize(width: viewer.bounds.width/2, height: viewer.bounds.height/2))
        hopText.position = CGPoint(x: viewer.bounds.width/2, y: viewer.bounds.height/2)
        hopText.zPosition = 1
        
        let bkgd = SKSpriteNode(imageNamed: "blue")
        bkgd.position = hopText.position
        bkgd.size = viewer.bounds.size
        bkgd.zPosition = 0
        
        quickNode.addChild(bkgd)
        quickNode.addChild(hopText)
        
        let trans = SKAction.runBlock({
                self.transition()
            })
        let wait = SKAction.waitForDuration(0.1)
        
        quickNode.runAction(SKAction.sequence([wait, trans]))
    }
    
    func transition() {
        
        let gameScene = GameScene(size: self.viewer.bounds.size)
        gameScene.scaleMode = .AspectFill
        
        // Configure the view that this class controls
        let skView = self.viewer as SKView
        
        var trans = SKTransition.crossFadeWithDuration(0.5)
        //display the game scene through our main view
        skView.presentScene(gameScene, transition: trans)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}