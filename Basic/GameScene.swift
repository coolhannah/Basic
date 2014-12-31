//
//  GameScene.swift
//  Basic
//
//  Created by Family on 12/24/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum types : UInt32 {
        case None = 0
        case Hero = 1
        case Enemy = 2
    }

    var canJump : Bool = false //
    var readyToBegin : Bool = false
    var gameIsOver : Bool = false
    var tappedReplay : Bool = false
    
    var label = SKLabelNode()
    
    var cowboySprite = Cowboy()
    
    var sky = Sky()
    var ground = Ground()
    
    let wait = SKAction.waitForDuration(NSTimeInterval(3.0))
    
    override func didMoveToView(view: SKView) {
        
        //physics of world
        self.physicsWorld.gravity.dy = CGFloat(-5)
        self.physicsWorld.contactDelegate  = self
        
        //generate background
        sky = Sky(view: view); self.addChild(sky)
        ground = Ground(view: view); self.addChild(ground)
        
        //generate player
        cowboySprite = Cowboy(view: view)
        self.addChild(cowboySprite)
        
        label = SKLabelNode(text: "Ready?")
        label.fontSize = CGFloat(64)
        label.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        self.addChild(label)

    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //game over, you died!
        if(contact.bodyA.categoryBitMask == 1 || contact.bodyA.categoryBitMask == 2)
        {
            gameIsOver = true
            
            //let cowboySprite fly away
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 20.0, dy: 200.0))
            cowboySprite.removeAllActions()
            canJump = false
            
            //reset bkgd
            sky.stop()
            ground.stop()
            gameOver()
        }
        else
        {
            //ground contact
            canJump = true
        }
        
    }
    
    //touched screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //reading in a jump
        if(canJump && readyToBegin && !gameIsOver) {
            canJump = false;
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 70.0))
            label.removeFromParent()
        }
        
        //reading in a response to begin game
        if(!readyToBegin) {
            label.text = "Go!"
            readyToBegin = true
        }
        
        //user wants to replay
        if(tappedReplay) {
            gameIsOver = false
            canJump = true

            cowboySprite.resetCowboy()
            ground.start()
            sky.start()
            
            self.addChild(cowboySprite)
            self.addChild(ground)
            self.addChild(sky)
            
            tappedReplay = false
        }
    }
    
    var lastCactus : Double = 0.0
    
    
    override func update(currentTime: CFTimeInterval) {
        //spawning a new cactus
        if(currentTime * 100000000 % 2 == 0 && !gameIsOver && readyToBegin && currentTime - lastCactus > 1.0) {
            var newCactus = Cactus(view: view!)
            newCactus.sendCactus()
            self.addChild(newCactus)
            lastCactus = currentTime
        }
    }
    
    //destroy scene
    func gameOver() {
        tappedReplay = true
        self.removeAllChildren()
        //go to game over scene
        
    }
    
    
    
    
    
    
    
}
