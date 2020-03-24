//
//  GameScene.swift
//  Pong
//
//  Created by Marlon Trujillo Ariza on 2/4/20.
//  Copyright © 2020 Marlon Trujillo Ariza. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var score = [Int]()
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()

    override func didMove(to view: SKView) {
        startGame()
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    func startGame(){
        score = [0,0]

    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if (playerWhoWon == main) {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        } else if (playerWhoWon == enemy){
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        }
        
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    func preventStop (ball: SKSpriteNode, yVelocity: Float){
        if (yVelocity > 0 && yVelocity < 500){
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
        }
        if (yVelocity < 0 && yVelocity > -500){
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -5))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        
        if (ball.position.y <= main.position.y - 70) {
            addScore(playerWhoWon: enemy)
            
        } else if (ball.position.y >= enemy.position.y + 70) {
            addScore(playerWhoWon: main)
            
        }
        
        let yVelocity = Float((ball.physicsBody?.velocity.dy)!)
        if (yVelocity < 500 && yVelocity > -500){
            preventStop(ball: ball, yVelocity: yVelocity)
        }

    }
}
