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
    
    var cowRun = SKAction()
    var cowPos = CGPoint()
    
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
        
        cowPos = CGPoint(x: view.bounds.width/8, y: classVar.groundY * 3/2)
        let texture = SKTexture(imageNamed:"sprite_1")
        
        
        //superclass init
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.size = CGSize(width: view.bounds.width/12, height: view.bounds.width/12)
        self.position = cowPos
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width * 3/7)
        self.physicsBody?.mass = CGFloat(0.2)
        
        self.physicsBody?.categoryBitMask = GameScene.types.Hero.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Enemy.rawValue | GameScene.types.Bird.rawValue
        
        self.physicsBody?.collisionBitMask = GameScene.types.Ground.rawValue | GameScene.types.Enemy.rawValue
        self.physicsBody?.restitution = 0
        self.physicsBody?.dynamic = true
        setUpRunningAnim()
        self.runAction(cowRun)
        
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