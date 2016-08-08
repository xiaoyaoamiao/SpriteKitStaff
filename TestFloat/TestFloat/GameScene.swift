//
//  GameScene.swift
//  TestFloat
//
//  Created by Miao, Bobby X. -ND on 7/18/16.
//  Copyright (c) 2016 Miao, Bobby X. -ND. All rights reserved.
//

import SpriteKit
import Darwin
import AVFoundation

class GameScene: SKScene {
    
    let MAX_CGVector_NE:CGVector = CGVectorMake(1000*8, 1000*8) //Max force of north east
    let MIN_CGVector_NE:CGVector = CGVectorMake(100*8, 100*8)   //Min force of north east
    let MAX_CGVector_NW:CGVector = CGVectorMake(1000*8, 1000*8) //Max force of north west
    let MIN_CGVector_NW:CGVector = CGVectorMake(100*8, 100*8)   //Min force of north west
    let screen_width:CGFloat = 432
    let screen_height:CGFloat = 768
    let ForceButton_left = CGPoint(x: 296, y: 0)
    let ForceButton_right = CGPoint(x: 728, y: 0)
    let screen_top_left_point = CGPoint(x: 296, y: 768)
    let screen_top_right_point = CGPoint(x: 728, y: 768)
    let tadpole_come_in_point = CGPoint(x:512,y:0)
    
    let Force_down_rate:Float = 0.9
    let Force_Vector_distance:Float = 200
    let bottleGlassThick:CGFloat = 2
    var tadpoleNumberFirst:Bool = false
    let tadpoleNumber:Int = 10
    //
    //music
    var backGroundMusic:AVAudioPlayer? = nil
    var scoreMusic:AVAudioPlayer? = nil
    var waterFireMusic:AVAudioPlayer? = nil
    //countr score
    var scoreNumber:Int = 0
    
    
    func testScreenSize(){
        let point1 = SKShapeNode.init(circleOfRadius: 100)
        point1.strokeColor = UIColor.blueColor()
        point1.setScale(0.5)
        point1.position = CGPointMake(ForceButton_left.x+50, ForceButton_left.y+50)
        //point1.position = CGPointMake(ForceButton_left.x+point1.size.width/2, ForceButton_left.y+point1.size.height/2)
        let point2 = SKSpriteNode.init(imageNamed: "tadpoleball")
        point2.setScale(0.5)
        point2.position = CGPointMake(ForceButton_right.x-point2.size.width/2, ForceButton_right.y+point2.size.height/2)
        let point3 = SKSpriteNode.init(imageNamed: "tadpoleball")
        point3.setScale(0.5)
        point3.position = CGPointMake(screen_top_left_point.x+point3.size.width/2, screen_top_left_point.y-point3.size.height/2)
        let point4 = SKSpriteNode.init(imageNamed: "tadpoleball")
        point4.setScale(0.5)
        point4.position = CGPointMake(screen_top_right_point.x-point3.size.width/2, screen_top_right_point.y-point3.size.height/2)
        self.addChild(point1)
        self.addChild(point2)
        self.addChild(point3)
        self.addChild(point4)
        print(self.scene?.frame.origin.x)
        print(self.scene?.frame.origin.y)
    }
    func tadpole_growth(){
        let tadpole_children = SKTexture(imageNamed: "tadpoleball")
        let tadpole1 = SKTexture(imageNamed: "tadpole1.png")
        let tadpole2 = SKTexture(imageNamed: "tadpole2.png")
        let tadpole3 = SKTexture(imageNamed: "tadpole3.png")
        let tadpole4 = SKTexture(imageNamed: "tadpole4.png")
        let tadpoleArray = [tadpole1,tadpole2,tadpole3,tadpole4]
        
        let tadpole = SKSpriteNode(texture: tadpole_children)
 
        tadpole.physicsBody = SKPhysicsBody(rectangleOfSize: tadpole.size)
        tadpole.physicsBody!.friction = 1
        tadpole.physicsBody!.restitution = 0.6
        tadpole.physicsBody!.linearDamping = 0.0
        tadpole.physicsBody!.allowsRotation = true
        tadpole.physicsBody?.mass = 1
        tadpole.physicsBody?.density = 10
        tadpole.position = tadpole_come_in_point
        tadpole.setScale(0.2)
        tadpole.name = "tadpole"
        
        let xTemp = (CGFloat)(arc4random()%UInt32(screen_width/2))+screen_width/4+ForceButton_left.x
        let yTemp = screen_height/4+(CGFloat)(arc4random()%UInt32(screen_width/4))
        
        //show tadpole
        let tadpoleBallAction1 = SKAction.moveTo(CGPointMake(xTemp, yTemp), duration: 1)
        let tadpoleBallAction2 = SKAction.rotateByAngle(tadpole.size.width/2, duration: 0.2)
        let tadpoleBallRotaionAction = SKAction.repeatAction(tadpoleBallAction2, count: Int(arc4random()%UInt32(5)))
        let tadpoleBallActionSequnce = SKAction.group([tadpoleBallAction1,tadpoleBallRotaionAction])
        //change texture
        let tadpoleMove = SKAction.animateWithTextures(tadpoleArray, timePerFrame: 0.05)
        let runTadpole = SKAction.repeatActionForever(tadpoleMove)
        let tadpoleBallChangeTexture = SKAction.setTexture(tadpole1, resize: true)
        let tadpoleBallActionGroup = SKAction.sequence([tadpoleBallActionSequnce,tadpoleBallChangeTexture,runTadpole])
        
        tadpole.runAction(tadpoleBallActionGroup)
        self.addChild(tadpole)

    }
    
    //add bubble
    func addbubble(color: NSString){
        let bubble_blue_image = SKTexture(imageNamed: color as String)
        let bubble_blue = SKSpriteNode(texture: bubble_blue_image)
        bubble_blue.name = color as String
        bubble_blue.setScale(0.01)
        bubble_blue.alpha = 0.2
        let locationX = arc4random()%UInt32(screen_width/2) +  (UInt32)(screen_width/4) + (UInt32)(ForceButton_left.x)
        bubble_blue.position = CGPointMake((CGFloat)(locationX), screen_height/5)
        
        let bubble_blue_moveAction = SKAction.moveToY(screen_height, duration: 4)
        let bubble_blue_scaleAction = SKAction.scaleTo(0.1, duration: 4)
        let bubble_group = SKAction.group([bubble_blue_moveAction,bubble_blue_scaleAction])
        //let bubble_alpha = SKAction.
        let bubble_changeAlpha = SKAction.colorizeWithColor(SKColor.whiteColor(), colorBlendFactor: 1, duration: 0.5)
        let bubble_removeFromParent = SKAction.removeFromParent()
        let bubble_sequence = SKAction.sequence([bubble_group,bubble_changeAlpha,bubble_removeFromParent])
        bubble_blue.runAction(bubble_sequence)
        self.addChild(bubble_blue)
    }
    
    //init playback music
    func musicInitBackGroundMusic(){
        var path = NSBundle.mainBundle().pathForResource("playBackMusic1", ofType: "wav")
        var pathURL = NSURL.fileURLWithPath(path!)
        backGroundMusic = AVAudioPlayer(contentsOfURL: pathURL, error: nil)
        backGroundMusic?.numberOfLoops = -1
        backGroundMusic?.play()
    }
    func musicInitOtherMusic(){
        var firePath = NSBundle.mainBundle().pathForResource("fire", ofType: "wav")
        var scorePath = NSBundle.mainBundle().pathForResource("score", ofType: "wav")
        var victoryPath = NSBundle.mainBundle().pathForResource("victory", ofType: "mp3")
        var failedPath = NSBundle.mainBundle().pathForResource("failed", ofType: "wav")
        var firePathURL = NSURL.fileURLWithPath(firePath!)
        var scorePathURL = NSURL.fileURLWithPath(firePath!)
        waterFireMusic = AVAudioPlayer(contentsOfURL: firePathURL, error: nil)
        scoreMusic = AVAudioPlayer(contentsOfURL: scorePathURL, error: nil)
    }
    
    func addEmitter(direction:NSString){
        let bunble=SKEmitterNode(fileNamed: "Snow.sks")
        let leftButton = self.childNodeWithName("buttonLeft")
        if direction == "left"{
            
            bunble.position = CGPointMake(ForceButton_left.x+(leftButton as SKSpriteNode).size.width/2, ForceButton_left.y+(leftButton as SKSpriteNode).size.width/2)
            bunble.xAcceleration = 50
            bunble.emissionAngle = 45
        }else{
            bunble.position = CGPointMake(ForceButton_right.x+(leftButton as SKSpriteNode).size.width/2-100, ForceButton_right.y+(leftButton as SKSpriteNode).size.width/2)
            bunble.xAcceleration = -50
            bunble.emissionAngle = 90
        }
        

        self.addChild(bunble)
        
        let emitterAdd = SKAction.waitForDuration(1)
        let emitterRemove = SKAction.removeFromParent()
        let emitterSequence = SKAction.sequence([emitterAdd,emitterRemove])
        bunble.runAction(emitterSequence)
    }
    
    override func didMoveToView(view: SKView) {

        paintBackGround()
        paintMomAndBottle()
        musicInitBackGroundMusic()
        musicInitOtherMusic()

        self.runAction(
            SKAction.repeatActionForever(
                SKAction.group([
                    SKAction.sequence([SKAction.runBlock({self.addbubble("new_bubble")}),
                        SKAction.waitForDuration(0.5)]),
                    SKAction.sequence([SKAction.runBlock({self.addbubble("new_bubble")}),
                        SKAction.waitForDuration(0.5)])
                    ])
                ))
        //Button
        let leftButton = self.childNodeWithName("buttonLeft")
        let rightButton = self.childNodeWithName("buttonRight")

        leftButton!.physicsBody = SKPhysicsBody(circleOfRadius:(leftButton as SKSpriteNode).size.width/2-5)
        rightButton!.physicsBody = SKPhysicsBody(circleOfRadius:(rightButton as SKSpriteNode).size.width/2-5)
        leftButton?.physicsBody?.affectedByGravity = false
        rightButton?.physicsBody?.affectedByGravity = false
        leftButton?.physicsBody?.friction = 0
        rightButton?.physicsBody?.friction = 0
        rightButton?.physicsBody?.dynamic = false
        leftButton?.physicsBody?.dynamic = false
        
        self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: CGRectMake(ForceButton_left.x, ForceButton_left.y, screen_width, screen_height))
        //self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,self.frame.size.height ))
        print(self.frame.size.width)
        print(self.frame.size.height)
        self.physicsBody?.friction = 0.0
        self.physicsWorld.gravity = CGVectorMake(0, -0.1)

        addDragFieldIntoView()
    }
    
    func addDragFieldIntoView(){
        let dragField = SKFieldNode.dragField()
        dragField.position = (self.childNodeWithName("SKSpriteNode_2")?.position)!
        dragField.region = SKRegion(radius: 1000)
        dragField.strength = 1
        dragField.name = "DragFieldTemp"
        addChild(dragField)
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
            momTextureArray.append(SKTexture(imageNamed: "mom"+(String)(i)+".png"))
        }

        let mom = SKSpriteNode(texture: momTexture)
        mom.name = "mom"
        mom.position = CGPoint(x:self.frame.origin.x+300+mom.size.width/2+(CGFloat)(arc4random()%UInt32(self.frame.size.height-330-mom.size.width)), y:CGRectGetMidY(self.frame)-100+(CGFloat)(arc4random()%300))
        
        let momChangeTexsure = SKAction.animateWithTextures(momTextureArray, timePerFrame: 0.1)
        let runMom = SKAction.repeatActionForever(momChangeTexsure)
        mom.setScale(0.6)
        mom.runAction(runMom)
        //add bottle
        let bottle = SKSpriteNode.init(imageNamed:"bottle.png")
        bottle.position = CGPointMake(mom.position.x,mom.position.y+mom.size.height*2/5)
        bottle.setScale(1)
        bottle.name = "bottle"
        //add physices for bottle
        let bottlePath = CGPathCreateMutable()
        let bottleDoorWidthLeftSpace = bottle.size.width/5
        let bottleDoorWidthRightSpace = bottle.size.width/7
        let bottleHeightSestion1 = bottle.size.height*1/5
        let bottleHeightSestion2 = bottle.size.height*2/5
        
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
        self.addChild(bottle)
        self.addChild(mom)
    }
    
    override func touchesBegan(touches:NSSet, withEvent event: UIEvent!) {
        for touch in touches {
            if tadpoleNumberFirst == false{
                self.runAction(
                    SKAction.repeatAction(
                        SKAction.sequence([
                            SKAction.runBlock(tadpole_growth),
                            SKAction.waitForDuration(0.1)
                            ]), count: tadpoleNumber))
                tadpoleNumberFirst = true
                
                return
                //add tadpole
                
                //        let tadpole1 = SKTexture(imageNamed: "tadpole1.png")
                //        let tadpole2 = SKTexture(imageNamed: "tadpole2.png")
                //        let tadpole3 = SKTexture(imageNamed: "tadpole3.png")
                //        let tadpole4 = SKTexture(imageNamed: "tadpole4.png")
                //        let tadpoleArray = [tadpole1,tadpole2,tadpole3,tadpole4]
                
                //        for tadpoleNumber in 1...10{
                //
                //            let tadpole = SKSpriteNode(texture: tadpole1)
                ////            let tadpole_children = SKTexture(imageNamed: "tadpoleball")
                ////            let tadpole_children2 = SKSpriteNode(texture: tadpole_children)
                //
                //            tadpole.position = CGPoint(x:self.frame.origin.x+300+(CGFloat)(arc4random()%UInt32(self.frame.size.height-400)), y:CGRectGetMidY(self.frame))
                //            tadpole.physicsBody = SKPhysicsBody(circleOfRadius: tadpole.size.width/2)
                //            tadpole.physicsBody!.friction = 1
                //            tadpole.physicsBody!.restitution = 0.6
                //            tadpole.physicsBody!.linearDamping = 0.0
                //            tadpole.physicsBody!.allowsRotation = true
                //            tadpole.physicsBody?.mass = 1
                //            tadpole.physicsBody?.density = 10
                //            tadpole.setScale(0.2)
                //            tadpole.name = "tadpole"
                //            self.addChild(tadpole)
                //            let tadpoleMove = SKAction.animateWithTextures(tadpoleArray, timePerFrame: 0.05)
                //            let runTadpole = SKAction.repeatActionForever(tadpoleMove)
                //            tadpole.runAction(runTadpole)
                //        }
            }
            
            let clickNode = nodeAtPoint((touches as NSSet).anyObject()!.locationInNode(self))
            
            print((touches as NSSet).anyObject()!.locationInNode(self))
            
            if clickNode.name != nil{
                //println(clickNode.name!+"---test")
                if clickNode.name!.hasPrefix("button")
                {
                    
                    if waterFireMusic?.playing == true {
                        waterFireMusic?.stop()
                    }
                    waterFireMusic?.play()
                    
                    if clickNode.name == "buttonLeft"{
                        addEmitter("left")
                        let VortexFieldNode = SKFieldNode.vortexField()
                        let strengthActionStart = SKAction.strengthBy(1, duration: 0.7)
                        let strengthActionBack = SKAction.strengthBy(0, duration: 4)
                        let VortexFieldRemove = SKAction.removeFromParent()
                        let strengthActionGroup = SKAction.sequence([strengthActionStart,strengthActionBack,VortexFieldRemove])
                        
                        self.addChild(VortexFieldNode)
                        VortexFieldNode.name = "VortexField"
                        VortexFieldNode.minimumRadius = 0.3
                        VortexFieldNode.position = (self.childNodeWithName("SKSpriteNode_2")?.position)!
                        VortexFieldNode.runAction(strengthActionGroup)
                    }else if clickNode.name == "buttonRight"{
                        addEmitter("right")
                        let VortexFieldNode = SKFieldNode.vortexField()
                        let strengthActionStart = SKAction.strengthBy(-1, duration: 0.7)
                        let strengthActionBack = SKAction.strengthBy(0, duration: 4)
                        let VortexFieldRemove = SKAction.removeFromParent()
                        let strengthActionGroup = SKAction.sequence([strengthActionStart,strengthActionBack,VortexFieldRemove])
                        
                        self.addChild(VortexFieldNode)
                        VortexFieldNode.name = "VortexField"
                        VortexFieldNode.minimumRadius = 0.3
                        VortexFieldNode.position = (self.childNodeWithName("SKSpriteNode_2")?.position)!
                        VortexFieldNode.runAction(strengthActionGroup)
                    }
                
                    
                    changeButtonColor(clickNode as SKSpriteNode)
                    for node in self.children{
                        if node.name == "tadpole"{
                            let bottle = self.childNodeWithName("bottle")
                                if (node.position.x > (bottle!.position.x-bottle!.position.x/2))&&(node.position.x < (bottle!.position.x+bottle!.position.x/2)) && (node.position.y > (bottle!.position.y-bottle!.position.y/2))&&(node.position.y < (bottle!.position.y+bottle!.position.y/2)){
                                    continue
                                }
                            if (touch.locationInNode(self).x > self.frame.size.width/2){
                                //(node as! SKSpriteNode).physicsBody?.applyForce(force_right(nodeVectorRight(MAX_CGVector_NW, nodeLocation: node.position),nodeLocation:node.position))
                                (node as SKSpriteNode).physicsBody?.applyForce(force_right(nodeVectorRight(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                            }
                            else
                            {
                                (node as SKSpriteNode).physicsBody?.applyForce(force_left(nodeVectorLeft(MAX_CGVector_NW, nodeLocation: node.position),nodeLocation:node.position))
                                //(node as! SKSpriteNode).physicsBody?.applyForce(force_left(nodeVectorLeft(MAX_CGVector_NE, nodeLocation: node.position),nodeLocation:node.position))
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    
    override func touchesEnded(touches:NSSet, withEvent event: UIEvent) {
        changeButtonColorBack(touches)

    }
    
    override func touchesCancelled(touches: NSSet, withEvent event: UIEvent) {
        changeButtonColorBack(touches)
    }
    
    override func touchesMoved(touches:NSSet, withEvent event: UIEvent) {
        changeButtonColorBack(touches)
    }
    
    func changeButtonColor(button:SKSpriteNode){
        let changeColor = SKAction.colorizeWithColor(SKColor.greenColor(), colorBlendFactor: 1, duration: 0.1)
        button.runAction(changeColor)
    }
    
    func changeButtonColorBack(touches: NSSet){
        let leftButton = self.childNodeWithName("buttonLeft")
        let rightButton = self.childNodeWithName("buttonRight")
        
        let clickNode = nodeAtPoint((touches as NSSet).anyObject()!.locationInNode(self))

        if clickNode.name != nil{
            if clickNode.name == "buttonLeft"{
                let changeColorBack = SKAction.colorizeWithColorBlendFactor(0, duration: 0.8)
                (leftButton as SKSpriteNode).runAction(changeColorBack)
            }else if clickNode.name == "buttonRight"{
                let changeColorBack = SKAction.colorizeWithColorBlendFactor(0, duration: 0.8)
                (rightButton as SKSpriteNode).runAction(changeColorBack)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
    }
    
    func nodeVectorLeft(originalForce:CGVector,nodeLocation:CGPoint)->CGVector{
        let tempX = (nodeLocation.x-ForceButton_left.x)/sqrt(pow((nodeLocation.x-ForceButton_left.x), 2)+pow((nodeLocation.y-ForceButton_left.y),2))
        let tempY = (nodeLocation.y-ForceButton_left.y)/sqrt(pow((nodeLocation.x-ForceButton_left.x), 2)+pow((nodeLocation.y-ForceButton_left.y),2))
        print("right: \(tempX*originalForce.dx) + \(tempY*originalForce.dy)")
        //println(CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy))
        return CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy)
    }
    func nodeVectorRight(originalForce:CGVector,nodeLocation:CGPoint)->CGVector{
        print(nodeLocation)
        let tempX = (nodeLocation.x-ForceButton_right.x)/sqrt(pow((nodeLocation.x-ForceButton_right.x), 2)+pow((nodeLocation.y-ForceButton_right.y),2))
        let tempY = (nodeLocation.y-ForceButton_right.y)/sqrt(pow((nodeLocation.x-ForceButton_right.x), 2)+pow((nodeLocation.y-ForceButton_right.y),2))
        print("right: \(tempX*originalForce.dx) + \(tempY*originalForce.dy)")
        //println(CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy))
        return CGVectorMake(tempX*originalForce.dx, tempY*originalForce.dy)
    }
    
    //strength off
    func force_left(vector:CGVector,nodeLocation:CGPoint)->CGVector{
         //print(nodeLocation.x-ForceButton_left.x)
        let tempPowerDownRate = pow((CGFloat)(Force_down_rate), sqrt(pow(nodeLocation.x-ForceButton_left.x, 2.0)+pow(nodeLocation.y-ForceButton_left.y, 2.0))/(CGFloat)(Force_Vector_distance))
        
        //println(tempPowerDownRate)
        print(CGVectorMake(tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy))
        //println(-tempPowerDownRate*vector.dx)
        //println(-tempPowerDownRate*vector.dy)
        return CGVectorMake(tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy)
    }
    func force_right(vector:CGVector,nodeLocation:CGPoint)->CGVector{
        //print(nodeLocation.x-ForceButton_right.x)
        let tempPowerDownRate = pow((CGFloat)(Force_down_rate), sqrt(pow(nodeLocation.x-ForceButton_right.x, 2.0)+pow(nodeLocation.y-ForceButton_right.y, 2.0))/(CGFloat)(Force_Vector_distance))
        //println(tempPowerDownRate)
        //print(CGVectorMake(-tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy))
        //println(-tempPowerDownRate*vector.dx)
        //println(-tempPowerDownRate*vector.dy)
        return CGVectorMake(tempPowerDownRate*vector.dx, tempPowerDownRate*vector.dy)
    }
}
