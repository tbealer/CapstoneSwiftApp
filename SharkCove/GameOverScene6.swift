//
//  GameOverScene6.swift
//  SharkCove
//
//  Created by Thomas Bealer on 6/1/16.
//  Copyright © 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit

class GameOverScene6: SKScene, SKPhysicsContactDelegate {
    
    var playbutton: SKSpriteNode!
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
        let win = SKSpriteNode(imageNamed: "gameoverfinal")
        win.name = "win"
        win.position = CGPoint(x: 500, y: 400)
        win.zPosition = 20
        
        addChild(win)
        
        let homebtn = SKSpriteNode(imageNamed: "homebtnfinal")
        homebtn.name = "homebtn"
        homebtn.zPosition = 21
        homebtn.userInteractionEnabled = false
        
        homebtn.position = CGPoint(x: 500, y: 400)
        
        addChild(homebtn)
        
        let nextbtn = SKSpriteNode(imageNamed: "retryfinal")
        nextbtn.name = "nextbtn"
        nextbtn.zPosition = 21
        nextbtn.userInteractionEnabled = false
        
        nextbtn.position = CGPoint(x: 500, y: 300)
        
        
        addChild(nextbtn)
        
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "nextbtn"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene6(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
                    
                else if name == "homebtn"
                {
                    
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let nextScene = GameScene(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                    
                }
            }
        }
    }
    
    
    
    
}