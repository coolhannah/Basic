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
    var trophy = SKSpriteNode()
    
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
        
        let trophyTexture = textures.atlas.textureNamed("bronze.png")
        trophyTexture.filteringMode = .Nearest
        trophy = SKSpriteNode(texture: trophyTexture, size: CGSize(width: view.bounds.width/3, height: view.bounds.width/3))
        trophy.position = CGPoint(x: view.bounds.width * 5/7 , y: view.bounds.height * 4/7)
    
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
        
        let blue = SKSpriteNode(imageNamed: "sky")
        blue.position = bkgd.position
        blue.size = CGSize(width: view.bounds.width * 5, height: view.bounds.height * 5)
        
        self.addChild(blue)
        self.addChild(bkgd)
        self.addChild(label)
        self.addChild(highLabel)
        self.addChild(trophy)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.removeAllChildren()
        jump.jumps = 0
        transition()
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