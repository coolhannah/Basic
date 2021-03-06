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

    var offscrnPt = CGPoint()
    var viewWidth = CGFloat()
    
    override init() {
        super.init()
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(view: SKView) {
        let cacTxture = textures.atlas.textureNamed("cactus")
        cacTxture.filteringMode = .Nearest
        super.init(texture: cacTxture, color: nil, size: cacTxture.size())
        
        viewWidth = view.bounds.width
        self.size = CGSize( width: view.bounds.height/8, height: view.bounds.height/8 )
        offscrnPt = CGPoint(x: viewWidth, y: view.bounds.height / 3 + (self.size.height)/2)
        self.position = offscrnPt
        self.physicsBody = SKPhysicsBody(texture: cacTxture, size: self.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GameScene.types.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Hero.rawValue
    }
    
    func sendCactus() {
        self.position = offscrnPt
        self.runAction(SKAction.moveByX(-viewWidth - self.size.width/2, y: 0, duration: NSTimeInterval(1.2)))
    }
    
    
    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}