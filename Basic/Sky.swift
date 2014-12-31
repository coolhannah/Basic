//
//  Sky.swift
//  Basic
//
//  Created by Aaron Chen on 12/30/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit

class Sky : SKNode {

    let sky1 = SKSpriteNode(imageNamed: "Sky")
    let sky2 = SKSpriteNode(imageNamed: "Sky")
    
    var skyPos = CGPoint()
    
    var move : SKAction = SKAction()
    

    init(view: SKView) {
        super.init()
        //position based on center points
        skyPos = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        sky1.position = skyPos
        sky1.size = view.bounds.size
        sky2.position = CGPoint(x: skyPos.x * 3, y: skyPos.y)
        sky2.size = view.bounds.size
        
        let moveSky = SKAction.moveByX(-view.bounds.width, y:0, duration: NSTimeInterval(2))
        let resetSky = SKAction.moveByX(view.bounds.width, y:0, duration: 0.0)
        
        move = SKAction.repeatActionForever(SKAction.sequence([moveSky, resetSky]))
        
        sky1.runAction(move)
        sky2.runAction(move)
        
        self.addChild(sky1)
        self.addChild(sky2)
    }
    
    func stop() {
        sky1.removeAllActions()
        sky2.removeAllActions()
    }
    func start() {
        sky1.position = skyPos
        sky2.position = CGPoint(x: skyPos.x * 3, y: skyPos.y)
        sky1.runAction(move)
        sky2.runAction(move)
    }
    
    override init() {
        super.init()
    }

    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}