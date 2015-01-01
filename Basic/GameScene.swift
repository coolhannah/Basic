//
//  GameScene.swift
//  Basic
//
//  Created by Family on 12/24/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//
import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum types : UInt32 {
        case None = 0
        case Hero = 1
        case Enemy = 2
    }

    var canJump : Bool = false
    var readyToBegin : Bool = false
    var gameIsOver : Bool = false
    
    var label = SKLabelNode()
    
    var cowboySprite = Cowboy()
    var enemyNode = SKNode()
    
    var sky = Sky()
    var ground = Ground()
    
    let wait = SKAction.waitForDuration(NSTimeInterval(1.0))
    
    override func didMoveToView(view: SKView) {
        canJump = false
        readyToBegin = false
        gameIsOver = false
        
        //physics of world
        self.physicsWorld.gravity.dy = CGFloat(-9.8)
        self.physicsWorld.contactDelegate  = self
        
        //generate background
        sky = Sky(view: view);
        ground = Ground(view: view);
        
        //generate player
        cowboySprite = Cowboy(view: view)
        
        label = SKLabelNode(text: "Ready?")
        label.fontSize = CGFloat(64)
        label.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        self.removeAllChildren()
        if(sky.parent == nil) {
        self.addChild(sky)
        }
        if(ground.parent == nil) {
        self.addChild(ground)
        }
        if(cowboySprite.parent == nil) {
        self.addChild(cowboySprite)
        }
        if(label.parent == nil) {
        self.addChild(label)
        }
        if(enemyNode.parent == nil) {
        self.addChild(enemyNode)
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        //game over, you died!
        if(contact.bodyA.categoryBitMask == 1 || contact.bodyA.categoryBitMask == 2)
        {
            gameIsOver = true
            
            //let cowboySprite fly away
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: -5.0, dy: 100.0))
            cowboySprite.physicsBody?.applyAngularImpulse(CGFloat(0.09))
            cowboySprite.removeAllActions()
            canJump = false
            
            //reset bkgd
            sky.stop()
            ground.stop()
            
            let block = SKAction.runBlock({
                self.gameOver()
                }
            )
            self.runAction(SKAction.sequence([wait, block]))
            
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
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 90.0))
        }
        
        //reading in a response to begin game
        if(!readyToBegin) {
            var setGo = SKAction.runBlock(  {
                    self.label.text = "Go!"
                    self.label.runAction(SKAction.waitForDuration(2))
                }
            )
            label.runAction(setGo)
            label.removeFromParent()
            
            readyToBegin = true
        }
        
        
    }
    
    var lastCactus : Double = 0.0
    
    
    override func update(currentTime: CFTimeInterval) {
        var randomNum = Int(arc4random_uniform(4))
        
        //spawning a new cactus
        if(!gameIsOver && readyToBegin && currentTime - lastCactus > 0.65 && randomNum == 1) {
            var newCactus = Cactus(view: view!)
            newCactus.sendCactus()
            enemyNode.addChild(newCactus)
            lastCactus = currentTime
        }
        if(gameIsOver) {
            var cacti = enemyNode.children
            for anyCactus in cacti {
                anyCactus.removeAllActions()
            }
        }
        
    }
    
    //destroy scene
    func gameOver() {
        self.removeAllChildren()
        //go to game over scene
        let overScene = GameOverScene(size: view!.bounds.size)
        overScene.scaleMode = .AspectFill
        var trans = SKTransition.fadeWithDuration(0.5)
        
        self.view!.presentScene(overScene, transition: trans )
    }
    
    
    
    
    
    
    
}
