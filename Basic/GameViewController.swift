//
//  GameViewController.swift
//  Basic
//
//  Created by Family on 12/24/14.
//  Copyright (c) 2014 Chen Corp. All rights reserved.
//

import UIKit
import SpriteKit


//Controls a /view/ that displays scenes.
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //initialize the scene to fill screen
        let scene = GameScene(size: self.view.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Configure the view that this class controls
        let skView = self.view as SKView
        skView.ignoresSiblingOrder = true
        
        //display the game scene through our main view
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
