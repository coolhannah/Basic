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
    
    //collision enumeration
    enum types : UInt32 {
        case Ground = 1
        case Hero = 2
        case Enemy = 4
        case Bullet = 8
        case Bird = 16
    }

    //booleans that handle jump and game over
    var canJump : Bool = false
    var readyToBegin : Bool = false
    var gameIsOver : Bool = false
    var addJump : Bool = false
    
    //labels
    var label = SKLabelNode()
    var jumpCounter = SKLabelNode()
    
    //handle "players"
    var cowboySprite = Cowboy()
    let cactusNode = SKNode()
    let birdNode = SKNode()
    
    //background
    var sky = Sky()
    var ground = Ground()
    
    //utility time-wait duration
    let wait = SKAction.waitForDuration(NSTimeInterval(1.0))
    
    
    override func didMoveToView(view: SKView) {
        
        //reset booleans
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
        
        //configure labels
        label = SKLabelNode(text: "Ready?")
        label.fontName = "Comic Sans"
        label.fontColor = UIColor.blackColor()
        label.fontSize = CGFloat(64)
        label.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        jumpCounter = SKLabelNode(text: "0")
        jumpCounter.fontName = "Comic Sans"
        jumpCounter.fontColor = UIColor.blackColor()
        jumpCounter.position = CGPoint(x: view.bounds.width * 8/9, y: view.bounds.height * 8/9)
        
        //add nodes to scene
        self.addChild(sky)
        self.addChild(ground)
        self.addChild(cowboySprite)
        self.addChild(label)
        self.addChild(cactusNode)
        self.addChild(birdNode)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var categoryA = contact.bodyA.categoryBitMask
        var categoryB = contact.bodyB.categoryBitMask
        
        println(categoryA.description + " " + categoryB.description)
        
        //player death
        if(categoryA == 2 && (categoryB == 16 || categoryB == 4))
        {
            gameIsOver = true
            canJump = false
            
            //let cowboySprite fly away
            cowboySprite.removeAllActions()
            cowboySprite.physicsBody?.dynamic = false
            var popUp = SKAction.moveByX(0, y: self.size.height/4, duration: 0.5)
            var falldown = SKAction.moveByX(0, y: -self.size.height, duration: 0.5)
            cowboySprite.runAction(SKAction.sequence([popUp, falldown]))
            //reset bkgd
            sky.stop()
            ground.stop()
            
            //wait a bit before game-over
            let block = SKAction.runBlock({
                self.gameOver()
                }
            )
            self.runAction(SKAction.sequence([wait, block]))
            
        }
        //collision with bullet
        else if(categoryB == 8 && categoryA == 16) {
            contact.bodyA.node?.removeFromParent()
        }
        //collision with ground
        else if((categoryA == 1 && categoryB == 2) || (categoryB == 1 && categoryA == 2))
        {
            canJump = true
        }
        
    }
    
    //touched screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var touchLocation = touches.anyObject()?.locationInView(self.view!)
        
        
        //reading in a jump
        if(canJump && readyToBegin && !gameIsOver && touchLocation?.x < self.view!.bounds.width/2) {
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 100.0))
            canJump = false;
            addJump = true
            jump.jumps++
        }
        if(!gameIsOver && readyToBegin && touchLocation?.x > self.view!.bounds.width/2) {
            cowboySprite.shoot()
        }
        
        //ready to begin!   
        if(!readyToBegin) {
            label.removeFromParent()
            self.addChild(jumpCounter)
            readyToBegin = true
        }
        
        
    }
    
    //last time the cactus was spawned
    var lastCactus : Double = 0.0
    
    override func update(currentTime: CFTimeInterval) {
        
        var randomNum = Int(arc4random_uniform(8))
        
        //spawning a new cactus
        if(!gameIsOver && readyToBegin && currentTime - lastCactus > 0.65) {
            if(randomNum == 1) {
            var newCactus = Cactus(view: view!)
            newCactus.sendCactus()
            cactusNode.addChild(newCactus)
            lastCactus = currentTime
            }
            if(randomNum == 2) {
            let newBird = Bird(view: view!)
            newBird.sendBird()
            cactusNode.addChild(newBird)
            }
        }
        
        //stop cacti if game is over
        if(gameIsOver) {
            var cacti = cactusNode.children
            for anyCactus in cacti {
                anyCactus.removeAllActions()
            }
        }
        
        //change jump counter
        if(addJump) {
            jumpCounter.text = "\(jump.jumps)"
            addJump = false
        }
        
    }
    
    
    func gameOver() {
        
        //destroy scene
        self.removeAllChildren()
        //go to game over scene
        let overScene = GameOverScene(size: view!.bounds.size)
        overScene.scaleMode = .AspectFill
        var trans = SKTransition.fadeWithDuration(0.5)
        
        self.view!.presentScene(overScene, transition: trans )
    }
    
    
    
    
    
    
    
}
