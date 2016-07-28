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
    let bottleGlassThick:CGFloat = 2

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
        
        //add tadpole

        let tadpole1 = SKTexture(imageNamed: "tadpole1.png")
        let tadpole2 = SKTexture(imageNamed: "tadpole2.png")
        let tadpole3 = SKTexture(imageNamed: "tadpole3.png")
        let tadpole4 = SKTexture(imageNamed: "tadpole4.png")
        var tadpoleArray = [tadpole1,tadpole2,tadpole3,tadpole4]
        
        for _ in 1...20{
//            let ball = SKSpriteNode.init(imageNamed: "ball.png")
//            ball.position = CGPoint(x:self.frame.origin.x+300+(CGFloat)(arc4random()%UInt32(self.frame.size.height-400)), y:CGRectGetMidY(self.frame))
//            ball.setScale(1)
//            ball.physicsBody = SKPhysicsBody.init(rectangleOfSize: ball.size)
//            ball.physicsBody!.friction = 1
//            ball.physicsBody!.restitution = 0.6
//            ball.physicsBody!.linearDamping = 0.0
//            ball.physicsBody!.allowsRotation = true
//            ball.physicsBody?.mass = 1000
//            ball.physicsBody?.density = 30
//            ball.setScale(0.4)
//            ball.name = "test"
//            self.addChild(ball)

            var tadpole = SKSpriteNode(texture: tadpole1)
            
            tadpole.position = CGPoint(x:self.frame.origin.x+300+(CGFloat)(arc4random()%UInt32(self.frame.size.height-400)), y:CGRectGetMidY(self.frame))
            tadpole.setScale(1)
            tadpole.physicsBody = SKPhysicsBody(circleOfRadius: tadpole.size.width/2)
            tadpole.physicsBody!.friction = 1
            tadpole.physicsBody!.restitution = 0.6
            tadpole.physicsBody!.linearDamping = 0.0
            tadpole.physicsBody!.allowsRotation = true
            tadpole.physicsBody?.mass = 10
            tadpole.physicsBody?.density = 10
            tadpole.setScale(0.2)
            tadpole.name = "tadpole"
            self.addChild(tadpole)
            var tadpoleMove = SKAction.animateWithTextures(tadpoleArray, timePerFrame: 0.05)
            var runTadpole = SKAction.repeatActionForever(tadpoleMove)
            tadpole.runAction(runTadpole)
        }
        
        //Button
        let leftButton = self.childNodeWithName("buttonLeft")
        let rightButton = self.childNodeWithName("buttonRight")
//        (leftButton as SKSpriteNode).physicsBody = SKPhysicsBody.init(rectangleOfSize:(leftButton as SKSpriteNode).size)
//        (rightButton as SKSpriteNode).physicsBody = SKPhysicsBody.init(rectangleOfSize:(rightButton as SKSpriteNode).size)
        leftButton!.physicsBody = SKPhysicsBody(circleOfRadius:(leftButton as SKSpriteNode).size.width/2-5)
        rightButton!.physicsBody = SKPhysicsBody(circleOfRadius:(rightButton as SKSpriteNode).size.width/2-5)
        leftButton?.physicsBody?.affectedByGravity = false
        rightButton?.physicsBody?.affectedByGravity = false
        leftButton?.physicsBody?.friction = 0
        rightButton?.physicsBody?.friction = 0
        rightButton?.physicsBody?.dynamic = false
        leftButton?.physicsBody?.dynamic = false
        
        paintMomAndBottle()
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
    
    func paintMomAndBottle(){
        //add mom
        let momTexture = SKTexture(imageNamed: "mom1.png")
        var momTextureArray:[SKTexture] = [momTexture]
        for i in 2...30{
            let temp = (String)(i)
            momTextureArray.append(SKTexture(imageNamed: "mom"+(String)(i)+".png"))
        }

        var mom = SKSpriteNode(texture: momTexture)
        mom.name = "mom"
        mom.position = CGPoint(x:self.frame.origin.x+300+mom.size.width/2+(CGFloat)(arc4random()%UInt32(self.frame.size.height-330-mom.size.width)), y:CGRectGetMidY(self.frame)-100+(CGFloat)(arc4random()%300))
        print(mom.position)
        println("x:\(self.frame.origin.x+mom.size.width/2) width\(self.frame.size.height)")
        self.addChild(mom)
        var momChangeTexsure = SKAction.animateWithTextures(momTextureArray, timePerFrame: 0.1)
        var runMom = SKAction.repeatActionForever(momChangeTexsure)
        mom.setScale(0.6)
        mom.runAction(runMom)
        //add bottle
        let bottle = SKSpriteNode.init(imageNamed:"bottle.png")
        bottle.position = CGPointMake(mom.position.x,mom.position.y+mom.size.height/3)
        bottle.setScale(1)
        bottle.name = "bottle"
        //add physices for bottle
        var bottlePath = CGPathCreateMutable()
        var bottleDoorWidthLeftSpace = bottle.size.width/5
        var bottleDoorWidthRightSpace = bottle.size.width/7
        var bottleHeightSestion1 = bottle.size.height*1/5
        var bottleHeightSestion2 = bottle.size.height*2/5
        
        CGPathMoveToPoint(bottlePath, nil, -bottle.size.width/2+bottleDoorWidthLeftSpace, bottle.size.height/2) //1
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2+bottleDoorWidthLeftSpace, bottle.size.height/2-bottleHeightSestion1)//2
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2, bottle.size.height/2-bottleHeightSestion1-bottleHeightSestion2)//3
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2, -bottle.size.height/2)//4
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2, -bottle.size.height/2)//5
        
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2, bottle.size.height/2-bottleHeightSestion1-bottleHeightSestion2)//6
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2-bottleDoorWidthRightSpace, bottle.size.height/2-bottleHeightSestion1)//7
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2-bottleDoorWidthRightSpace, bottle.size.height/2)//8
        
        
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2-bottleDoorWidthRightSpace-bottleGlassThick, bottle.size.height/2) //8-1
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2-bottleDoorWidthRightSpace-bottleGlassThick, bottle.size.height/2-bottleHeightSestion1)//7-1
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2-bottleGlassThick, bottle.size.height/2-bottleHeightSestion1-bottleHeightSestion2)//6-1
        CGPathAddLineToPoint(bottlePath, nil, bottle.size.width/2-bottleGlassThick, -bottle.size.height/2+bottleGlassThick)//5-1
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2+bottleGlassThick, -bottle.size.height/2+bottleGlassThick)//4-1
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2+bottleGlassThick, bottle.size.height/2-bottleHeightSestion1-bottleHeightSestion2)//3-1
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2+bottleDoorWidthLeftSpace+bottleGlassThick, bottle.size.height/2-bottleHeightSestion1)//2-1
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2+bottleDoorWidthLeftSpace+bottleGlassThick, bottle.size.height/2) //1-1
        CGPathAddLineToPoint(bottlePath, nil, -bottle.size.width/2+bottleDoorWidthLeftSpace, bottle.size.height/2) //1-0
        
        bottle.physicsBody = SKPhysicsBody(polygonFromPath: bottlePath)
        bottle.physicsBody?.affectedByGravity = false
        bottle.physicsBody?.friction = 0
        bottle.physicsBody?.dynamic = false
        println(bottle.size)
        self.addChild(bottle)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent?) {
        for touch in touches {
            let clickNode = nodeAtPoint((touches as NSSet).anyObject()!.locationInNode(self))
            println((touches as NSSet).anyObject()!.locationInNode(self))
            if clickNode.name != nil{
                if clickNode.name!.hasPrefix("button")
                {
                    changeButtonColor(clickNode as SKSpriteNode)
                    for node in self.children{
                        if node.name == "tadpole"{
                            let bottle = self.childNodeWithName("bottle")
                                if (node.position.x > (bottle.position.x-bottle.postion.width/2))&&(node.position.x < (bottle.position.x+bottle.postion.width/2)) && (node.postion.y > (bottle.position.y-bottle.position.height/2))&&(node.postion.y < (bottle.position.y+bottle.position.height/2)){
                                    continue
                                }
                            if (touch.locationInNode(self).x > self.frame.size.width/2){
                                (node as SKSpriteNode).physicsBody?.applyForce(force_right(nodeVector(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                                  // node.physicsBody?.applyForce(force_right(nodeVector(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                            }
                            else
                            {
                                (node as SKSpriteNode).physicsBody?.applyForce(force_left(nodeVector(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                                //node.physicsBody?.applyForce(force_left(nodeVector(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        changeButtonColorBack(touches)
    }
    
    override func touchesCancelled(touches: NSSet, withEvent event: UIEvent!) {
        changeButtonColorBack(touches)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        changeButtonColorBack(touches)
    }
    
    func changeButtonColor(button:SKSpriteNode){
        let changeColor = SKAction.colorizeWithColor(SKColor.greenColor(), colorBlendFactor: 5, duration: 0.1)
        button.runAction(changeColor)
    }
    
    func changeButtonColorBack(touches: NSSet){
        let leftButton = self.childNodeWithName("buttonLeft")
        let rightButton = self.childNodeWithName("buttonRight")
        
        let clickNode = nodeAtPoint((touches as NSSet).anyObject()!.locationInNode(self))
        print(clickNode.name)
        if clickNode.name != nil{
            if clickNode.name == "buttonLeft"{
                let changeColorBack = SKAction.colorizeWithColorBlendFactor(0, duration: 0.3)
                (leftButton as SKSpriteNode).runAction(changeColorBack)
            }else if clickNode.name == "buttonRight"{
                let changeColorBack = SKAction.colorizeWithColorBlendFactor(0, duration: 0.3)
                (rightButton as SKSpriteNode).runAction(changeColorBack)
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
        //print(tempPowerDownRate)
        return CGVectorMake(-tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy)
    }
}
