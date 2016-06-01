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
        level1 = SKSpriteNode(imageNamed: "star")
//        level1.text = "Level 1"
//        level1.fontSize = 20
        level1.name = "level1"
        level1.zPosition = 1
        level1.position = CGPoint(x: 400, y: 500)
        
        addChild(level1)
        
        level2 = SKSpriteNode(imageNamed: "star")
//        level2.text = "Level 2"
//        level2.fontSize = 20
        level2.name = "level2"
        level2.zPosition = 1
        level2.position = CGPoint(x: 400, y: 400)

        
        addChild(level2)
        
        level3 = SKSpriteNode(imageNamed: "star")
//        level3.text = "Level 3"
//        level3.fontSize = 20
        level3.name = "level3"
        level3.zPosition = 1
        level3.position = CGPoint(x: 400, y: 300)

        
        addChild(level3)
        
        level4 = SKSpriteNode(imageNamed: "star")
//        level4.text = "Level 4"
//        level4.fontSize = 20
        level4.name = "level4"
        level4.zPosition = 1
        level4.position = CGPoint(x: 500, y: 500)

        
        addChild(level4)
        
        level5 = SKSpriteNode(imageNamed: "star")
//        level5.text = "Level 5"
//        level5.fontSize = 20
        level5.name = "level5"
        level5.zPosition = 1
        level5.position = CGPoint(x: 500, y: 400)

        
        addChild(level5)
        
        morelevels = SKSpriteNode(imageNamed: "star")
//        morelevels.text = "More Levels"
//        morelevels.fontSize = 20
        morelevels.name = "morelevels"
        morelevels.zPosition = 1
        morelevels.position = CGPoint(x: 500, y: 300)
        
        
        addChild(morelevels)
        
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
