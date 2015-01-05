//
//  Ground.swift
//  Basic
//
//  Created by Aaron Chen on 12/30/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class Ground : SKNode {
    
    let groundTexture = SKTexture(imageNamed: "Ground")
    
    let ground1 = SKSpriteNode(texture: textures.atlas.textureNamed( "Ground"))
    let ground2 = SKSpriteNode(texture: textures.atlas.textureNamed( "Ground"))
    
    var moveIt = SKAction()
    
    var positions = CGPoint()
    
    init(view: SKView) {
        super.init()
        groundTexture.filteringMode = .Nearest
        
        self.physicsBody =
            SKPhysicsBody(edgeFromPoint: CGPoint(x: -1000, y: classVar.groundY), toPoint: CGPoint(x:view.bounds.width * 3/2 , y: classVar.groundY))
        self.physicsBody?.categoryBitMask = GameScene.types.Ground.rawValue
        self.physicsBody?.collisionBitMask = GameScene.types.Hero.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Hero.rawValue
        //position based on center points
        positions = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        ground1.position = positions
        ground1.size = view.bounds.size
        ground2.position = CGPoint(x: positions.x * 3, y: positions.y)
        ground2.size = view.bounds.size
        
        let moveground = SKAction.moveByX(-view.bounds.width, y:0, duration: NSTimeInterval(1.2))
        let resetground = SKAction.moveByX(view.bounds.width, y:0, duration: 0.0)
        moveIt = SKAction.repeatActionForever(SKAction.sequence([moveground, resetground]))
    
        ground1.removeFromParent()
        ground2.removeFromParent()
        
        self.addChild(ground1)
        self.addChild(ground2)
        
        ground1.runAction(moveIt)
        ground2.runAction(moveIt)
        
    }
    
    func stop() {
        ground1.removeAllActions()
        ground2.removeAllActions()
    }
    func start() {
        ground1.position = positions
        ground2.position = CGPoint(x: positions.x * 3, y: positions.y)
        ground1.runAction(moveIt)
        ground2.runAction(moveIt)
    }
    
    override init() {
        super.init()
    }
    
    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
