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

    var cont : Bool = false
    var ready : Bool = false
    var stop : Bool = false
    var replay : Bool = false
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
        
        if(contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2)
        {
            stop = true
            
            //let cowboySprite fly away
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 100.0))
            cowboySprite.removeAllActions()
            cont = false
            
            //reset bkgd
            sky.stop()
            ground.stop()
            gameOver()
        }
        else
        {
            //ground contact
            cont = true
        }
        
    }
    
    //touched screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(cont && ready && !stop) {
            cont = false;
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 70.0))
            label.removeFromParent()
        }
        if(!ready) {
            label.text = "Go!"
            ready = true
        }
        if(replay) {
            stop = false
            cont = true
            self.addChild(cowboySprite)
            self.addChild(ground)
            self.addChild(sky)
            cowboySprite.resetCowboy()
            ground.start()
            sky.start()
            
            replay = false
        }
    }
    
    var lastCactus : Double = 0.0
    
    
    override func update(currentTime: CFTimeInterval) {
        if(currentTime * 100000000 % 2 == 0 && !stop && ready && currentTime - lastCactus > 1.0) {
            var newCactus = Cactus(view: view!)
            newCactus.sendCactus()
            self.addChild(newCactus)
            lastCactus = currentTime
        }
    }
    
    func gameOver() {
        label.text = "Replay?"
        if(label.parent == nil) {
        self.addChild(label)
        }
        replay = true
        self.removeAllChildren()
        //go to game over scene
        
    }
    
    
    
    
    
    
    
}
