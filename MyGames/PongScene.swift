//
//  GameScene.swift
//  Pong2
//
//  Created by julien brandin on 08/03/2018.
//  Copyright © 2018 julien brandin. All rights reserved.
//

import SpriteKit
import GameplayKit

class PongScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var ball = SKSpriteNode()
    var player_top = SKSpriteNode()
    var player_bottom = SKSpriteNode()
    
    var bottom_score = SKLabelNode()
    var top_score = SKLabelNode()
    
    var timer = Timer()
    var seconds = 10
    var resetCount = 0 // 5 -> reset
    
    var lastY = 0
    var lastX = 0
    
    var background = SKSpriteNode(imageNamed: "Space.jpg")

    var gameStatus = false
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        player_top = self.childNode(withName: "player_top") as! SKSpriteNode
        player_bottom = self.childNode(withName: "player_bottom") as! SKSpriteNode
        
        bottom_score = self.childNode(withName: "bottom_score") as! SKLabelNode
        top_score = self.childNode(withName: "top_score") as! SKLabelNode
        
        //ball.physicsBody?.applyImpulse( CGVector(dx: -30, dy: -30) )
        
        bottom_score.text = "\(0)"
        top_score.text = "\(0)"
        
        //runBall()
        
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        frameBody.friction = 0
        frameBody.restitution = 1
        
        self.physicsBody = frameBody
        
        runTimer()
        
        background.position = CGPoint(x: self.size.width*0, y: self.size.height*0)
        background.zPosition = -1
        self.addChild(background)
        
        //        GADRewardBasedVideoAd.sharedInstance().delegate = self
        //        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
        //                                                    withAdUnitID: "ca-app-pub-9027186418649207/5335860775")
        //
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            player_bottom.run( SKAction.moveTo(x: location.x , duration: 0.5 ) )
            
            gameStatus = true
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            player_bottom.run( SKAction.moveTo(x: location.x , duration: 0.5 ) )
            
        }
        
    }
    
    func runBall(){
        
        if !gameStatus {
            return
        }
        
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
    
    func resetBall() {
        
        ball.run( SKAction.moveTo(x: 0 , duration: 0.001 ) )
        ball.run( SKAction.moveTo(y: 0 , duration: 0.001 ) )
        
        ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
        //if you would also like to stop any rotation that may be present
        //ball.physicsBody?.angularVelocity = 0
        
    }
    
    func endOfGame(){
        print("endOfGame")
    }
    
    func editScore(winner : String){
        
        if winner == "bottom" {
            bottom_score.text = "\(Int(bottom_score.text!)! + 1)"
        }else if winner == "top" {
            top_score.text = "\(Int(top_score.text!)! + 1)"
        }
        
        gameStatus = false
        
        
        
        resetBall()
        
        runBall()
        //ball.physicsBody?.applyImpulse( CGVector(dx: -30, dy: -30) )
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        player_top.run( SKAction.moveTo(x: (ball.position.x) , duration: 0.5 ) )
        
        if ball.position.y <= player_bottom.position.y - 30 { // size of the bar
            //print("bottom loose")
            editScore(winner: "top")
            resetTimer()
        }
        else if ball.position.y >= player_top.position.y + 30 {
            //print("top loose")
            editScore(winner: "bottom")
            resetTimer()
        }
        
        lastY = Int(ball.position.y)
        lastX = Int(ball.position.x)
        
        if seconds <= 0 {
            resetTimer()
            runBall()
        }
        
        if resetCount >= 1 {
            runBall()
            resetCount = 0
        }
        
        // IF SCORE > 10 => WIN
        
        //print(ball.physicsBody?.velocity.dx)
        //print(ball.physicsBody?.velocity.dy)
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(PongScene.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        
        if lastY == Int(ball.position.y){
            resetCount += 1
        }
        else if lastX == Int(ball.position.x) {
            resetCount += 1
        }else {
            resetCount = 0
        }
        
        
    }
    
    func resetTimer() {
        seconds = 10
    }
    
}
