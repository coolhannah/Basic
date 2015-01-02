//
//  Cowboy.swift
//  Basic
//
//  Created by Aaron Chen on 12/29/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class Cowboy : SKSpriteNode {
    
    var cowPos = CGPoint()
    var groundY = CGFloat()
    var cowRun = SKAction()
    let bulletNode = SKNode()
    
    
    override init() {
        //do nothing
        super.init()
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    //initializer
    init(view: SKView) {
        let atlas = textures.atlas
        
        //variables
        groundY = CGFloat( view.bounds.height/3 )
        cowPos = CGPoint(x: view.bounds.width/8, y: groundY * 5/4)
        let texture = SKTexture(imageNamed:"sprite_1")
        
        
        //superclass init
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.size = CGSize(width: view.bounds.width/12, height: view.bounds.width/12)
        self.position = cowPos
        let size = CGSize(width: self.size.width * 2/3, height: self.size.height)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.mass = CGFloat(0.2)
        
        self.physicsBody?.categoryBitMask = GameScene.types.Hero.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Enemy.rawValue | GameScene.types.Bird.rawValue
        
        self.physicsBody?.collisionBitMask = GameScene.types.Ground.rawValue
        self.physicsBody?.dynamic = true
        setUpRunningAnim()
        self.runAction(cowRun)
        
        //Add bulletNode
        self.addChild(bulletNode)
        
    }
    
    func shoot() {
         //add these to current position to get gun location
        let shootPoint = CGPoint(x: self.position.x/100, y: self.position.y/100)
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.size = CGSize(width: self.size.width/12, height: self.size.width/12)
        bullet.position = shootPoint
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bullet.size.width, height: bullet.size.width))
        bullet.physicsBody?.dynamic = true
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = GameScene.types.Bullet.rawValue
        bullet.physicsBody?.contactTestBitMask = GameScene.types.Bird.rawValue
        bullet.physicsBody?.collisionBitMask = GameScene.types.Bird.rawValue
        bullet.runAction(SKAction.moveByX(self.size.width*13, y: 0.0, duration: 1))
        bulletNode.addChild(bullet)
    }
    
    
    func setUpRunningAnim()
    {
        var arr: [SKTexture] = Array<SKTexture>()
        for var i: Int = 1; i <= 8; ++i {
            arr.append(SKTexture(imageNamed:"sprite_\(i)"))
            arr[i-1].filteringMode = .Nearest
        }
        let heroAnim = SKAction.animateWithTextures(arr, timePerFrame: 0.06)
    
        cowRun = SKAction.repeatActionForever(heroAnim)
    }
    
    func resetCowboy() {
        self.position = cowPos
        self.runAction(cowRun)
    }

    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}