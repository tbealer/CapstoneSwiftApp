//
//  LevelMenuScene.swift
//  SharkCove
//
//  Created by Thomas Bealer on 6/1/16.
//  Copyright © 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit

class LevelMenuScene: SKScene, SKPhysicsContactDelegate {
    
    var homebutton: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var level1: SKSpriteNode!
    var level2: SKSpriteNode!
    var level3: SKSpriteNode!
    var level4: SKSpriteNode!
    var level5: SKSpriteNode!
    var morelevels:SKSpriteNode!
    var locked: SKSpriteNode!
    var locked2: SKSpriteNode!
    var locked3: SKSpriteNode!
    var locked4: SKSpriteNode!
    var locked5: SKSpriteNode!

    
    
    
    
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
        
        locked = SKSpriteNode(imageNamed: "thereallockedbtn")
        locked.position = CGPoint(x: 300, y: 400)
        locked.zPosition = 1
        
        locked2 = SKSpriteNode(imageNamed: "thereallockedbtn")
        locked2.position = CGPoint(x: 300, y: 300)
        locked2.zPosition = 1
        
        locked3 = SKSpriteNode(imageNamed: "thereallockedbtn")
        locked3.position = CGPoint(x: 700, y: 500)
        locked3.zPosition = 1
        
        locked4 = SKSpriteNode(imageNamed: "thereallockedbtn")
        locked4.position = CGPoint(x: 700, y: 400)
        locked4.zPosition = 1
        
        locked5 = SKSpriteNode(imageNamed: "thereallockedbtn")
        locked5.position = CGPoint(x: 700, y: 300)
        locked5.zPosition = 1
        
        level1 = SKSpriteNode(imageNamed: "thereallvl1btn")
//        level1.text = "Level 1"
//        level1.fontSize = 20
        level1.name = "level1"
        level1.zPosition = 1
        level1.position = CGPoint(x: 300, y: 500)
        
        
        
        addChild(level1)
        
        level2 = SKSpriteNode(imageNamed: "thereallvl2btn")
//        level2.text = "Level 2"
//        level2.fontSize = 20
        level2.name = "level2"
        level2.zPosition = 1
        level2.position = CGPoint(x: 300, y: 400)

        func updatelvl2 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp2")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked)
                
            } else  {
                
                addChild(level2)
            }
        }
        updatelvl2()
        
//        addChild(level2)
        
        level3 = SKSpriteNode(imageNamed: "thereallvl3btn")
//        level3.text = "Level 3"
//        level3.fontSize = 20
        level3.name = "level3"
        level3.zPosition = 1
        level3.position = CGPoint(x: 300, y: 300)
        
        
        func updatelvl3 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp3")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked2)
                
            } else  {
                
                addChild(level3)
            }
        }
        updatelvl3()

        
        
        level4 = SKSpriteNode(imageNamed: "thereallvl4btn")
//        level4.text = "Level 4"
//        level4.fontSize = 20
        level4.name = "level4"
        level4.zPosition = 1
        level4.position = CGPoint(x: 700, y: 500)
        
        func updatelvl4 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp4")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked3)
                
            } else  {
                
                addChild(level4)
            }
        }
        updatelvl4()

        
        
        level5 = SKSpriteNode(imageNamed: "thereallvl5btn")
//        level5.text = "Level 5"
//        level5.fontSize = 20
        level5.name = "level5"
        level5.zPosition = 1
        level5.position = CGPoint(x: 700, y: 400)

        func updatelvl5 () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp5")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked4)
                
            } else  {
                
                addChild(level5)
            }
        }
        updatelvl5()
        
        
        morelevels = SKSpriteNode(imageNamed: "therealnxtbtn")
//        morelevels.text = "More Levels"
//        morelevels.fontSize = 20
        morelevels.name = "morelevels"
        morelevels.zPosition = 1
        morelevels.position = CGPoint(x: 700, y: 300)
        
        func updatemorelevels () {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let pass = defaults.integerForKey("comp6")
            
            print(pass)
            
            
            if pass == 0 {
                
                addChild(locked5)
                
            } else  {
                
                addChild(morelevels)
            }
        }
        updatemorelevels()

        
        
        
        let homebutton = SKSpriteNode(imageNamed: "therealhomebtn")
        homebutton.name = "homebutton"
        homebutton.zPosition = 1
        homebutton.position = CGPoint(x: 500, y: 200)
        addChild(homebutton)
        
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "level1"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene1(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                    
                else if name == "level2"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene2(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                else if name == "level3"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene3(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                else if name == "level4"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene4(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                else if name == "level5"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene5(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                
                
                else if name == "morelevels"{
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = LevelMenuScene2(size: self.scene!.size)
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
