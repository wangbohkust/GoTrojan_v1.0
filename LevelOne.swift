import SpriteKit

class LevelOne: SKScene, SKPhysicsContactDelegate{
    var map = SKSpriteNode(imageNamed: "levelone2")
    let hero = Hero()
    let hud  = HudLayout(imageNamed:"levelone2")
    var joint: SKPhysicsJoint!
    var flag = false
    enum ColliderType:UInt32{
        case Hero = 1
        case Block = 2
        case Tool = 4
    }
    
    override func  didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        self.physicsWorld.contactDelegate   = self
        self.physicsWorld.gravity = CGVectorMake(0, -3)
        map.position = CGPointMake(CGRectGetMidX(self.frame)-150,CGRectGetMidY(self.frame))
        hud.position = CGPointMake(CGRectGetMidX(self.frame)-150,CGRectGetMidY(self.frame))
        let offsetX = map.frame.size.width * map.anchorPoint.x;
        let offsetY = map.frame.size.height * map.anchorPoint.y;
        // bolock1
        let block1 = SKSpriteNode()
        var path1 = CGPathCreateMutable()
        CGPathMoveToPoint(path1, nil, 7 - offsetX, 554 - offsetY);
        CGPathAddLineToPoint(path1, nil, 476 - offsetX, 554 - offsetY);
        CGPathAddLineToPoint(path1, nil, 472 - offsetX, 14 - offsetY);
        CGPathAddLineToPoint(path1, nil, 7 - offsetX, 2 - offsetY);
        CGPathCloseSubpath(path1)
        block1.physicsBody = SKPhysicsBody(polygonFromPath: path1)
        setPhysicalForBlock(block1)
        //block2
        let block2 = SKSpriteNode()
        var path2 = CGPathCreateMutable()
        CGPathMoveToPoint(path2, nil, 800 - offsetX, 548 - offsetY);
        CGPathAddLineToPoint(path2, nil, 800 - offsetX, 434 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1000 - offsetX, 434 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1000 - offsetX, 11 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1151 - offsetX, 11 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1151 - offsetX, 545 - offsetY);
        CGPathCloseSubpath(path2)
        block2.physicsBody = SKPhysicsBody(polygonFromPath: path2)
        setPhysicalForBlock(block2)
        //block3
        let block3 = SKSpriteNode()
        var path3 = CGPathCreateMutable()
        CGPathMoveToPoint(path3, nil, 1634 - offsetX, 770 - offsetY);
        CGPathAddLineToPoint(path3, nil, 1634 - offsetX, 5 - offsetY);
        CGPathAddLineToPoint(path3, nil, 1454 - offsetX, 5 - offsetY);
        CGPathAddLineToPoint(path3, nil, 1454 - offsetX, 770 - offsetY);
        CGPathCloseSubpath(path3)
        block3.physicsBody = SKPhysicsBody(polygonFromPath: path3)
        setPhysicalForBlock(block3)
        //block4
        let block4 = SKSpriteNode()
        var path4 = CGPathCreateMutable()
        CGPathMoveToPoint(path4, nil, 1630 - offsetX, 645 - offsetY);
        CGPathAddLineToPoint(path4, nil, 1630 - offsetX, 1 - offsetY);
        CGPathAddLineToPoint(path4, nil, 2042 - offsetX, 1 - offsetY);
        CGPathAddLineToPoint(path4, nil, 2042 - offsetX, 645 - offsetY);
        CGPathCloseSubpath(path4)
        block4.physicsBody = SKPhysicsBody(polygonFromPath: path4)
        setPhysicalForBlock(block4)
        //star
        let star = SKSpriteNode(imageNamed:"star")
        star.position = CGPointMake(746, 327)
        //hero
        hero.position = CGPointMake(300 - offsetX, 548 - offsetY)
        //hero.setScale(2)
        map.addChild(hero)
        map.addChild(block1)
        map.addChild(block2)
        map.addChild(block3)
        map.addChild(block4)
        map.addChild(star)

        self.addChild(hud)
        self.addChild(map)
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self.hud)
            if hud.rightMoveButton.containsPoint(location) {
                if self.hero.physicsBody?.velocity.dx <= 80 {
                    //self.hero.physicsBody?.applyImpulse(CGVectorMake(60, 0))
                     self.hero.physicsBody?.velocity.dx = 150
                    hero.startAnimation("right")
                    hud.rightMoveButton.texture = SKTexture(imageNamed: "rightArrow1")
                }
            }
            if hud.leftMoveButton.containsPoint(location) {

               // self.hero.physicsBody?.applyImpulse(CGVectorMake(-60, 0))
                self.hero.physicsBody?.velocity.dx = -150
                hud.leftMoveButton.texture = SKTexture(imageNamed: "leftArrow1")
                hero.startAnimation("left")
            }
            if hud.jumpButton.containsPoint(location) {
                hud.jumpButton.texture = SKTexture(imageNamed: "jumpArrow1")
                if self.hero.physicsBody?.velocity.dy <= 0.2 && self.hero.physicsBody?.velocity.dy >= -0.2 {
                   // self.hero.physicsBody?.applyImpulse(CGVectorMake(0, 250))
                self.hero.physicsBody?.velocity.dy = 300
                    hero.startAnimation("jump")
                    println("jump tapped!")
                }
               
            }
            if hud.returnButton.containsPoint(location) {
                var scene                           = LevelOne(size: self.size)
                let skView                          = self.view as SKView!
                skView?.ignoresSiblingOrder         = true
                scene.scaleMode                     = .AspectFill
                //scene.size                          = skView.bounds.size
                skView.presentScene(scene)
                println("return tapped!")
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self.hud)
            if hud.rightMoveButton.containsPoint(location) {
                hud.rightMoveButton.texture = SKTexture(imageNamed: "rightArrow2")
            }
            if hud.leftMoveButton.containsPoint(location) {
                hud.leftMoveButton.texture = SKTexture(imageNamed: "leftArrow2")
            }
            if hud.jumpButton.containsPoint(location) {
                hud.jumpButton.texture = SKTexture(imageNamed: "jumpArrow2")
            }
        }

    }
    
    func setPhysicalForBlock(block : SKSpriteNode) {
        block.physicsBody!.dynamic          = false
        block.physicsBody!.categoryBitMask  = ColliderType.Block.rawValue
        // block.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue | ColliderType.Tool.rawValue
        block.physicsBody!.collisionBitMask = ColliderType.Hero.rawValue | ColliderType.Tool.rawValue
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.hero.physicsBody?.velocity.dx == 0 && self.hero.physicsBody?.velocity.dy == 0 {
            self.hero.startAnimation("stop")
        }
        if self.hero.position.y < -610 {
            var scene                           = LevelOne(size: self.size)
            let skView                          = self.view as SKView!
            skView?.ignoresSiblingOrder         = true
            scene.scaleMode                     = .AspectFill
            //scene.size                          = skView.bounds.size
            skView.presentScene(scene)
            println("return tapped!")

        }
        
    }
   /* func releaseJoint() {
        //hero.zPosition = 0
        physicsWorld.removeJoint(joint);
        flag = true
    }*/
   /*
   func didBeginContact(contact:SKPhysicsContact) {
        let collision :UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    
        if collision == ColliderType.Hero.rawValue | ColliderType.Tool.rawValue {
            flag = true
            println(hero.position.y - hero.size.height/2)
            println(contact.bodyA.node!.position.y + 60)
            var foot = hero.position.y - hero.size.height/2
            var up: CGFloat!
            if hero.position == contact.bodyA.node?.position {
                up = contact.bodyB.node!.position.y + 60
            }else {
                up = contact.bodyA.node!.position.y + 60

            }
            if foot >= (up - 20) && foot <= (up + 20) {
                //println("pin")
                hero.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
                let pinPoint = CGPoint(x:hero.position.x, y: up)
                joint = SKPhysicsJointPin.jointWithBodyA(contact.bodyA, bodyB: contact.bodyB, anchor: pinPoint)
                physicsWorld.addJoint(joint)
            }
        }
    }
    func didEndContact(contact: SKPhysicsContact) {
        let collision :UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.Hero.rawValue | ColliderType.Tool.rawValue {
            flag = false
        }
        
    }*/
    
}