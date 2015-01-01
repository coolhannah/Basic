//
//  Bird.swift
//  Basic
//
//  Created by Aaron Chen on 1/1/15.
//  Copyright (c) 2015 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class Bird : SKSpriteNode {
    
    var flap = SKAction()
    let offscrnPt = CGPoint()
    
    init(view: SKView) {
        let texture = SKTexture(imageNamed: "blueJay1")
        super.init(texture: texture, color: nil, size: texture.size())
        self.size = CGSize(width: view.bounds.width/12, height: view.bounds.width/12)
        offscrnPt = CGPoint(x: view.bounds.width * 9/8, y: view.bounds.height / 3 + self.size.height)
        self.position = offscrnPt
        let size = CGSize(width: self.size.width * 2/3, height: self.size.height)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        
        self.physicsBody?.categoryBitMask = GameScene.types.Bird.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Hero.rawValue
        self.physicsBody?.collisionBitMask = GameScene.types.Bullet.rawValue | GameScene.types.Hero.rawValue
        self.physicsBody?.dynamic = false
        setUpFlappingAnim()
        self.runAction(flap)
    }
    
    func setUpFlappingAnim() {
        var arr: [SKTexture] = [SKTexture(imageNamed: "blueJay1"), SKTexture(imageNamed: "blueJay2")]
        let flapAnim = SKAction.animateWithTextures(arr, timePerFrame: 0.5)
        flap = SKAction.repeatActionForever(flapAnim)
    }
    
    func sendBird() {
        self.position = offscrnPt
        self.runAction(SKAction.moveByX(-self.size.width * 12 * 5/4, y: 0, duration: NSTimeInterval(4)))
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}