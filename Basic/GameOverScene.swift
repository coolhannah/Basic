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
    
    var sky = Sky()
    var viewer = SKView()
    var label = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        viewer = view
        
        sky = Sky(view: view)
        label.text = "You died! Tap to Replay"
        label.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        self.addChild(label)
        self.addChild(sky)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //initialize the scene to fill screen
        let scene = GameScene(size: self.viewer.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Configure the view that this class controls
        let skView = self.viewer as SKView
        skView.ignoresSiblingOrder = true

        var trans : SKTransition = SKTransition.fadeWithDuration(0.5)
        
        //display the game scene through our main view
        skView.presentScene(scene, transition: trans)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
    
    }
    
}