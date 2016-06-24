//
//  GameScene.swift
//  KickOff
//
//  Created by Miao, Bobby X. -ND on 6/22/16.
//  Copyright (c) 2016 Miao, Bobby X. -ND. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var width_blank_space:CGFloat = 0.0
    var mapWidth:CGFloat = 0
    var mapHeight:CGFloat = 0
    var recRange1_Location:CGPoint?
    var recRange2_Location:CGPoint?
    var centerPoint:CGPoint?
    var pointsLocation:[CGPoint] = [CGPoint]()
    var skNodeLocation:[String] = [String](arrayLiteral: "1","1","1","x","x","0","0","0","0","x","x","1")
    let chessScale:CGFloat = 0.6
    let chessScale_focus:CGFloat = 0.7
    //
    var direction_temp:UISwipeGestureRecognizerDirection?
    var touched_location:CGPoint?
    var touched_node:SKNode?
    //move order
    var moveOrder:Bool = true
    
    //Phycics
    
    override func didMoveToView(view: SKView) {
        centerPoint = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame))
        self.removeAllChildren()
        paintBackGround()
        displayInitSKNode()
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
        
        for i in 0...11 {
            switch skNodeLocation[i]{
            case "1":
                let redSprite = SKSpriteNode(imageNamed:"red")
                redSprite.setScale(0.6)
                redSprite.position = pointsLocation[i]
                redSprite.physicsBody = SKPhysicsBody(circleOfRadius: redSprite.size.width/2)
                redSprite.physicsBody?.affectedByGravity = false
                redSprite.name = "red_\(i)"
                self.addChild(redSprite)
            case "0":
                let greenSprite = SKSpriteNode(imageNamed:"green")
                greenSprite.setScale(0.6)
                greenSprite.position = pointsLocation[i]
                greenSprite.physicsBody = SKPhysicsBody(circleOfRadius: greenSprite.size.width/2)
                greenSprite.physicsBody?.affectedByGravity = false
                greenSprite.name = "green_\(i)"
                self.addChild(greenSprite)
            default:
                continue
            }
        }
    }
    
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        //划动的方向
//       let direction = sender.direction
//        let firstPoint = sender.locationOfTouch(sender.numberOfTouches()-1, inView: self.view)

        self.direction_temp = sender.direction
        if touched_node != nil && touched_node!.name != nil
        {
            if touched_node!.name!.hasPrefix("red") || touched_node!.name!.hasPrefix("green")
            {
                let moveOrNot = DeterminSpriteNodeAction(touched_location!,direction: sender.direction)
                switch(moveOrNot){
                case 0:
                    break;
                case 1:
                    var newLocation = touched_location!
                    newLocation = newLocation as CGPoint
                    newLocation.x -= mapWidth
                    let moveToAction = SKAction.moveTo(newLocation, duration: 1)
                    touched_node?.runAction(moveToAction)
                    break;
                case 2:
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
        print(nodeLocation)
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
        print(nodeTemp1_position)
        print(centerPoint!.y-3*mapWidth/2)
        print(centerPoint)
        var out1_1 = nodeTemp1_position!.x < centerPoint!.x-3*mapWidth/2
        var out1_2 = nodeTemp1_position!.y < centerPoint!.y-3*mapWidth/2
        var out2_1 = nodeTemp1_position!.x > centerPoint!.x+3*mapWidth/2
        var out2_2 = nodeTemp1_position!.y > centerPoint!.y+3*mapWidth/2
        
        var out3_1 = nodeTemp1_position!.x > centerPoint!.x+mapWidth/2
        var out3_2 = nodeTemp1_position!.y < centerPoint!.y-mapWidth/2
        var out4_1 = nodeTemp1_position!.x > centerPoint!.x+mapWidth/2
        var out4_2 = nodeTemp1_position!.y > centerPoint!.y+mapWidth/2
        var out5_1 = nodeTemp1_position!.x < centerPoint!.x-mapWidth/2
        var out5_2 = nodeTemp1_position!.y > centerPoint!.y+mapWidth/2
        var out6_1 = nodeTemp1_position!.x < centerPoint!.x-mapWidth/2
        var out6_2 = nodeTemp1_position!.y < centerPoint!.y-mapWidth/2
        if nodeTemp1 != nil && nodeTemp2 != nil{
            if nodeTemp1!.name!.hasPrefix("red") || nodeTemp1!.name!.hasPrefix("green")
            {
                
                if ((touched_node?.name)! as NSString).substringToIndex(2) != ((nodeTemp1!.name)! as NSString).substringToIndex(2){
                    return 0
                }
                if ((nodeTemp2!.name)! as NSString).substringToIndex(2) != ((nodeTemp1!.name)! as NSString).substringToIndex(2){
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

}


























