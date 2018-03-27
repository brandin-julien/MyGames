//
//  PongScene.swift
//  SUP'In Game
//
//  Created by julien brandin on 14/03/2018.
//  Copyright © 2018 julien brandin. All rights reserved.
//

import SpriteKit
import GameplayKit

class PongScene: SKScene {
    
    var sceneCharged : Bool = false
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var ball = SKSpriteNode()
    var player_top = SKSpriteNode()
    var player_bottom = SKSpriteNode()
    
    var bottom_score = SKLabelNode()
    var top_score = SKLabelNode()
    
    var background = SKSpriteNode(imageNamed: "Space.jpg")

    override func didMove(to view: SKView) {
        
        background.position = CGPoint(x: self.size.width*0, y: self.size.height*0)
        background.zPosition = -1
        self.addChild(background)
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        player_top = self.childNode(withName: "player_top") as! SKSpriteNode
        player_bottom = self.childNode(withName: "player_bottom") as! SKSpriteNode
        
        bottom_score = self.childNode(withName: "bottom_score") as! SKLabelNode
        top_score = self.childNode(withName: "top_score") as! SKLabelNode
                
        //ball.physicsBody?.applyImpulse( CGVector(dx: -30, dy: -30) )
        
        bottom_score.text = "\(0)"
        top_score.text = "\(0)"
        
        runBall()
        
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        frameBody.friction = 0
        frameBody.restitution = 1
        
        self.physicsBody = frameBody
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            player_bottom.run( SKAction.moveTo(x: location.x , duration: 0.5 ) )
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            player_bottom.run( SKAction.moveTo(x: location.x , duration: 0.5 ) )
            
        }
        
    }
    
    func runBall(){
        
        let flipX = arc4random_uniform(2) // 0 or 1
        let flipY = arc4random_uniform(2)
        
        var x = 30
        var y = 30
        
        if flipX == 0 {
            x = -30
        }
        
        if flipY == 0{
            y = -30
        }
        
        ball.physicsBody?.applyImpulse( CGVector(dx: x, dy: y) )
        
    }
    
    func editScore(winner : String){
        
        if winner == "bottom" {
            bottom_score.text = "\(Int(bottom_score.text!)! + 1)"
        }else if winner == "top" {
            top_score.text = "\(Int(top_score.text!)! + 1)"
        }
        
        ball.run( SKAction.moveTo(x: 0 , duration: 0 ) )
        ball.run( SKAction.moveTo(y: 0 , duration: 0 ) )
        
        ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
        //if you would also like to stop any rotation that may be present
        //ball.physicsBody?.angularVelocity = 0
        
        runBall()
        //ball.physicsBody?.applyImpulse( CGVector(dx: -30, dy: -30) )
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        player_top.run( SKAction.moveTo(x: (ball.position.x) , duration: 0.5 ) )
        
        
        
        if ball.position.y <= player_bottom.position.y - 30 { // size of the bar
            //print("bottom loose")
            editScore(winner: "top")
        }
        else if ball.position.y >= player_top.position.y + 30 {
            //print("top loose")
            editScore(winner: "bottom")
        }
        
    }
}
