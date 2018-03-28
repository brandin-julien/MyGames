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
    let defaults = UserDefaults()

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "Home.jpg")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "PROMETHEUS")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 25
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        self.addChild(gameOverLabel)
        
        let score = defaults.integer(forKey: "flapira.score")

        let scoreLabel = SKLabelNode(fontNamed: "PROMETHEUS")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 25
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)

        var bestScore = defaults.integer(forKey: "flapira.bestScore")
        
        if score > bestScore {
            bestScore = score
            defaults.set(bestScore, forKey: "flapira.bestScore")
        }
        
        let bestScoreLabel = SKLabelNode(fontNamed: "PROMETHEUS")
        bestScoreLabel.text = "High Score: \(bestScore)"
        bestScoreLabel.fontSize = 25
        bestScoreLabel.fontColor = SKColor.white
        bestScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        bestScoreLabel.zPosition = 1
        self.addChild(bestScoreLabel)
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 25
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)

        backLabel.text = "Back to home"
        backLabel.fontSize = 25
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
