//
//  GameViewController.swift
//  ZombieConga
//
//  Created by wei leng on 1/26/15.
//  Copyright (c) 2015 wei leng. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let scene = LevelOne(size:CGSize(width: 2048, height: 1536))
        // Configure the view.
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.userInteractionEnabled = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .ResizeFill
        scene.size                          = skView.bounds.size
        skView.presentScene(scene)*/
        var scene                           = LevelOne(size:CGSize(width: 2048, height: 1536))
        let skView                          = self.view as SKView!
        skView?.ignoresSiblingOrder         = true
        skView.showsFPS = true
        skView.showsNodeCount = true
       // skView.showsPhysics = true
        scene.scaleMode                     = .AspectFill
        //scene.size                          = skView.bounds.size
        skView.presentScene(scene)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
