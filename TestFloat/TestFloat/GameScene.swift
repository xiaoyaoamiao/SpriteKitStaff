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
    
    let MAX_CGVector_NE:CGVector = CGVectorMake(1000*8, 1000*8) //Max force of north east
    let MIN_CGVector_NE:CGVector = CGVectorMake(100*8, 100*8)   //Min force of north east
    let MAX_CGVector_NW:CGVector = CGVectorMake(-1000*8, 1000*8) //Max force of north west
    let MIN_CGVector_NW:CGVector = CGVectorMake(-100*8, 100*8)   //Min force of north west
    let ForceButton_left = CGPoint(x: 340, y: 50)
    let ForceButton_right = CGPoint(x: 680, y: 50)
    let Force_down_rate:Float = 0.9
    let Force_Vector_distance:Float = 30
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //let fieldCenter = self.childNodeWithName("SKSpriteNode_0")?.position
        self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: CGRectMake(self.frame.origin.x+295, self.frame.origin.y, self.frame.size.height-330, self.frame.size.width-250))
                //self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,self.frame.size.height ))
        print(self.frame.size.width)
        print(self.frame.size.height)
        self.physicsBody?.friction = 0.0
        self.physicsWorld.gravity = CGVectorMake(0, -0.1)
        let radialGravityField = self.childNodeWithName("SKVortexFieldNode_0")
        radialGravityField!.position = CGPoint(x:self.frame.origin.x+300+(CGFloat)(arc4random()%UInt32(self.frame.size.height-400)), y:CGRectGetMidY(self.frame))

        //addChild(radialGravityField)
        paintBackGround()
        for _ in 1...50{
            let ball = SKSpriteNode.init(imageNamed: "ball.png")
            ball.position = CGPoint(x:self.frame.origin.x+300+(CGFloat)(arc4random()%UInt32(self.frame.size.height-400)), y:CGRectGetMidY(self.frame))
            ball.setScale(1)
            ball.physicsBody = SKPhysicsBody.init(rectangleOfSize: ball.size)
            ball.physicsBody!.friction = 1
            ball.physicsBody!.restitution = 0.6
            ball.physicsBody!.linearDamping = 0.0
            ball.physicsBody!.allowsRotation = true
            ball.physicsBody?.mass = 1000
            ball.physicsBody?.density = 30
            ball.setScale(0.4)
            ball.name = "test"
            self.addChild(ball)
        }
        
        //Button
        let leftButton = self.childNodeWithName("buttonLeft")
        let rightButton = self.childNodeWithName("buttonRight")
        (leftButton as SKSpriteNode).physicsBody = SKPhysicsBody.init(rectangleOfSize:(leftButton as SKSpriteNode).size)
        (rightButton as SKSpriteNode).physicsBody = SKPhysicsBody.init(rectangleOfSize:(rightButton as SKSpriteNode).size)
        leftButton?.physicsBody?.affectedByGravity = false
        rightButton?.physicsBody?.affectedByGravity = false
        leftButton?.physicsBody?.friction = 0
        rightButton?.physicsBody?.friction = 0
        rightButton?.physicsBody?.dynamic = false
        leftButton?.physicsBody?.dynamic = false
    }
    
    func paintBackGround(){
        let bg = SKSpriteNode.init(imageNamed:"bg_sea.png")
        bg.position =  CGPointMake(self.size.width/2, self.size.height/2)
        bg.name = "backImage"
        bg.alpha = 0.8
        bg.setScale(1.5)
        bg.size = CGSize(width: self.size.width, height: self.size.height)
        bg.name = "backGround"
        self.addChild(bg)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        ball.physicsBody?.applyForce(MAX_CGVector_NE)
        
        for touch in touches {
            //print(touch.locationInNode(self))
            let force = force_left(nodeVector(MAX_CGVector_NE, nodeLocation: touch.locationInNode(self)),nodeLocation: touch.locationInNode(self))
            //print(force)
            //print(force_right(nodeVector(MAX_CGVector_NW, nodeLocation: touch.locationInNode(self)),nodeLocation: touch.locationInNode(self)))
            //print(self.frame.size.width)
            //print(touch.locationInNode(self).x)
            for node in self.children{
                if node.name == "test"{
                    if (touch.locationInNode(self).x > self.frame.size.width/2){
                        (node as SKSpriteNode).physicsBody?.applyForce(force_right(nodeVector(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                    }
                    else
                    {
                        (node as SKSpriteNode).physicsBody?.applyForce(force_left(nodeVector(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                    }
                }
                
            }
        }
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func nodeVector(originalForce:CGVector,nodeLocation:CGPoint)->CGVector{
        let tempX = nodeLocation.x/sqrt(nodeLocation.x*nodeLocation.x+nodeLocation.y*nodeLocation.y)
        let tempY = nodeLocation.y/sqrt(nodeLocation.x*nodeLocation.x+nodeLocation.y*nodeLocation.y)
        //print(CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy))
        return CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy)
    }
    
    func force_left(vector:CGVector,nodeLocation:CGPoint)->CGVector{
        let tempPowerDownRate = pow((CGFloat)(Force_down_rate), sqrt(pow(nodeLocation.x-ForceButton_left.x, 2.0)+pow(nodeLocation.y-ForceButton_left.y, 2.0))/(CGFloat)(Force_Vector_distance))
        //print(tempPowerDownRate)
        return CGVectorMake(tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy)
    }
    func force_right(vector:CGVector,nodeLocation:CGPoint)->CGVector{
        let tempPowerDownRate = pow((CGFloat)(Force_down_rate), sqrt(pow(nodeLocation.x-ForceButton_right.x, 2.0)+pow(nodeLocation.y-ForceButton_left.y, 2.0))/(CGFloat)(Force_Vector_distance))
        print(tempPowerDownRate)
        return CGVectorMake(-tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy)
    }
}
