//
//  Cowboy.swift
//  Basic
//
//  Created by Aaron Chen on 12/29/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import Foundation
import SpriteKit


//TODO MAIN TODO
/*
|√|    1) Make sure the cactus is not affected by physics- just let it do a runByX
2) Reimplement everything into classes
|√|    3) Figure out why the double jump is happening at all
4) Randomize the speed and entrance of cactus
5) replay screen
*/

class Cowboy : SKSpriteNode {
    
    //required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var cowPos = CGPoint()
    var groundY = CGFloat()
    var cowRun = SKAction()
    
    override init() {
        //do nothing
        super.init()
    }
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    //initializer
    init(view: SKView) {
        //variables
        groundY = CGFloat( view.bounds.height/3 )
        cowPos = CGPoint(x: view.bounds.width/8, y: groundY * 5/4)
        let texture = SKTexture(imageNamed: "cowboy")
        
        //superclass init
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.size = CGSize(width: view.bounds.width/12, height: view.bounds.width/12)
        self.position = cowPos
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.mass = CGFloat(0.2)
        self.physicsBody?.categoryBitMask = GameScene.types.Hero.rawValue
        self.physicsBody?.contactTestBitMask = GameScene.types.Enemy.rawValue
        self.physicsBody?.collisionBitMask = GameScene.types.Enemy.rawValue
        self.physicsBody?.dynamic = true
        setUpRunningAnim()
        self.runAction(cowRun)
    }
    
    func setUpRunningAnim()
    {
        var arr: [SKTexture] = Array<SKTexture>()
        for var i: Int = 1; i <= 8; ++i {
            arr.append(SKTexture(imageNamed: "sprite_\(i)"))
            arr[i-1].filteringMode = .Nearest
        }
        let heroAnim = SKAction.animateWithTextures(arr, timePerFrame: 0.06)
    
        cowRun = SKAction.repeatActionForever(heroAnim)
    }

   

}