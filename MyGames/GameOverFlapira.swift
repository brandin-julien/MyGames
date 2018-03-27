//
//  GameOverFlapira.swift
//  SUPInGame
//
//  Created by julien brandin on 27/03/2018.
//  Copyright © 2018 julien brandin. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    let restartLabel = SKLabelNode(fontNamed: "PROMETHEUS")
    let backLabel = SKLabelNode(fontNamed: "PROMETHEUS")
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "Home.jpg")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "PROMETHEUS")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 25 // 200 AND REST 125
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "PROMETHEUS")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 25 // 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        
        let highScoreLabel = SKLabelNode(fontNamed: "PROMETHEUS")
        highScoreLabel.text = "High Score: 0"
        highScoreLabel.fontSize = 25 // 125
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 25 // 90
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)

        backLabel.text = "Back to home"
        backLabel.fontSize = 25 // 90
        backLabel.fontColor = SKColor.white
        backLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        backLabel.zPosition = 1
        self.addChild(backLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            
            if backLabel.contains(pointOfTouch){
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = .resizeFill
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }else if restartLabel.contains(pointOfTouch){
                let sceneToMoveTo = Flapira(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
        }
    }
    
}
