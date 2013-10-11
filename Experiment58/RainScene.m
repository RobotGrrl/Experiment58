//
//  RainScene.m
//  Experiment58
//
//  Created by Erin Kennedy on 2013-10-10.
//  Copyright (c) 2013 Erin Kennedy. All rights reserved.
//

#import "RainScene.h"

@interface RainScene ()
@property BOOL contentCreated;
@end

static const uint32_t brrdCategory = 0x1 << 0;
static const uint32_t rain1Category = 0x1 << 1;
static const uint32_t rain2Category = 0x1 << 2;
static const uint32_t rain3Category = 0x1 << 3;
static const uint32_t rain4Category = 0x1 << 4;
static const uint32_t rain5Category = 0x1 << 5;

@implementation RainScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void) createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    self.physicsWorld.gravity = CGVectorMake(0,-3);
    self.physicsWorld.contactDelegate = self;
    
    SKTexture *bgTexture = [SKTexture textureWithImageNamed:@"rainy_bg"];
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithTexture:bgTexture];
    bg.anchorPoint = CGPointMake(0.0, 0.0);
    bg.position = CGPointMake(0.0, 0.0);
    [self addChild:bg];
    
    
    for(int i=0; i<10; i++) {
        [self spawnBrrd];
    }
    
    
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
    
    SKAction *makeRocks = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.05 withRange:0.5]
                                                ]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
    
}


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if ((firstBody.categoryBitMask & brrdCategory) != 0)
    {
        //secondBody.node.isHidden = YES;// = [SKColor blackColor];
        //NSLog(@"ow");
        // TODO: do something, like play music or something funny
    }
    
}


-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rain1" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:@"rain2" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:@"rain3" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:@"rain4" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:@"rain5" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:@"robobrrd" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0 || node.position.y > self.frame.size.height) {
            [node removeFromParent];
            [self spawnBrrd];
        } else if(node.position.x < 0 || node.position.x > self.frame.size.width) {
            [node removeFromParent];
            [self spawnBrrd];
        }
    }];
    
    
}

- (void) spawnBrrd {
    int s = skRand(40.0, 200.0);
    RoboBrrdNode *brrdy = [[RoboBrrdNode alloc] initWithSize:CGSizeMake(s, s*0.8)];
    brrdy.position = CGPointMake(skRand(0, self.frame.size.width), skRand(0, self.frame.size.height/2.5));
    brrdy.physicsBody.categoryBitMask = brrdCategory;
    brrdy.physicsBody.contactTestBitMask = rain1Category | rain2Category | rain3Category | rain4Category | rain5Category;
    [self addChild:brrdy];
}



- (SKSpriteNode *)newSpaceship
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                              grayColor] size:CGSizeMake(64,32)];
    
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-28.0, 6.0);
    [hull addChild:light1];
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(28.0, 6.0);
    [hull addChild:light2];
    
    return hull;
    
}

- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                               yellowColor] size:CGSizeMake(8,8)];
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    
    return light;
}


- (void)addRock
{
    
    int s = skRand(8, 30);
    int r = skRand(0, 5);
    
    RaindropNode *rainy = [[RaindropNode alloc] initWithSize:CGSizeMake(s, s) type:r];
    rainy.position = CGPointMake(skRand((r)*(self.size.width/5), (r+1)*(self.size.width/5)), self.size.height);
    
    switch (r) {
        case 0:
            rainy.physicsBody.categoryBitMask = rain1Category;
            break;
        case 1:
            rainy.physicsBody.categoryBitMask = rain2Category;
            break;
        case 2:
            rainy.physicsBody.categoryBitMask = rain3Category;
            break;
        case 3:
            rainy.physicsBody.categoryBitMask = rain4Category;
            break;
        case 4:
            rainy.physicsBody.categoryBitMask = rain5Category;
            break;
        default:
            break;
    }
    
    [self addChild:rainy];
    
    
//    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(s,s)];
//    rock.position = CGPointMake(skRand(0, self.size.width),
//                                self.size.height);
//    rock.name = @"rain1";
//    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
//    //rock.physicsBody.usesPreciseCollisionDetection = YES;
//    
//    
//     SKAction *blink = [SKAction sequence:@[
//     [SKAction fadeAlphaTo:0.8 duration:0.1],
//     [SKAction fadeAlphaTo:1.0 duration:0.1]]];
//     SKAction *blinkForever = [SKAction repeatActionForever:blink];
//     [rock runAction: blinkForever];
//    
//    SKAction *tilt = [SKAction sequence:@[
//                                          [SKAction rotateByAngle:-10.0 duration:0.1],
//                                          [SKAction rotateByAngle:10.0 duration:0.1]]];
//    SKAction *tiltForever = [SKAction repeatActionForever:tilt];
//    [rock runAction: tiltForever];
//    
//     
//    [self addChild:rock];
    
}


static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}
static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

@end
