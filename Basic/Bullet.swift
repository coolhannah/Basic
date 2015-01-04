//
//  Bullet.swift
//  Basic
//
//  Created by Aaron Chen on 1/2/15.
//  Copyright (c) 2015 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : SKSpriteNode {
    
    let text = textures.atlas.textureNamed("bullet")
    var action = SKAction()
    
     init(boy: Cowboy) {
        super.init(texture: text, color: nil, size: text.size())
        //add these to current position to get gun location
        let shootPoint = CGPoint(x: boy.position.x * 12/11, y: boy.position.y)
        self.size = CGSize(width: boy.size.width/12, height: boy.size.width/12)
        self.position = shootPoint
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width * 3, height: self.size.height * 3))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = GameScene.types.Bullet.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Bird.rawValue
        self.physicsBody?.collisionBitMask = GameScene.types.Bullet.rawValue
        action = SKAction.moveByX(boy.size.width * 11, y: 0.0, duration: 1.5)
    }
    
    func shoot() {
        self.runAction(action)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}