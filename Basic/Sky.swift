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

    init(view: SKView) {
        super.init()
        //position based on center points
        sky1.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        sky1.size = view.bounds.size
        sky2.position = CGPoint(x: view.bounds.width * 1.5, y: view.bounds.height/2)
        sky2.size = view.bounds.size
        
        let moveSky = SKAction.moveByX(-view.bounds.width, y:0, duration: NSTimeInterval(1))
        let resetSky = SKAction.moveByX(view.bounds.width, y:0, duration: 0.0)
        
        sky1.runAction(SKAction.repeatActionForever(SKAction.sequence([moveSky, resetSky])))
        sky2.runAction(SKAction.repeatActionForever(SKAction.sequence([moveSky, resetSky])))
        
        self.addChild(sky1)
        self.addChild(sky2)
    }
    
    func stop() {
        sky1.removeAllActions()
        sky2.removeAllActions()
    }
    
    override init() {
        super.init()
    }

    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}