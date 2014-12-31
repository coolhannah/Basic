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

var moveIt = SKAction()

var positions = CGPoint()

class Ground : SKNode {
    
    init(view: SKView) {
        super.init()
        groundTexture.filteringMode = .Nearest
        let groundY = CGFloat(view.bounds.height/3)
        
        self.physicsBody =
            SKPhysicsBody(edgeFromPoint: CGPoint(x: -1000, y: groundY), toPoint: CGPoint(x:view.bounds.width * 3/2 , y: groundY))
        self.physicsBody?.dynamic = false
        
        //position based on center points
        positions = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        ground1.position = positions
        ground1.size = view.bounds.size
        ground2.position = CGPoint(x: positions.x * 3, y: positions.y)
        ground2.size = view.bounds.size
        
        let moveground = SKAction.moveByX(-view.bounds.width, y:0, duration: NSTimeInterval(1.5))
        let resetground = SKAction.moveByX(view.bounds.width, y:0, duration: 0.0)
        moveIt = SKAction.repeatActionForever(SKAction.sequence([moveground, resetground]))
        
        ground1.runAction(moveIt)
        ground2.runAction(moveIt)
        
        self.addChild(ground1)
        self.addChild(ground2)
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
    
    func shake() {
        let moveLeft = SKAction.moveByX(positions.x/12, y:0 , duration: NSTimeInterval(0.5))
        let moveRight = SKAction.moveByX(-positions.x/12, y:0 , duration: NSTimeInterval(0.5))
        let shakeAction = SKAction.repeatAction(SKAction.sequence([moveLeft, moveRight]), count: 20)
    }
    
    override init() {
        super.init()
    }
    
    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}