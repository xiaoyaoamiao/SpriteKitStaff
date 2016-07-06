//
//  GameScene.swift
//  KickOff
//
//  Created by Miao, Bobby X. -ND on 6/22/16.
//  Copyright (c) 2016 Miao, Bobby X. -ND. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var width_blank_space:CGFloat = 0.0
    var mapWidth:CGFloat = 0
    var mapHeight:CGFloat = 0
    var recRange1_Location:CGPoint?
    var recRange2_Location:CGPoint?
    var centerPoint:CGPoint?
    var pointsLocation:[CGPoint] = [CGPoint]()
    var skNodeLocation:[String] = [String](arrayLiteral: "1","1","1","x","x","0","0","0","0","x","x","1")
    var chessArray:[SKSpriteNode] = [SKSpriteNode]()
    let chessScale:CGFloat = 0.4
    let chessScale_focus:CGFloat = 0.5
    //
    var direction_temp:UISwipeGestureRecognizerDirection?
    var touched_location:CGPoint?
    var touched_node:SKNode?
    var kickOffStatus = 3
    //move order
    var moveOrder:Bool = true
    
    //Phycics
    var SKPhysicsJointLimitTest:SKPhysicsJointLimit?
    
    
    struct physicsCategoryStruct {
        static let chessCategory:UInt32 = 0b1 //1
    }
    
    
    override func didMoveToView(view: SKView) {
        centerPoint = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame))
        self.removeAllChildren()
        paintBackGround()
        displayInitSKNode()
        //test()
    }
    
    func test(){
//        width_blank_space = self.view!.frame.width/8
//        mapWidth = width_blank_space*2
      //  self.physicsWorld.gravity = CGVectorMake(0,0)
      //  physicsWorld.contactDelegate = self
        let kickOffPath = UIBezierPath.init(arcCenter:CGPoint(x:0,y:-mapWidth), radius: mapWidth, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(3*M_PI/2), clockwise: false)
        let followCircle = SKAction.followPath(kickOffPath.CGPath, asOffset: true, orientToPath: false, duration: 5.0)
        let scaleToAction = SKAction.scaleTo(0.0, duration: 5.0)
        let rotateAction = SKAction.rotateByAngle(CGFloat(-5 * M_PI), duration: 5.0)
        let spriteNode = SKSpriteNode(imageNamed: "green")
        let kickOffActionGroup = SKAction.group([rotateAction,followCircle,scaleToAction])
        let kickOffActionGroup2 = SKAction.group([rotateAction,followCircle,scaleToAction])
        spriteNode.position =  CGPoint(x:CGRectGetMidX(self.frame)+mapWidth/2,y:CGRectGetMidY(self.frame)-mapWidth/2)
        spriteNode.setScale(chessScale)
        self.addChild(spriteNode)
        
        let spriteNode2 = SKSpriteNode(imageNamed: "green")
        spriteNode2.position =  CGPoint(x:CGRectGetMidX(self.frame)+3*mapWidth/2,y:CGRectGetMidY(self.frame)-mapWidth/2)
        spriteNode2.setScale(chessScale)
        self.addChild(spriteNode2)
        spriteNode.runAction(kickOffActionGroup)
        spriteNode2.runAction(kickOffActionGroup2)
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        let location = (touches as NSSet).anyObject()!.locationInNode(self)
        let node = nodeAtPoint(location)
        touched_location = node.position
        touched_node = node
        
        if touched_node!.name != nil{
            if touched_node!.name!.hasPrefix("red") || touched_node!.name!.hasPrefix("green")
            {
                for a in self.children{
                    let a = a as SKNode
                    if a.name != nil{
                        if a.name!.hasPrefix("red") || a.name!.hasPrefix("green"){
                            a.setScale(chessScale)
                        }
                    }
                }
                node.setScale(chessScale_focus)
            }else{
                for a in self.children{
                    let a = a as SKNode
                    if a.name != nil{
                        if a.name!.hasPrefix("red") || a.name!.hasPrefix("green"){
                            a.setScale(chessScale)
                            touched_node = nil
                        }
                    }
                }
            }
        }
    }
    
    func paintBackGround(){
        let bg = SKSpriteNode(imageNamed:"pixiu.jpeg")
        bg.position =  CGPointMake(self.size.width/2, self.size.height/2)
        bg.name = "backImage"
        bg.alpha = 0.2
        bg.setScale(1.5)
        bg.size = CGSize(width: self.size.width/2, height: self.size.height/2)
        bg.name = "backGround"
        self.addChild(bg)
    }
    
    func displayInitSKNode(){
        
        width_blank_space = self.view!.frame.width/8
        mapWidth = width_blank_space*2
        mapHeight = width_blank_space*6
        
        recRange1_Location = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame))
        recRange2_Location = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame))
        
        var pointTemp = CGPoint(x:CGRectGetMidX(self.frame)-mapWidth/2,y:CGRectGetMidY(self.frame)+mapHeight/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)+mapWidth/2,y:CGRectGetMidY(self.frame)+mapHeight/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)+mapWidth/2,y:CGRectGetMidY(self.frame)+mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)+3*mapWidth/2,y:CGRectGetMidY(self.frame)+mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)+3*mapWidth/2,y:CGRectGetMidY(self.frame)-mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)+mapWidth/2,y:CGRectGetMidY(self.frame)-mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)+mapWidth/2,y:CGRectGetMidY(self.frame)-mapHeight/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)-mapWidth/2,y:CGRectGetMidY(self.frame)-mapHeight/2)
        pointsLocation.append(pointTemp)
        
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)-mapWidth/2,y:CGRectGetMidY(self.frame)-mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)-3*mapWidth/2,y:CGRectGetMidY(self.frame)-mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)-3*mapWidth/2,y:CGRectGetMidY(self.frame)+mapWidth/2)
        pointsLocation.append(pointTemp)
        pointTemp = CGPoint(x:CGRectGetMidX(self.frame)-mapWidth/2,y:CGRectGetMidY(self.frame)+mapWidth/2)
        pointsLocation.append(pointTemp)
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Kick You Off";
        myLabel.fontSize = 30;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+mapHeight);
        self.addChild(myLabel)
        
        let recRange1 = SKShapeNode(rectOfSize: CGSize(width: mapWidth, height: mapHeight))
        let recRange2 = SKShapeNode(rectOfSize: CGSize(width: mapHeight, height: mapWidth))
        recRange1.strokeColor = UIColor.grayColor()
        recRange2.strokeColor = UIColor.grayColor()
        recRange1.lineWidth = 5.0
        recRange2.lineWidth = 5.0
        recRange1.position = recRange1_Location!
        recRange2.position = recRange2_Location!
        recRange1.name = "map1"
        recRange2.name = "map2"
        self.addChild(recRange1)
        self.addChild(recRange2)
        
        
        //Add swip gesture
        let swipLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        let swipRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipRightGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        let swipUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipUpGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        let swipDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(swipLeftGestureRecognizer)
        self.view?.addGestureRecognizer(swipRightGestureRecognizer)
        self.view?.addGestureRecognizer(swipUpGestureRecognizer)
        self.view?.addGestureRecognizer(swipDownGestureRecognizer)
        
        //init physices area
        self.physicsWorld.gravity = CGVectorMake(0,0)
        physicsWorld.contactDelegate = self
        
        for i in 0...11 {
            switch skNodeLocation[i]{
            case "1":
                let redSprite = SKSpriteNode(imageNamed:"red")
                redSprite.setScale(chessScale)
                redSprite.position = pointsLocation[i]
                //redSprite.anchorPoint = (x: redSprite.size.height/2, y: redSprite.size.width/2)
                redSprite.physicsBody = SKPhysicsBody(circleOfRadius: redSprite.size.width/2)
                redSprite.physicsBody?.affectedByGravity = false
                redSprite.name = "red_\(i)"
                redSprite.physicsBody!.dynamic = true
                redSprite.physicsBody = SKPhysicsBody(circleOfRadius: redSprite.size.height/2)
                redSprite.physicsBody?.categoryBitMask = physicsCategoryStruct.chessCategory
                redSprite.physicsBody?.contactTestBitMask = physicsCategoryStruct.chessCategory
                chessArray.append(redSprite)
                self.addChild(redSprite)
            case "0":
                let greenSprite = SKSpriteNode(imageNamed:"green")
                greenSprite.setScale(chessScale)
                greenSprite.position = pointsLocation[i]
                //greenSprite.anchorPoint = pointsLocation[i]
                greenSprite.physicsBody = SKPhysicsBody(circleOfRadius: greenSprite.size.width/2)
                greenSprite.physicsBody?.affectedByGravity = false
                greenSprite.name = "green_\(i)"
                
                greenSprite.physicsBody = SKPhysicsBody(circleOfRadius: greenSprite.size.height/2)
                greenSprite.physicsBody?.dynamic = true
                greenSprite.physicsBody?.categoryBitMask = physicsCategoryStruct.chessCategory
                greenSprite.physicsBody?.contactTestBitMask = physicsCategoryStruct.chessCategory
                chessArray.append(greenSprite)
                self.addChild(greenSprite)
            default:
                continue
            }
        }
    }
    
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        //划动的方向
//       let direction = sender.direction
//       let firstPoint = sender.locationOfTouch(sender.numberOfTouches()-1, inView: self.view)

        self.direction_temp = sender.direction
        if touched_node != nil && touched_node!.name != nil
        {
            if touched_node!.name!.hasPrefix("red") || touched_node!.name!.hasPrefix("green")
            {
                let moveOrNot = DeterminSpriteNodeAction(touched_location!,direction: sender.direction)
                switch(moveOrNot){
                case 0:
                    var newLocation = touched_location!
                    newLocation = newLocation as CGPoint
                    
                    switch (direction_temp){
                    case UISwipeGestureRecognizerDirection.Left?:
                        newLocation.x -= mapWidth/4
                        break
                    case UISwipeGestureRecognizerDirection.Right?:
                        newLocation.x += mapWidth/4
                        break
                    case UISwipeGestureRecognizerDirection.Up?:
                        newLocation.y += mapWidth/4
                        break
                    case UISwipeGestureRecognizerDirection.Down?:
                        newLocation.y -= mapWidth/4
                        break
                    default:
                        break;
                    }
                    let moveToAction = SKAction.moveTo(newLocation, duration: 0.3)
                    let scaleAction = SKAction.scaleTo(chessScale, duration: 0.3)
                    let moveBack = SKAction.moveTo(touched_location!, duration: 0.5)
                    let ActionGroup = SKAction.group([moveToAction,scaleAction])
                    let actionSequence = SKAction.sequence([ActionGroup,moveBack])
                    touched_node?.runAction(actionSequence)
                    break;
                case 1:
                    var newLocation = touched_location!
                    newLocation = newLocation as CGPoint

                    switch (direction_temp){
                    case UISwipeGestureRecognizerDirection.Left?:
                        newLocation.x -= mapWidth
                        break
                    case UISwipeGestureRecognizerDirection.Right?:
                        newLocation.x += mapWidth
                        break
                    case UISwipeGestureRecognizerDirection.Up?:
                        newLocation.y += mapWidth
                        break
                    case UISwipeGestureRecognizerDirection.Down?:
                        newLocation.y -= mapWidth
                        break
                    default:
                        break;
                    }
                    let moveToAction = SKAction.moveTo(newLocation, duration: 1)
                    let scaleAction = SKAction.scaleTo(chessScale, duration: 0.5)
                    let ActionGroup = SKAction.group([moveToAction,scaleAction])
                    touched_node?.runAction(ActionGroup)
                    break;
                case 2:
                    var newLocation = touched_location!
                    newLocation = newLocation as CGPoint
                    var newLocation_2 = touched_location!
                    newLocation_2 = newLocation_2 as CGPoint
                    
                    switch (direction_temp){
                    case UISwipeGestureRecognizerDirection.Left?:
                        newLocation.x -= mapWidth
                        newLocation_2.x -= mapWidth*2
                        break
                    case UISwipeGestureRecognizerDirection.Right?:
                        newLocation.x += mapWidth
                        newLocation_2.x += mapWidth*2
                        break
                    case UISwipeGestureRecognizerDirection.Up?:
                        newLocation.y += mapWidth
                        newLocation_2.y += mapWidth*2
                        break
                    case UISwipeGestureRecognizerDirection.Down?:
                        newLocation.y -= mapWidth
                        newLocation_2.y -= mapWidth*2
                        break
                    default:
                        break;
                    }
                    //let kicked_node = nodeAtPoint(newLocation)
                    let touched_node_moveToAction = SKAction.moveTo(newLocation, duration: 1)
                    let scaleAction = SKAction.scaleTo(chessScale, duration: 0.5)
                    let ActionGroup = SKAction.group([touched_node_moveToAction,scaleAction])
                    touched_node?.runAction(ActionGroup)
                    break;
                default:
                    break;
                }
            }
        }

    }
    
    //Determin sknode and move or not
    //move: 1 --> temp1 have no node and available
    //cannot move: 0 --> temp 1 have node and temp2 have no node
    //Kick Off: 2 --> temp1 have node and temp2 have enemy node
    func DeterminSpriteNodeAction(nodeLocation:CGPoint,direction:UISwipeGestureRecognizerDirection)->Int{
        
        var nodeTemp1:SKNode?
        var nodeTemp2:SKNode?
        var nodeTemp1_position:CGPoint?
        var nodeTemp2_position:CGPoint?

        switch (direction){
        case UISwipeGestureRecognizerDirection.Left:
            nodeTemp1_position = CGPoint(x: nodeLocation.x-mapWidth, y: nodeLocation.y)
            nodeTemp2_position = CGPoint(x: nodeLocation.x-mapWidth*2, y: nodeLocation.y)
            break
        case UISwipeGestureRecognizerDirection.Right:
            nodeTemp1_position = CGPoint(x: nodeLocation.x+mapWidth, y: nodeLocation.y)
            nodeTemp2_position = CGPoint(x: nodeLocation.x+mapWidth*2, y: nodeLocation.y)
            break
        case UISwipeGestureRecognizerDirection.Up:
            nodeTemp1_position = CGPoint(x: nodeLocation.x, y: nodeLocation.y+mapWidth)
            nodeTemp2_position = CGPoint(x: nodeLocation.x, y: nodeLocation.y+mapWidth*2)
            break
        case UISwipeGestureRecognizerDirection.Down:
            nodeTemp1_position = CGPoint(x: nodeLocation.x, y: nodeLocation.y-mapWidth)
            nodeTemp2_position = CGPoint(x: nodeLocation.x, y: nodeLocation.y-mapWidth*2)
            break
        default:
            break;
        }
        nodeTemp1 = nodeAtPoint(nodeTemp1_position!)
        nodeTemp2 = nodeAtPoint(nodeTemp2_position!)

        let out1_1 = nodeTemp1_position!.x < centerPoint!.x-3*mapWidth/2-0.1
        let out1_2 = nodeTemp1_position!.y < centerPoint!.y-3*mapWidth/2-0.1
        let out2_1 = nodeTemp1_position!.x > centerPoint!.x+3*mapWidth/2+0.1
        let out2_2 = nodeTemp1_position!.y > centerPoint!.y+3*mapWidth/2+0.1
        
        let out3_1 = nodeTemp1_position!.x > centerPoint!.x+mapWidth/2+0.1
        let out3_2 = nodeTemp1_position!.y < centerPoint!.y-mapWidth/2-0.1
        let out4_1 = nodeTemp1_position!.x > centerPoint!.x+mapWidth/2+0.1
        let out4_2 = nodeTemp1_position!.y > centerPoint!.y+mapWidth/2+0.1
        let out5_1 = nodeTemp1_position!.x < centerPoint!.x-mapWidth/2-0.1
        let out5_2 = nodeTemp1_position!.y > centerPoint!.y+mapWidth/2+0.1
        let out6_1 = nodeTemp1_position!.x < centerPoint!.x-mapWidth/2-0.1
        let out6_2 = nodeTemp1_position!.y < centerPoint!.y-mapWidth/2-0.1
        
        if nodeTemp1 != nil && nodeTemp2 != nil{
            if nodeTemp1!.name!.hasPrefix("red") || nodeTemp1!.name!.hasPrefix("green")
            {
                
                if ((touched_node?.name)! as NSString).substringToIndex(2) != ((nodeTemp1!.name)! as NSString).substringToIndex(2){
                    return 0
                }else if !nodeTemp2!.name!.hasPrefix("red") && !nodeTemp2!.name!.hasPrefix("green"){
                    return 0
                }else if(((nodeTemp2?.name)! as NSString).substringToIndex(2) == ((nodeTemp1!.name)! as NSString).substringToIndex(2))&&(((touched_node?.name)! as NSString).substringToIndex(2) == ((nodeTemp1!.name)! as NSString).substringToIndex(2)){
                    return 0
                }
                else if ((nodeTemp2!.name)! as NSString).substringToIndex(2) != ((nodeTemp1!.name)! as NSString).substringToIndex(2){
                    return 2
                }else{
                    return 1
                }
            }else {
                if out1_1||out1_2||out2_1||out2_2{
                    return 0
                }
                if (out3_1&&out3_2)||(out4_1&&out4_2)||(out5_1&&out5_2)||(out6_1&&out6_2){
                    return 0
                }
                if (out1_1&&out1_2)||(out2_1&&out2_2)||(out3_1&&out3_2)||(out4_1&&out4_2){
                    return 0
                }
            }
            return 1
        }
       return 0
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody?
        var secondBody: SKPhysicsBody?
        
        firstBody = contact.bodyA
        secondBody = contact.bodyB
//        print((firstBody!.node as! SKSpriteNode).name)
//        print((secondBody!.node as! SKSpriteNode).name)
        
        let touched_node_temp = touched_node?.name
        let touched_node_prefix = touched_node_temp?.substringToIndex((touched_node_temp!.characters.indexOf("_"))!)
        
        let firstBody_name = (firstBody!.node as! SKSpriteNode).name
        let firstBody_name_prefix = firstBody_name?.substringToIndex(firstBody_name!.characters.indexOf("_")!)
        
        let secondBody_name = (secondBody!.node as! SKSpriteNode).name
        let secondBody_name_prefix = secondBody_name?.substringToIndex(secondBody_name!.characters.indexOf("_")!)
        
        if(firstBody_name_prefix != secondBody_name_prefix){
            if(firstBody_name_prefix == touched_node_prefix){
                kickOffAnimation(secondBody!.node as! SKSpriteNode)
            }else{
                kickOffAnimation(firstBody!.node as! SKSpriteNode)
            }
        }else{
            if(touched_node_temp == firstBody_name)
            {
                firstBody = contact.bodyA
                secondBody = contact.bodyB
                
            }else{
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }
            kickAnimation(secondBody!.node as! SKSpriteNode)
        }
    }
    
    func kickOffAnimation(spriteNode:SKSpriteNode){

        switch (direction_temp){
        case UISwipeGestureRecognizerDirection.Left?:
            if(spriteNode.position.y > centerPoint?.y){
                executionKickOffAnimation(spriteNode,clockWise: false,arcCenter: CGPoint(x:0,y:3*mapWidth/5),startAngel:CGFloat(M_PI/2),endAngle:CGFloat(3*M_PI/2))
            }else{
                executionKickOffAnimation(spriteNode,clockWise: true,arcCenter: CGPoint(x:0,y:-3*mapWidth/5),startAngel:CGFloat(M_PI/2),endAngle:CGFloat(3*M_PI/2))
            }
            break
        case UISwipeGestureRecognizerDirection.Right?:
            if(spriteNode.position.y > centerPoint?.y){
                executionKickOffAnimation(spriteNode,clockWise: true,arcCenter: CGPoint(x:0,y:3*mapWidth/5),startAngel:CGFloat(M_PI/2),endAngle:CGFloat(3*M_PI/2))
            }else{
                executionKickOffAnimation(spriteNode,clockWise: false,arcCenter: CGPoint(x:0,y:-3*mapWidth/5),startAngel:CGFloat(M_PI/2),endAngle:CGFloat(3*M_PI/2))
            }
            
            break
        case UISwipeGestureRecognizerDirection.Up?:
            if(spriteNode.position.x > centerPoint?.x){
                executionKickOffAnimation(spriteNode,clockWise: false,arcCenter: CGPoint(x:3*mapWidth/5,y:0),startAngel:CGFloat(M_PI),endAngle:CGFloat(2*M_PI))
            }else{
                executionKickOffAnimation(spriteNode,clockWise: true,arcCenter: CGPoint(x:-3*mapWidth/5,y:0),startAngel:CGFloat(0),endAngle:CGFloat(M_PI))
            }
            break
        case UISwipeGestureRecognizerDirection.Down?:
            if(spriteNode.position.x > centerPoint?.x){
                executionKickOffAnimation(spriteNode,clockWise: true,arcCenter: CGPoint(x:3*mapWidth/5,y:0),startAngel:CGFloat(M_PI),endAngle:CGFloat(2*M_PI))
            }else{
                executionKickOffAnimation(spriteNode,clockWise: false,arcCenter: CGPoint(x:-3*mapWidth/5,y:0),startAngel:CGFloat(0),endAngle:CGFloat(M_PI))
            }
            break
        default:
            break;
        }
    }
    
    func executionKickOffAnimation(spriteNode:SKSpriteNode,clockWise:Bool,arcCenter:CGPoint,startAngel:CGFloat,endAngle:CGFloat){
        let kickOffPath = UIBezierPath.init(arcCenter: arcCenter, radius: 3*mapWidth/5, startAngle: startAngel, endAngle: endAngle, clockwise: clockWise)
        let followCircle = SKAction.followPath(kickOffPath.CGPath, asOffset: true, orientToPath: false, duration: 1.0)
        let scaleToAction = SKAction.scaleTo(0.0, duration: 1.0)
        var rotateDirection:Double = -1
        if clockWise == false{
            rotateDirection = 1
        }
        let rotateAction = SKAction.rotateByAngle(CGFloat(rotateDirection * 5 * M_PI), duration: 1.0)

        let kickOffActionGroup = SKAction.group([rotateAction,followCircle,scaleToAction])
        let kickOffActionMoveAway = SKAction.removeFromParent()
        let kickOffActionSequence = SKAction.sequence([kickOffActionGroup,kickOffActionMoveAway])
        spriteNode.runAction(kickOffActionSequence)
    }
    
    func kickAnimation(spriteNode:SKSpriteNode){
        
        var newLocation = touched_location!
        newLocation = newLocation as CGPoint
        
        switch (direction_temp){
        case UISwipeGestureRecognizerDirection.Left?:
            newLocation.x -= mapWidth*2
            break
        case UISwipeGestureRecognizerDirection.Right?:
            newLocation.x += mapWidth*2
            break
        case UISwipeGestureRecognizerDirection.Up?:
            newLocation.y += mapWidth*2
            break
        case UISwipeGestureRecognizerDirection.Down?:
            newLocation.y -= mapWidth*2
            break
        default:
            break;
        }
        let moveToAction = SKAction.moveTo(newLocation, duration: 0.5)
        spriteNode.runAction(moveToAction)
        
    }


}


























