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
        let texture = SKTexture(imageNamed:"blueJay1")
        super.init(texture: texture, color: nil, size: texture.size())
        self.size = texture.size()
        self.xScale = 2.0
        self.yScale = 2.0
        offscrnPt = CGPoint(x: view.bounds.width * 9/8, y: view.bounds.height * 4/7 )
        self.position = offscrnPt
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width * 2/3)
        self.physicsBody?.categoryBitMask = GameScene.types.Bird.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Bullet.rawValue | GameScene.types.Hero.rawValue
        self.physicsBody?.collisionBitMask = GameScene.types.Bullet.rawValue | GameScene.types.Hero.rawValue
        self.physicsBody?.dynamic = true
        self.physicsBody?.affectedByGravity = false
        setUpFlappingAnim()
        self.runAction(flap)
    }
    
    func setUpFlappingAnim() {
        let txt1 = SKTexture(imageNamed:"blueJay1")
        let txt2 = SKTexture(imageNamed:"blueJay2")
        txt1.filteringMode = .Nearest
        txt2.filteringMode = .Nearest
        
        var arr: [SKTexture] = [txt1, txt2]
        let flapAnim = SKAction.animateWithTextures(arr, timePerFrame: 0.3)
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