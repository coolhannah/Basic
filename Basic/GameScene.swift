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
    
    var cont : Bool = Bool()
    
    var cowboySprite = Cowboy()
    var cactusSprite = Cactus()
    
    var sky = Sky()
    var ground = Ground()
    
    let waitForSecond = SKAction.waitForDuration(NSTimeInterval(1.0))
    
    override func didMoveToView(view: SKView) {
        
        //physics of world
        self.physicsWorld.gravity.dy = -4
        self.physicsWorld.contactDelegate  = self
        
        //generate background
        sky = Sky(view: view); self.addChild(sky)
        ground = Ground(view: view); self.addChild(ground)
        
        //generate players
        cowboySprite = Cowboy(view: view)
        cactusSprite = Cactus(view: view)
        
        //add players to scene
        self.addChild(cowboySprite)
        self.addChild(cactusSprite)
        
        var label = SKLabelNode(text: "Ready?")
        label.fontSize = CGFloat(64)
        label.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        self.addChild(label)
        var sendCactus : SKAction = SKAction.runBlock({
            label.removeFromParent()
            self.cactusSprite.sendCactus()
        })
        cactusSprite.runAction(SKAction.sequence([ SKAction.waitForDuration(NSTimeInterval(5.0)) , sendCactus]))
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if(contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2)
        {
            
            //let cowboySprite fly away
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 100.0))
            cowboySprite.removeAllActions()
            cont = false
            
            //reset bkgd
            sky.stop()
            ground.stop()
            
            //kill cactus
            cactusSprite.removeAllActions()
        }
        else
        {
            //ground contact
            cont = true
        }
        
    }
    
    //touched screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(cont) {
            cont = false;
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 60.0))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if(cactusSprite.position.x < 0) {
            var sendCactus : SKAction = SKAction.runBlock({
                self.cactusSprite.sendCactus()
            })
            cactusSprite.runAction(SKAction.sequence([waitForSecond, sendCactus]))
        }
    }
}
