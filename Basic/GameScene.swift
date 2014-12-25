//
//  GameScene.swift
//  Basic
//
//  Created by Family on 12/24/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let cowboySprite = SKSpriteNode(imageNamed: "cowboy")
    let cowboyNode = SKNode()
    
    let bkgdSprite = SKSpriteNode(imageNamed: "background")
    let bkgdSprite2 = SKSpriteNode(imageNamed: "background")
    
    override func didMoveToView(view: SKView) {
        self.addChild(cowboyNode)
        
        //generate background moving
        generateBkgd(view)
        
        //display cowboy
        cowboySprite.position = CGPoint(x: view.bounds.width/8, y: view.bounds.height/4)
        cowboySprite.xScale = 1/6
        cowboySprite.yScale = 1/6
        cowboyNode.addChild(cowboySprite)
        runForever()
    }
    
    
    func generateBkgd(view: SKView) {
        //note: CGPoint is based on center point
        
        //first sprite (on screen)
        bkgdSprite.position = CGPointMake(view.bounds.width/2, view.bounds.height/2)
        bkgdSprite.size = view.bounds.size
        //second sprite (off screen)
        bkgdSprite2.position = CGPointMake(view.bounds.width * 1.5, view.bounds.height/2)
        bkgdSprite2.size = view.bounds.size
        
        //animates sprite backward by a length of screen size. Scales well because time is based on screen size.
        let moveGroundSprite = SKAction.moveByX(-view.bounds.width, y: 0, duration: NSTimeInterval(view.bounds.width/100))
        //moves the sprite back to original position
        let resetGroundSprite = SKAction.moveByX(view.bounds.width, y: 0, duration: 0.0)
        
        //animate
        bkgdSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite])))
        bkgdSprite2.runAction(SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite])))
        self.addChild(bkgdSprite)
        self.addChild(bkgdSprite2)
        
    }
    
    func runForever()
    {
        var arr: [SKTexture] = Array<SKTexture>()
        for var i: Int = 1; i <= 8; ++i {
            arr.append(SKTexture(imageNamed: "sprite_\(i)"))
            arr[i-1].filteringMode = .Nearest
        }
        let heroAnim = SKAction.animateWithTextures(arr, timePerFrame: 0.06)
        
        let run = SKAction.repeatActionForever(heroAnim)
        cowboySprite.runAction(run)
    }
    
    
    //touch the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
