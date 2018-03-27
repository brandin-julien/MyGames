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
    
    let label1 = SKLabelNode(fontNamed: "PROMETHEUS")
    let label2 = SKLabelNode(fontNamed: "PROMETHEUS")
    let projectText = SKLabelNode(fontNamed: "PROMETHEUS")
    let createdText = SKLabelNode(fontNamed: "PROMETHEUS")
    let byText = SKLabelNode(fontNamed: "PROMETHEUS")

    let sound = SKAction.playSoundFileNamed("Home.mp3", waitForCompletion: false)
    var background = SKSpriteNode(imageNamed: "Home.jpg")
    
    override func didMove(to view: SKView) {
        
        run(sound)
 
        projectText.text = "A Game"
        projectText.fontSize = 25
        projectText.fontColor = UIColor.white
        projectText.position = CGPoint(x: self.size.width*0, y: self.size.height*0.78)
        projectText.zPosition = 2
        
        createdText.text = "Created"
        createdText.fontSize = 25
        createdText.fontColor = UIColor.white
        print(self.size.height)
        createdText.position = CGPoint(x: self.size.width*0, y: self.size.height/2)
        print(createdText.position)
        createdText.zPosition = 2
        
        byText.text = "By JULIEN BRANDIN"
        byText.fontSize = 25
        byText.fontColor = UIColor.white
        byText.position = CGPoint(x: self.size.width*0, y: self.size.height*0.005)
        print(byText.position)
        byText.zPosition = 2
        
        label1.text = "Pong"
        label1.fontSize = 50
        label1.fontColor = UIColor.white
        label1.position = CGPoint(x: self.size.width*0, y: self.size.height*0.3)
        label1.zPosition = 2

        label2.text = "Flapira"
        label2.fontSize = 50
        label2.fontColor = UIColor.white
        label2.position = CGPoint(x: self.size.width*0, y: self.size.height*0.4)
        label2.zPosition = 2
        
        background.position = CGPoint(x: self.size.width*0, y: self.size.height*0)
        background.zPosition = 1
        
        //self.addChild(background)
        self.addChild(projectText)
        self.addChild(createdText)
        self.addChild(byText)
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
                            
//                            view.showsFPS = true
//                            view.showsNodeCount = true
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
 
