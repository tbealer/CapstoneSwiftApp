//
//  InstructionScene2.swift
//  SharkCove
//
//  Created by Thomas Bealer on 6/2/16.
//  Copyright © 2016 Bealer Media. All rights reserved.
//

import CoreMotion
import SpriteKit

class InstructionScene2: SKScene, SKPhysicsContactDelegate {
    
    
    
    
    
    var playbutton: SKSpriteNode!
    var lvlbutton: SKSpriteNode!
    
    var lastTouchPosition: CGPoint?
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        
        
        let background = SKSpriteNode(imageNamed: "tryinstruct2")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        
        
        
        
        
        
        
        addButtons()
        
    }
    
    
    
    func addButtons () {
        let next = SKSpriteNode(imageNamed: "therealnxtbtn")
        next.name = "next"
        next.zPosition = 1
        next.position = CGPoint(x: 900, y: 200)
        next.anchorPoint = CGPoint(x:0.5,y:0.5)
        next.userInteractionEnabled = false
        
        
        addChild(next)
        
        let home = SKSpriteNode(imageNamed: "therealhomebtn")
        home.name = "home"
        home.zPosition = 1
        home.position = CGPoint(x: 100, y: 200)
        home.anchorPoint = CGPoint(x:0.5,y:0.5)
        home.userInteractionEnabled = false
        
        
        addChild(home)
        
        
        
        
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "next"
                {
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 2.0)
                    
                    let nextScene = InstructionsScene3(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                }
                else if name == "home"
                {
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 2.0)
                    
                    let nextScene = GameScene(size: self.scene!.size)
                    nextScene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(nextScene, transition: transition)
                }
            }
            
        }
    }
}


