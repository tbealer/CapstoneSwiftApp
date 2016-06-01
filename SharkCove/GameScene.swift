


//
//  GameScene.swift
//  SharkCove
//
//  Created by Thomas Bealer on 5/27/16.
//  Copyright (c) 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playbutton: SKSpriteNode!
    var lvlbutton: SKSpriteNode!

    var lastTouchPosition: CGPoint?
    
    
    
    
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
        let playbutton = SKSpriteNode(imageNamed: "playbutton")
        playbutton.name = "playbutton"
        playbutton.zPosition = 1
        playbutton.position = CGPoint(x: 400, y: 500)
        playbutton.anchorPoint = CGPoint(x:0.5,y:0.5)
        playbutton.userInteractionEnabled = false
        
        
        addChild(playbutton)
        
        let lvlbutton = SKSpriteNode(imageNamed: "lvlfinal")
        lvlbutton.name = "lvlbutton"
        lvlbutton.zPosition = 1
        lvlbutton.position = CGPoint(x: 400, y: 300)
        lvlbutton.anchorPoint = CGPoint(x:0.5,y:0.5)
        lvlbutton.userInteractionEnabled = false
        
        
        addChild(lvlbutton)
        
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "playbutton"
            {
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 2.0)
                
                let nextScene = GameScene1(size: self.scene!.size)
                nextScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene!.view!.presentScene(nextScene, transition: transition)
            }
            else if name == "lvlbutton"
            {
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 2.0)
                
                let nextScene = LevelMenuScene(size: self.scene!.size)
                nextScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene!.view!.presentScene(nextScene, transition: transition)
            }
        }
            
        }
        }
    }
    
    
    
    
