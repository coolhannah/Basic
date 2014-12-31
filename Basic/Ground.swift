//
//  Ground.swift
//  Basic
//
//  Created by Aaron Chen on 12/30/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

let groundTexture = SKTexture(imageNamed: "Ground")

let ground1 = SKSpriteNode(texture: groundTexture)
let ground2 = SKSpriteNode(texture: groundTexture)

class Ground : SKNode {
    
    init(view: SKView) {
        super.init()
        groundTexture.filteringMode = .Nearest
        let groundY = CGFloat(view.bounds.height/3)
        
        self.physicsBody =
            SKPhysicsBody(edgeFromPoint: CGPoint(x: -1000, y: groundY), toPoint: CGPoint(x:view.bounds.width * 3/2 , y: groundY))
        self.physicsBody?.dynamic = false
        
        //position based on center points
        ground1.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        ground1.size = view.bounds.size
        ground2.position = CGPoint(x: view.bounds.width * 1.5, y: view.bounds.height/2)
        ground2.size = view.bounds.size
        
        let moveground = SKAction.moveByX(-view.bounds.width, y:0, duration: NSTimeInterval(1))
        let resetground = SKAction.moveByX(view.bounds.width, y:0, duration: 0.0)
        
        ground1.runAction(SKAction.repeatActionForever(SKAction.sequence([moveground, resetground])))
        ground2.runAction(SKAction.repeatActionForever(SKAction.sequence([moveground, resetground])))
        
        self.addChild(ground1)
        self.addChild(ground2)
    }
    
    func stop() {
        ground1.removeAllActions()
        ground2.removeAllActions()
    }
    
    override init() {
        super.init()
    }
    
    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
