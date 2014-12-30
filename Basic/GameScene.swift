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
    let cowboySprite = SKSpriteNode(imageNamed: "cowboy")
    var boyPos = CGPoint()
    
    let bkgdSprite = SKSpriteNode(imageNamed: "background")
    let bkgdSprite2 = SKSpriteNode(imageNamed: "background")
    
    let groundNode = SKNode()
    let backgroundNode = SKNode()
    
    let cactusSprite = SKSpriteNode(imageNamed: "cactus")
    var moveCactus = SKAction()
    var offscreenPoint = CGPoint()
    
    var newEnemy : Bool = true
    
    override func didMoveToView(view: SKView) {
        
        //generate background moving
        generateBkgd(view)
        self.addChild(backgroundNode)
        
        //add main nodes
        self.addChild(groundNode)
        self.addChild(cowboySprite)
        
        //ground node: add physics of the scene and ground
        self.physicsWorld.gravity.dy = -4
        self.physicsWorld.contactDelegate  = self
        
        let groundY = CGFloat(view.bounds.height/3)
        groundNode.physicsBody =
            SKPhysicsBody(edgeFromPoint: CGPoint(x: -1000, y: groundY), toPoint: CGPoint(x:view.bounds.width * 3/2 , y: groundY))
        groundNode.physicsBody?.dynamic = false
        
        //display cowboy
        boyPos = CGPoint(x: view.bounds.width/8, y: groundY * 5/4)
        cowboySprite.position = boyPos
        cowboySprite.xScale = 1/20
        cowboySprite.yScale = 1/20
        cowboySprite.physicsBody = SKPhysicsBody(rectangleOfSize: cowboySprite.size)
        cowboySprite.physicsBody?.dynamic = true
        cowboySprite.physicsBody?.categoryBitMask = types.Hero.rawValue
        cowboySprite.physicsBody?.contactTestBitMask = types.Enemy.rawValue
        cowboySprite.physicsBody?.collisionBitMask = types.Enemy.rawValue
        runForever()
        
        //add obstacles
        self.addChild(cactusSprite)

        offscreenPoint = CGPoint(x: view.bounds.width * 9/8, y: groundY + 10)
        cactusSprite.size = CGSize( width: cowboySprite.size.width , height: cowboySprite.size.height)
        cactusSprite.physicsBody =
            SKPhysicsBody(rectangleOfSize: CGSize(width: cactusSprite.size.width/2, height: cactusSprite.size.height))
        cactusSprite.physicsBody?.dynamic = true
        cactusSprite.physicsBody?.categoryBitMask = types.Enemy.rawValue
        cactusSprite.physicsBody?.contactTestBitMask = types.Hero.rawValue
        cactusSprite.physicsBody?.collisionBitMask = types.Hero.rawValue
        genCactus()
    }
    
    func genCactus() {
        cactusSprite.position = offscreenPoint
        cactusSprite.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        cactusSprite.physicsBody?.applyImpulse(CGVector(dx: -15.0, dy: 0))
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        if(contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2) {
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
            cowboySprite.position = boyPos
            cowboySprite.removeAllActions()
            bkgdSprite.removeAllActions()
            bkgdSprite2.removeAllActions()
        }
     
    }
    
    
    func generateBkgd(view: SKView) {
        //note: CGPoint is based on center point
        
        //first sprite (on screen)
        bkgdSprite.position = CGPointMake(view.bounds.width/2, view.bounds.height/2)
        bkgdSprite.size = view.bounds.size
        //second sprite (off screen)
        bkgdSprite2.position = CGPointMake(view.bounds.width * 1.5, view.bounds.height/2)
        bkgdSprite2.size = view.bounds.size
        
        //animates sprite backward by a length of screen size. Scales well because time is based on screen size.
        let moveGroundSprite = SKAction.moveByX(-view.bounds.width, y: 0, duration: NSTimeInterval(view.bounds.width/300))
        //moves the sprite back to original position
        let resetGroundSprite = SKAction.moveByX(view.bounds.width, y: 0, duration: 0.0)
        
        //animate
        bkgdSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite])))
        bkgdSprite2.runAction(SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite])))
        backgroundNode.addChild(bkgdSprite)
        backgroundNode.addChild(bkgdSprite2)
        
    }

    func runForever()
    {
        var arr: [SKTexture] = Array<SKTexture>()
        for var i: Int = 1; i <= 8; ++i {
            arr.append(SKTexture(imageNamed: "sprite_\(i)"))
            arr[i-1].filteringMode = .Nearest
        }
        let heroAnim = SKAction.animateWithTextures(arr, timePerFrame: 0.06)
        
        var run = SKAction.repeatActionForever(heroAnim)
        cowboySprite.runAction(run)
    }
    
    var lastTime : Double = 0.0
    var cont : Bool = Bool()
    
    //touched screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(cont) {
            cont = false;
            cowboySprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 15.0))
       //   cowboySprite.runAction(SKAction.moveToY(cowboySprite.position.y + cowboySprite.size.height*2, duration: 0.15))
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(currentTime - lastTime > 1.5) {
            cont = true
            lastTime = currentTime
        }
        if(cactusSprite.position.x < 0) {
            genCactus()
        }
    }
}
