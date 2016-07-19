//
//  GameScene.swift
//  TestFloat
//
//  Created by Miao, Bobby X. -ND on 7/18/16.
//  Copyright (c) 2016 Miao, Bobby X. -ND. All rights reserved.
//

import SpriteKit
import Darwin

class GameScene: SKScene {
    let ball = SKSpriteNode.init(imageNamed: "ball.png")
    let MAX_CGVector_NE:CGVector = CGVectorMake(1000*8, 1000*8) //Max force of north east
    let MIN_CGVector_NE:CGVector = CGVectorMake(100*8, 100*8)   //Min force of north east
    let MAX_CGVector_NW:CGVector = CGVectorMake(-1000*8, 1000*8) //Max force of north west
    let MIN_CGVector_NW:CGVector = CGVectorMake(-100*8, 100*8)   //Min force of north west
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(ball)
        
        self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: CGRectMake(self.frame.origin.x+290, self.frame.origin.y, self.frame.size.height-320, self.frame.size.width-240))
        print(self.frame.size.width)
        print(self.frame.size.height)
        self.physicsBody?.friction = 0.0
        self.physicsWorld.gravity = CGVectorMake(0, -1)
        
        ball.physicsBody = SKPhysicsBody.init(rectangleOfSize: ball.size)
        //ball.physicsBody!.friction = 0.2
        ball.physicsBody!.restitution = 0.8
        ball.physicsBody!.linearDamping = 0.0
        ball.physicsBody!.allowsRotation = false
        ball.physicsBody?.mass = 1000
        ball.physicsBody?.density = 10
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        ball.physicsBody?.applyForce(MAX_CGVector_NE)
        
        for touch in touches {
            nodeVector(MAX_CGVector_NE, nodeLocation: touch.locationInNode(self))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func nodeVector(originalForce:CGVector,nodeLocation:CGPoint)->CGVector{
        let tempX = nodeLocation.x/sqrt(nodeLocation.x*nodeLocation.x+nodeLocation.y*nodeLocation.y)
        let tempY = nodeLocation.y/sqrt(nodeLocation.x*nodeLocation.x+nodeLocation.y*nodeLocation.y)
        print(tempX)
        print(tempY)
        print(CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy))
        return CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy)
        
    }
}
