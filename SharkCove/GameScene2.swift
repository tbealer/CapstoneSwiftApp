//
//  GameScene.swift
//  SharkCove
//
//  Created by Thomas Bealer on 5/27/16.
//  Copyright (c) 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit



class GameScene2: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var shield: SKSpriteNode!
    var bomb: SKSpriteNode!
    var mask: SKSpriteNode!
    
    var lastTouchPosition: CGPoint?
    
    var motionManager: CMMotionManager!
    
    var wallLabel: SKLabelNode!
    
    var wall: Int = 0 {
        didSet {
            wallLabel.text = "wall: \(wall)"
        }
    }
    
    var sharkLabel: SKLabelNode!
    
    var shark: Int = 0 {
        didSet {
            sharkLabel.text = "shark: \(shark)"
        }
    }
    
    var bombLabel: SKLabelNode!
    
    var bomb1: Int = 0 {
        didSet {
            bombLabel.text = "Bombs: \(bomb1)"
        }
    }
    
    var bomb2Label: SKLabelNode!
    
    var bomb2: Int = 0 {
        didSet {
            bomb2Label.text = "Active Bombs: \(bomb2)"
        }
    }
    
    
    var mask1: Int = 0
    
    
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
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
        
        wallLabel = SKLabelNode(fontNamed: "Chalkduster")
        wallLabel.text = "Walls: 0"
        wallLabel.horizontalAlignmentMode = .Left
        wallLabel.position = CGPoint(x: 50, y: 630)
        addChild(wallLabel)
        
        sharkLabel = SKLabelNode(fontNamed: "Chalkduster")
        sharkLabel.text = "Sharks: 0"
        sharkLabel.horizontalAlignmentMode = .Left
        sharkLabel.position = CGPoint(x: 200, y: 630)
        addChild(sharkLabel)
        
        bombLabel = SKLabelNode(fontNamed: "Chalkduster")
        bombLabel.text = "Bombs: 0"
        bombLabel.horizontalAlignmentMode = .Left
        bombLabel.position = CGPoint(x: 500, y: 630)
        addChild(bombLabel)
        
        bomb2Label = SKLabelNode(fontNamed: "Chalkduster")
        bomb2Label.text = "Active Bombs: 0"
        bomb2Label.horizontalAlignmentMode = .Left
        bomb2Label.position = CGPoint(x: 700, y: 630)
        addChild(bomb2Label)
        
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
    }
    
    func loadLevel() {
        if let levelPath = NSBundle.mainBundle().pathForResource("level2", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath, usedEncoding: nil) {
                let lines = levelString.componentsSeparatedByString("\n")
                
                for (row, line) in lines.reverse().enumerate() {
                    for (column, letter) in line.characters.enumerate() {
                        let position = CGPoint(x: (51 * column) + 25, y: (55 * row) + 120)
                        
                        if letter == "s" {
                            // load wall
                            let node = SKSpriteNode(imageNamed: "gameshark")
                            node.position = position
                            
                            let bubbles = SKSpriteNode(imageNamed: "bubbles")
                            bubbles.position = position
                            bubbles.name = "bubbles"
                            bubbles.hidden = false
                            
                            node.alpha = 0.5
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
                            node.hidden = true
                            
                            node.position = position
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.categoryBitMask = CollisionTypes.Wall.rawValue
                            node.physicsBody!.dynamic = false
                            
                            addChild(node)
                        } else if letter == "m"  {
                            // load star
                            let node = SKSpriteNode(imageNamed: "rsz_mask-sprite-final")
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
                            let node = SKSpriteNode(imageNamed: "rsz_bomb-sprite-final")
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
                            let node = SKSpriteNode(imageNamed: "treasure")
                            node.name = "treasure"
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.dynamic = false
                            
                            node.alpha = 0.3
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
    
    
    func makeJoint () {
        
        
        player = SKSpriteNode(imageNamed: "swimmerfinal")
        player.position = CGPoint(x: 70, y: 500)
        player.anchorPoint = CGPoint(x:0.5,y:0.5)
        
        player.userInteractionEnabled = false
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
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
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            lastTouchPosition = location
            
            if(player.containsPoint(location))
            {
                if(bomb1 > 0){
                    bombFunc()
                }
                let alert = UIAlertController(title: "Bomb is activated!", message: "The next Shark you touch is toast!!", preferredStyle: UIAlertControllerStyle.ActionSheet)
                
                self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
                let triggerTime = (Int64(NSEC_PER_SEC) * 1)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    self.view?.window?.rootViewController?.dismissViewControllerAnimated( true, completion: nil)
                })
            }
            
            
        }
    }
    
    func bombFunc () {
        bomb2 += 1
        bomb1 -= 1
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
                wall += 1
                node.hidden = false
                
            } else if node.name == "treasure" {
                node.hidden = false
            } else if node.name == "shark" {
                shark += 1
                node.hidden = false
            } else if node.name == "bomb" {
                node.hidden = false
            } else if node.name == "mask" {
                node.hidden = false
            }
            
        } else {
            if node.name == "wall" {
                wall += 1
                
            }  else if node.name == "shark" {
                shark += 1
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
                wall -= 1
                node.hidden = true
                
            } else if node.name == "treasure" {
                node.hidden = true
            } else if node.name == "shark" {
                shark -= 1
                node.hidden = true
            } else if node.name == "bomb" {
                node.hidden = true
            } else if node.name == "mask" {
                node.hidden = true
            }
            
        } else {
            if node.name == "wall" {
                wall -= 1
                
            }  else if node.name == "shark" {
                shark -= 1
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
                    bomb2 -= 1
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
                    
                }
                
                
            }
            
        } else if node.name == "treasure" {
            player.physicsBody!.dynamic = false
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
                
                
                self.makeJoint()
                self.gameOver = true
                
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                
                let nextScene = GameScene2(size: self.scene!.size)
                nextScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene!.view!.presentScene(nextScene, transition: transition)
                
            }
            
        } else if node.name == "bomb" {
            
            
            self.bomb1 += 1
            
            node.removeFromParent()
            
            let alert = UIAlertController(title: "You Picked Up a Shark Bomb!", message: "To activate simply tap the swimmer! The next shark you run into will be toast!", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            let triggerTime = (Int64(NSEC_PER_SEC) * 2)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.view?.window?.rootViewController?.dismissViewControllerAnimated( true, completion: nil)
            })
            
            
            
            
            
            // next level?
        } else if node.name == "mask" {
            
            self.mask1 += 1
            
            node.removeFromParent()
            
            let alert = UIAlertController(title: "You Picked Up a Mask!", message: "Now obstacles within a small radius are visible", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.view?.window?.rootViewController?.dismissViewControllerAnimated( true, completion: nil)
            })
            
            // next level?
        }
    }
}
