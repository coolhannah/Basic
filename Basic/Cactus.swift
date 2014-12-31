//
//  Cactus.swift
//  Basic
//
//  Created by Aaron Chen on 12/30/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class Cactus : SKSpriteNode {
    
    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var offscrnPt = CGPoint()
    var viewWidth = CGFloat()
    
    override init() {
        super.init()
    }
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(view: SKView) {
        let cacTxture = SKTexture(imageNamed: "cactus")
        super.init(texture: cacTxture, color: nil, size: cacTxture.size())
        
        viewWidth = view.bounds.width
        self.size = CGSize( width: view.bounds.height/7, height: view.bounds.height/7 )
        offscrnPt = CGPoint(x: viewWidth * 9/8, y: view.bounds.height / 3 + (self.size.height - 5 )/2)
        self.position = offscrnPt
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width/2, height: self.size.height * 2/3))
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GameScene.types.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Hero.rawValue
        self.physicsBody?.collisionBitMask = GameScene.types.Hero.rawValue
    }
    
    func sendCactus() {
        self.position = offscrnPt
        self.removeAllActions()
        self.runAction(SKAction.moveByX(-viewWidth * 5/4, y: 0, duration: NSTimeInterval(2.5)))
    }
    
}