//
//  LevelMenuScene2.swift
//  SharkCove
//
//  Created by Thomas Bealer on 6/1/16.
//  Copyright © 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit

class LevelMenuScene2: SKScene, SKPhysicsContactDelegate {
    
    var homebutton: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var level6:SKSpriteNode!
    var level7:SKSpriteNode!
    var level8:SKSpriteNode!
    var level9:SKSpriteNode!
    var level10:SKSpriteNode!
    var previouslevels:SKSpriteNode!
    var locked: SKSpriteNode!
    var locked2: SKSpriteNode!
    var locked3: SKSpriteNode!
    var locked4: SKSpriteNode!
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        
        
        
        
        
        
        loadLevel()
        addButtons()
        
    }
    
    func loadLevel() {
        if let levelPath = NSBundle.mainBundle().pathForResource("mainMenu", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath, usedEncoding: nil) {
                let lines = levelString.componentsSeparatedByString("\n")
                
                for (row, line) in lines.reverse().enumerate() {
                    for (column, letter) in line.characters.enumerate() {
                        let position = CGPoint(x: (51 * column) + 25, y: (55 * row) + 130)
                        
                        if letter == "s" {
                            
                            let node = SKSpriteNode(imageNamed: "gameshark")
                            node.position = position
                            
                            
                            node.name = "shark"
                            
                            
                            addChild(node)
                            
                        } else if letter == "x"  {
                            
                            let node = SKSpriteNode(imageNamed: "coral")
                            node.name = "wall"
                            
                            
                            node.position = position
                            
                            
                            addChild(node)
                        }
                    }
                }
            }
        }
        
    }
    
    func addButtons () {
        
        locked = SKSpriteNode(imageNamed: "vortex")
        locked.position = CGPoint(x: 400, y: 400)
        locked.zPosition = 1
        
        locked2 = SKSpriteNode(imageNamed: "vortex")
        locked2.position = CGPoint(x: 400, y: 300)
        locked2.zPosition = 1
        
        locked3 = SKSpriteNode(imageNamed: "vortex")
        locked3.position = CGPoint(x: 500, y: 500)
        locked3.zPosition = 1
        
        locked4 = SKSpriteNode(imageNamed: "vortex")
        locked4.position = CGPoint(x: 500, y: 400)
        locked4.zPosition = 1
        
       
        
        
        level6 = SKSpriteNode(imageNamed: "star")
//        level6.text = "Level 6"
//        level6.fontSize = 20
        level6.name = "level6"
        level6.zPosition = 1
        level6.position = CGPoint(x: 400, y: 500)
        
        addChild(level6)
        
        level7 = SKSpriteNode(imageNamed: "star")
//        level7.text = "Level 7"
//        level7.fontSize = 20
        level7.name = "level7"
        level7.zPosition = 1
        level7.position = CGPoint(x: 400, y: 400)
        
        func updatelvl7 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp7")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked)
                
            } else  {
                
                addChild(level7)
            }
        }
        updatelvl7()
        
        level8 = SKSpriteNode(imageNamed: "star")
//        level8.text = "Level 8"
//        level8.fontSize = 20
        level8.name = "level8"
        level8.zPosition = 1
        level8.position = CGPoint(x: 400, y: 300)
        
        
        func updatelvl8 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp8")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked2)
                
            } else  {
                
                addChild(level8)
            }
        }
        updatelvl8()
        
        
        
        level9 = SKSpriteNode(imageNamed: "star")
//        level9.text = "Level 9"
//        level9.fontSize = 20
        level9.name = "level9"
        level9.zPosition = 1
        level9.position = CGPoint(x: 500, y: 500)
        
        
        func updatelvl9 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp9")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked3)
                
            } else  {
                
                addChild(level9)
            }
        }
        updatelvl9()
        
        level10 = SKSpriteNode(imageNamed: "star")
//        level10.text = "Level 10"
//        level10.fontSize = 20
        level10.name = "level10"
        level10.zPosition = 1
        level10.position = CGPoint(x: 500, y: 400)
        
        
        func updatelvl10 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp10")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked4)
                
            } else  {
                
                addChild(level10)
            }
        }
        updatelvl10()
        
        previouslevels = SKSpriteNode(imageNamed: "star")
//        previouslevels.text = "Previous Levels"
//        previouslevels.fontSize = 20
        previouslevels.name = "previouslevels"
        previouslevels.zPosition = 1
        previouslevels.position = CGPoint(x: 500, y: 300)
        
        
        addChild(previouslevels)
        
        let homebutton = SKSpriteNode(imageNamed: "homebtnfinal")
        homebutton.name = "homebutton"
        homebutton.zPosition = 1
        homebutton.position = CGPoint(x: 450, y: 200)
        addChild(homebutton)
        
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "level6"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene6(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                    
                else if name == "level7"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene7(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                else if name == "level8"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene8(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                else if name == "level9"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene9(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                else if name == "level10"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene10(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
               
                else if name == "previouslevels"{
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = LevelMenuScene(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                }
                else if name == "homebutton"{
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                }
            }
        }
    }
    
    
    
    
}