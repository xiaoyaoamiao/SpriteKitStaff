//
//  GameScene.swift
//  TestFloat
//
//  Created by Miao, Bobby X. -ND on 7/18/16.
//  Copyright (c) 2016 Miao, Bobby X. -ND. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        let ball = SKSpriteNode.init(imageNamed: "ball.png")
        ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(ball)
        
        let borderBody = SKPhysicsBody.init(edgeLoopFromRect: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.friction = 0.0
        
        ball.physicsBody = SKPhysicsBody.init(rectangleOfSize: ball.size)
        //ball.physicsBody!.friction = 0.2
        ball.physicsBody!.restitution = 0.8
        ball.physicsBody!.linearDamping = 0.0
        ball.physicsBody!.allowsRotation = false
        
        ball.physicsBody?.mass = 1000
        
        let thrust:Float = 0.12
        
        let shipDirection:Float = 0
        //let thrustVector = CGPointMake((CGFloat)(thrust*cosf(shipDirection)),(CGFloat)(thrust*sinf(shipDirection)));
        ball.physicsBody?.applyForce(CGVectorMake((CGFloat)(thrust*cosf(shipDirection)),(CGFloat)(thrust*sinf(shipDirection))))
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
