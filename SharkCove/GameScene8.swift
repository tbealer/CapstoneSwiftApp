//
//  GameScene8.swift
//  SharkCove
//
//  Created by Thomas Bealer on 6/1/16.
//  Copyright © 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit



class GameScene8: SKScene, SKPhysicsContactDelegate {
    
    var activebomb: SKSpriteNode!

    var player: SKSpriteNode!
    var shield: SKSpriteNode!
    var bomb: SKSpriteNode!
    var mask: SKSpriteNode!
    var nextbtn: SKSpriteNode!
    var homebtn: SKSpriteNode!
    var sharkIndicator: SKSpriteNode!
//    var wallIndicator: SKSpriteNode!
    
    var lastTouchPosition: CGPoint?
    
    var motionManager: CMMotionManager!
    
    //    var wallLabel: SKLabelNode!
    
    var wall: Int = 0
    
    //        {
    //        didSet {
    //            wallLabel.text = "wall: \(wall)"
    //        }
    //    }
    
    //    var sharkLabel: SKLabelNode!
    
    var shark: Int = 0
    //        {
    //        didSet {
    //            sharkLabel.text = "shark: \(shark)"
    //        }
    //    }
    
    var bombLabel: SKLabelNode!
    
    var bomb1: Int = 0 {
        didSet {
            bombLabel.text = "X \(bomb1)"
        }
    }
    
    //    var bomb2Label: SKLabelNode!
    
    var bomb2: Int = 0
    
    //        {
    //        didSet {
    //            bomb2Label.text = "Active Bombs: \(bomb2)"
    //        }
    //    }
    
    
    var mask1: Int = 0
    
    
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
        
        sharkIndicator = SKSpriteNode(imageNamed: "gameshark")
        sharkIndicator.position = CGPoint(x: 200, y: 630)
        sharkIndicator.anchorPoint = CGPointMake(0.0, 0.5)
        sharkIndicator.zPosition = 4
        addChild(sharkIndicator)
        
//        wallIndicator = SKSpriteNode(imageNamed: "coral")
//        wallIndicator.position = CGPoint(x: 50, y: 630)
//        wallIndicator.anchorPoint = CGPointMake(0.0, 0.5)
//        wallIndicator.zPosition = 4
//        addChild(wallIndicator)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        
        
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
        
        loadLevel()
        makeJoint()
        
        //        wallLabel = SKLabelNode(fontNamed: "Chalkduster")
        //        wallLabel.text = "Walls: 0"
        //        wallLabel.horizontalAlignmentMode = .Left
        //        wallLabel.position = CGPoint(x: 50, y: 630)
        //        addChild(wallLabel)
        
        //        sharkLabel = SKLabelNode(fontNamed: "Chalkduster")
        //        sharkLabel.text = "Sharks: 0"
        //        sharkLabel.horizontalAlignmentMode = .Left
        //        sharkLabel.position = CGPoint(x: 200, y: 630)
        //        addChild(sharkLabel)
        
        let bombthing = SKSpriteNode(imageNamed: "therealbomb")
        bombthing.position = CGPoint(x: 475, y: 630)
        addChild(bombthing)
        
        bombLabel = SKLabelNode(fontNamed: "Chalkduster")
        bombLabel.text = "X 0"
        bombLabel.horizontalAlignmentMode = .Left
        bombLabel.position = CGPoint(x: 500, y: 630)
        addChild(bombLabel)
        
        let lvlindicator = SKSpriteNode(imageNamed: "thereallvl8btn")
        lvlindicator.position = CGPoint(x: 100, y: 130)
        addChild(lvlindicator)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let bombs = defaults.integerForKey("bombs")
        bomb1 = bombs
        
        //        bomb2Label = SKLabelNode(fontNamed: "Chalkduster")
        //        bomb2Label.text = "Active Bombs: 0"
        //        bomb2Label.horizontalAlignmentMode = .Left
        //        bomb2Label.position = CGPoint(x: 700, y: 630)
        //        addChild(bomb2Label)
        
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
    }
    
    func loadLevel() {
        if let levelPath = NSBundle.mainBundle().pathForResource("level8", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath, usedEncoding: nil) {
                let lines = levelString.componentsSeparatedByString("\n")
                
                for (row, line) in lines.reverse().enumerate() {
                    for (column, letter) in line.characters.enumerate() {
                        let position = CGPoint(x: (51 * column) + 25, y: (55 * row) + 130)
                        
                        if letter == "s" {
                            // load wall
                            let node = SKSpriteNode(imageNamed: "gameshark")
                            node.position = position
                            
                            let bubbles = SKSpriteNode(imageNamed: "bubbles")
                            bubbles.position = position
                            bubbles.name = "bubbles"
                            bubbles.hidden = false
                            
                            node.alpha = 0.6
                            node.hidden = true
                            node.name = "shark"
                            
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.categoryBitMask = CollisionTypes.Shark.rawValue
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.dynamic = false
                            addChild(node)
                            addChild(bubbles)
                        } else if letter == "x"  {
                            // load vortex
                            let node = SKSpriteNode(imageNamed: "coral")
                            node.name = "wall"
                            node.alpha = 0.3
                            node.hidden = false
                            
                            node.position = position
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.categoryBitMask = CollisionTypes.Wall.rawValue
                            node.physicsBody!.dynamic = false
                            
                            addChild(node)
                        } else if letter == "m"  {
                            // load star
                            let node = SKSpriteNode(imageNamed: "therealsonar")
                            node.name = "mask"
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.dynamic = false
                            //                            node.alpha = 0.5
                            node.hidden = true
                            
                            let bubbles = SKSpriteNode(imageNamed: "bubbles")
                            bubbles.position = position
                            bubbles.name = "bubbles"
                            bubbles.hidden = false
                            
                            node.physicsBody!.categoryBitMask = CollisionTypes.Mask.rawValue
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.collisionBitMask = 0
                            node.position = position
                            addChild(node)
                            addChild(bubbles)
                        } else if letter == "b"  {
                            // load star
                            let node = SKSpriteNode(imageNamed: "therealbomb")
                            node.name = "bomb"
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.dynamic = false
                            //                            node.alpha = 0.5
                            node.hidden = true
                            
                            let bubbles = SKSpriteNode(imageNamed: "bubbles")
                            bubbles.position = position
                            bubbles.name = "bubbles"
                            bubbles.hidden = false
                            
                            node.physicsBody!.categoryBitMask = CollisionTypes.Bomb.rawValue
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.collisionBitMask = 0
                            node.position = position
                            addChild(node)
                            addChild(bubbles)
                        } else if letter == "t"  {
                            // load finish
                            let node = SKSpriteNode(imageNamed: "therealtreasure")
                            node.name = "treasure"
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.dynamic = false
                            
                            node.alpha = 0.6
                            node.hidden = true
                            
                            let bubbles = SKSpriteNode(imageNamed: "bubbles")
                            bubbles.position = position
                            bubbles.name = "bubbles"
                            bubbles.hidden = false
                            
                            node.physicsBody!.categoryBitMask = CollisionTypes.Treasure.rawValue
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.collisionBitMask = 0
                            node.position = position
                            addChild(node)
                            addChild(bubbles)
                            
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    func sonarFunc () {
        
        mask1 = 1
        
        
        
        player.physicsBody!.dynamic = true
        
        let wait = SKAction.waitForDuration(5.0)
        let run = SKAction.runBlock {
            //NEW
            
            
            
            self.mask1 = 0
            
            
        }
        player.runAction(SKAction.sequence([wait, run]))
        
        
    }
    
    func sharkindicator () {
        
        
        
        if shark == 0 {
            
            let action = SKAction.scaleXTo(1.0, y: 1.0, duration: 0.5)
            sharkIndicator.runAction(action)
            
        } else if shark == 1 {
            
            let action = SKAction.scaleXTo(1.2, y: 1.2, duration: 0.5)
            sharkIndicator.runAction(action)
        } else if shark == 2 {
            
            let action = SKAction.scaleXTo(1.4, y: 1.4, duration: 0.5)
            sharkIndicator.runAction(action)
            
        } else if shark == 3 {
            let action = SKAction.scaleXTo(1.6, y: 1.6, duration: 0.5)
            sharkIndicator.runAction(action)
        } else if shark == 4 {
            let action = SKAction.scaleXTo(1.8, y: 1.8, duration: 0.5)
            sharkIndicator.runAction(action)
        } else if shark == 5 {
            let action = SKAction.scaleXTo(2.0, y: 2.0, duration: 0.5)
            sharkIndicator.runAction(action)
        }
        else if shark == 6 {
            let action = SKAction.scaleXTo(2.2, y: 2.2, duration: 0.5)
            sharkIndicator.runAction(action)
        }
    }
    
//    func wallindicator () {
//        
//        
//        
//        if wall == 1 {
//            
//            let action = SKAction.scaleXTo(1.2, y: 1.2, duration: 0.5)
//            wallIndicator.runAction(action)
//        } else if wall == 2 {
//            
//            let action = SKAction.scaleXTo(1.4, y: 1.4, duration: 0.5)
//            wallIndicator.runAction(action)
//            
//        } else if wall == 3 {
//            let action = SKAction.scaleXTo(1.6, y: 1.6, duration: 0.5)
//            wallIndicator.runAction(action)
//        } else if wall == 4 {
//            let action = SKAction.scaleXTo(1.8, y: 1.8, duration: 0.5)
//            wallIndicator.runAction(action)
//        } else if wall == 5 {
//            let action = SKAction.scaleXTo(2.0, y: 2.0, duration: 0.5)
//            wallIndicator.runAction(action)
//        }
//        else if wall == 6 {
//            let action = SKAction.scaleXTo(2.2, y: 2.2, duration: 0.5)
//            wallIndicator.runAction(action)
//        }
//        else if wall == 7 {
//            let action = SKAction.scaleXTo(2.4, y: 2.2, duration: 0.5)
//            wallIndicator.runAction(action)
//        }
//        else if wall == 8 {
//            let action = SKAction.scaleXTo(2.6, y: 2.2, duration: 0.5)
//            wallIndicator.runAction(action)
//        }
//    }
    
    
    
    func makeJoint () {
        
        
        player = SKSpriteNode(imageNamed: "therealsub")
        player.position = CGPoint(x: 70, y: 550)
        player.anchorPoint = CGPoint(x:0.5,y:0.5)
        
        player.userInteractionEnabled = false
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 3)
        player.physicsBody!.allowsRotation = false
        player.physicsBody!.linearDamping = 0.5
        
        player.physicsBody!.categoryBitMask = CollisionTypes.Player.rawValue
        player.physicsBody!.contactTestBitMask = CollisionTypes.Bomb.rawValue | CollisionTypes.Wall.rawValue | CollisionTypes.Treasure.rawValue | CollisionTypes.Mask.rawValue
        
        player.physicsBody!.collisionBitMask = CollisionTypes.Shark.rawValue
        player.physicsBody!.collisionBitMask = CollisionTypes.Wall.rawValue
        
        addChild(player)
        
        
        
        shield = SKSpriteNode(imageNamed: "block")
        shield.alpha = 0.5
        shield.hidden = true
        
        shield.position = CGPointMake(player.position.x / 30, player.position.y / 30)
        shield.physicsBody = SKPhysicsBody(circleOfRadius: shield.size.width * 1.5
        )
        shield.physicsBody!.categoryBitMask = CollisionTypes.Shield.rawValue
        shield.physicsBody!.contactTestBitMask = CollisionTypes.Bomb.rawValue | CollisionTypes.Wall.rawValue | CollisionTypes.Treasure.rawValue | CollisionTypes.Shark.rawValue | CollisionTypes.Mask.rawValue
        shield.physicsBody!.collisionBitMask = 0
        
        player.addChild(shield)
        
        
        
        let joint = SKPhysicsJointFixed.jointWithBodyA(player.physicsBody!, bodyB: shield.physicsBody!, anchor: CGPointMake(CGRectGetMidX(player.frame) / 2, CGRectGetMidY(player.frame) / 2 ))
        
        physicsWorld.addJoint(joint)
        
        
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            lastTouchPosition = location
            
            if(player.containsPoint(location) && (bomb1 > 0))
            {
                
                bomb2 += 1
                activebomb = SKSpriteNode(imageNamed: "therealactivebomb")
                activebomb.position = CGPoint(x: 475, y: 630)
                addChild(activebomb)
                self.bomb1 -= 1
            }
            
        }
    }
    
  
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            lastTouchPosition = location
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(currentTime: CFTimeInterval) {
        if !gameOver {
            #if (arch(i386) || arch(x86_64))
                if let currentTouch = lastTouchPosition {
                    
                    
                    
                    
                    
                    let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
                    physicsWorld.gravity = CGVector(dx: diff.x / 150, dy: diff.y / 150)
                    if let body = player.physicsBody {
                        if (body.velocity.speed() > 0.01) {
                            let offset = CGFloat(M_PI_2)
                            player.zRotation = body.velocity.angle() - offset
                        }
                    }
                }
            #else
                if let accelerometerData = motionManager.accelerometerData {
                    physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -5, dy: accelerometerData.acceleration.x * 5)
                    if let body = player.physicsBody {
                        if (body.velocity.speed() > 0.01) {
                            let offset = CGFloat(M_PI_2)
                            player.zRotation = body.velocity.angle() - offset
                        }
                    }
                }
            #endif
        }
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node == player {
            playerCollidedWithNode(contact.bodyB.node!)
        } else if contact.bodyB.node == player {
            playerCollidedWithNode(contact.bodyA.node!)
        } else if contact.bodyA.node == shield{
            shieldCollidedWithNode(contact.bodyB.node!)
        } else if contact.bodyB.node == shield {
            shieldCollidedWithNode(contact.bodyA.node!)
        }
    }
    
    
    
    func shieldCollidedWithNode(node: SKNode) {
        
        if (mask1 >= 1) {
            
            if node.name == "wall" {
//                wall += 1
//                wallindicator()
//                node.hidden = false
                    node.alpha = 1
            } else if node.name == "treasure" {
                node.hidden = false
            } else if node.name == "shark" {
                shark += 1
                sharkindicator()
                node.hidden = false
            } else if node.name == "bomb" {
                node.hidden = false
            } else if node.name == "mask" {
                node.hidden = false
            }
            
        } else {
            if node.name == "wall" {
//                wall += 1
//                wallindicator()
                
            }  else if node.name == "shark" {
                shark += 1
                sharkindicator()
            }
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if contact.bodyA.node == shield{
            shieldLeftNode(contact.bodyB.node!)
        } else if contact.bodyB.node == shield {
            shieldLeftNode(contact.bodyA.node!)
        }
    }
    
    
    func shieldLeftNode(node: SKNode) {
        if (mask1 == 1) {
            
            if node.name == "wall" {
//                wall -= 1
//                wallindicator()
//                node.hidden = true
                    node.alpha = 0.3
            } else if node.name == "treasure" {
                node.hidden = true
            } else if node.name == "shark" {
                shark -= 1
                sharkindicator()
                node.hidden = true
            } else if node.name == "bomb" {
                node.hidden = true
            } else if node.name == "mask" {
                node.hidden = true
            }
            
        } else {
            if node.name == "wall" {
//                wall -= 1
//                wallindicator()
//                node.hidden = true
                
            }  else if node.name == "shark" {
                shark -= 1
                sharkindicator()
                node.hidden = true
                
            } else if node.name == "bomb" {
                node.hidden = true
            } else if node.name == "mask" {
                node.hidden = true
            }
        }
        
    }
    
    
    
    func playerCollidedWithNode(node: SKNode) {
        if node.name == "shark" {
            
            if (bomb2 >= 1) {
                
                if(node.name == "shark"){
                    let blood = SKSpriteNode(imageNamed: "bloodfinal")
                    blood.position = node.position
                    blood.name = "blood"
                    blood.alpha = 0.5
                    
                    
                    
                    addChild(blood)
                    node.removeFromParent()
                    shark -= 1
                    bomb2 = 0
                    activebomb.removeFromParent()
                }
            } else {
                
                player.physicsBody!.dynamic = false
                gameOver = true
                
                node.hidden = false
                node.alpha = 1
                
                let scale = SKAction.scaleTo(0.0001, duration: 0.25)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([ scale, remove])
                
                player.runAction(sequence) { [unowned self] in
                    self.shark = 0
                    self.wall = 0
                    node.hidden = true
                    node.alpha = 0.5
                    
                    self.makeJoint()
                    self.gameOver = false
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0)
                    
                    let nextScene = GameOverScene8(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                
                
            }
            
        } else if node.name == "treasure" {
            
            func updatedefaults () {
                
                
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setInteger(1, forKey: "comp9")
                defaults.setInteger(bomb1, forKey: "bombs")
                
                let this = defaults.integerForKey("comp9")
                
                print("updated ", this)
                
                
            }
            
            updatedefaults()
            //            player.physicsBody!.dynamic = false
            gameOver = true
            
            node.hidden = false
            node.alpha = 1
            
            
            let move = SKAction.moveTo(node.position, duration: 0.25)
            let scale = SKAction.scaleTo(0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            
            
            player.runAction(sequence) { [unowned self] in
                
                self.shark = 0
                self.wall = 0
                //                self.treasure = 0
                
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0)
                
                let nextScene = SuccessScene8(size: self.scene!.size)
                nextScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene!.view!.presentScene(nextScene, transition: transition)
                
                
                self.makeJoint()
                self.gameOver = true
                
                
            }
            
        } else if node.name == "bomb" {
            
            player.physicsBody!.dynamic = false
            
            
            let bombalert = SKSpriteNode(imageNamed: "therealbomb")
            bombalert.position = CGPoint(x: 500, y: 400)
            addChild(bombalert)
            
            let action = SKAction.scaleXTo(4.0, y: 4.0, duration: 0.5)
            bombalert.runAction(action)
            
            
            let wait = SKAction.waitForDuration(1.0)
            let run = SKAction.runBlock {
                
                let shrink = SKAction.scaleXTo(1.0, y: 1.0, duration: 0.5)
                
                
                bombalert.runAction(shrink)
                bombalert.removeFromParent()
                self.player.physicsBody!.dynamic = true
                
            }
            player.runAction(SKAction.sequence([wait, run]))
            self.bomb1 += 1
            
            node.removeFromParent()
            
            
        } else if node.name == "mask" {
            
            player.physicsBody!.dynamic = false
            
            let sonarindicator = SKSpriteNode(imageNamed: "therealsonar")
            sonarindicator.position = CGPoint(x: 750, y: 630)
            addChild(sonarindicator)
            
            let sonaralert = SKSpriteNode(imageNamed: "therealsonar")
            sonaralert.position = CGPoint(x: 500, y: 400)
            addChild(sonaralert)
            
            let action = SKAction.scaleXTo(4.0, y: 4.0, duration: 0.5)
            sonaralert.runAction(action)
            
            
            let wait = SKAction.waitForDuration(1.0)
            let run = SKAction.runBlock {
                
                let shrink = SKAction.scaleXTo(1.0, y: 1.0, duration: 0.5)
                
                self.sonarFunc()
                sonaralert.runAction(shrink)
                sonaralert.removeFromParent()
            }
            player.runAction(SKAction.sequence([wait, run]))
            
            let timed = SKAction.waitForDuration(7)
            let run1 = SKAction.runBlock {
                
                sonarindicator.removeFromParent()
                
            }
            
            player.runAction(SKAction.sequence([timed, run1]))
            
            node.removeFromParent()
            
            
        }

    }
}