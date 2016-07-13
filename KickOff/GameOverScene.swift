//
//  GameOverScene.swift
//  SpriteKitSimpleGame
//
//  Created by Main Account on 10/30/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, wonSide:String) {
        
        super.init(size: size)
        
        // 1
        backgroundColor = SKColor.whiteColor()
        
        // 2
        let message:String
        if(wonSide == "red")
        {
            message = "Red Won! Green Lost~"
        }else{
            message = "Green Won! Red Lost~"
        }
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        // 4
//        runAction(SKAction.sequence([
//            SKAction.waitForDuration(3.0),
//            SKAction.runBlock() {
//                // 5
//                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
//                let scene = GameScene(size: size)
//                self.view?.presentScene(scene, transition:reveal)
//            }
//            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}