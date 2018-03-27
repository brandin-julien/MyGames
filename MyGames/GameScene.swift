//
//  GameScene.swift
//  MyGames
//
//  Created by julien brandin on 27/03/2018.
//  Copyright © 2018 julien brandin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene : SKScene{
    
    let label1 = SKLabelNode(fontNamed: "Gtek Technology")
    let label2 = SKLabelNode(fontNamed: "Gtek Technology")
    let sound = SKAction.playSoundFileNamed("Home.mp3", waitForCompletion: false)

    override func didMove(to view: SKView) {
        
        run(sound)
        
        label1.text = "pong"
        label1.fontSize = 50
        label1.position = CGPoint(x: self.size.width*0, y: self.size.height*0.3)
        
        label2.text = "flapira"
        label2.fontSize = 50
        label2.position = CGPoint(x: self.size.width*0, y: self.size.height*0.4)
        
        self.addChild(label1)
        self.addChild(label2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch : AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            
            if label1.contains(pointOfTouch){
                
                if let scene = GKScene(fileNamed: "PongScene") {
                    
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! PongScene? {
                        
                        // Copy gameplay related content over to the scene
                        //sceneNode.entities = scene.entities
                        //sceneNode.graphs = scene.graphs
                        
                        // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                        
                        // Present the scene
                        if let view = self.view as! SKView? {
                            
                            view.presentScene(sceneNode)
                            
                            view.ignoresSiblingOrder = true
                            
                            view.showsFPS = true
                            view.showsNodeCount = true
                        }
                    }
                }
                
            } else if label2.contains(pointOfTouch){
                
                let sceneToMoveTo = Flapira(size: self.size)
                sceneToMoveTo.scaleMode = .resizeFill
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
 
