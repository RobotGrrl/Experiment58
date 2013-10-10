//
//  SpaceshipScene.m
//  Experiment58
//
//  Created by Erin Kennedy on 2013-10-10.
//  Copyright (c) 2013 Erin Kennedy. All rights reserved.
//

#import "SpaceshipScene.h"

@interface SpaceshipScene ()
@property BOOL contentCreated;
@end

@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}
- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
    
    SKAction *makeRocks = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.01 withRange:0.3]
                                                ]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
    
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
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
    
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(s,s)];
    rock.position = CGPointMake(skRand(0, self.size.width),
                                self.size.height);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    
    /*
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeAlphaTo:0.5 duration:0.1],
                                           [SKAction fadeAlphaTo:1.0 duration:0.1]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [rock runAction: blinkForever];
    */
    
    SKAction *tilt = [SKAction sequence:@[
                                           [SKAction rotateByAngle:-10.0 duration:0.1],
                                           [SKAction rotateByAngle:10.0 duration:0.1]]];
    SKAction *tiltForever = [SKAction repeatActionForever:tilt];
    [rock runAction: tiltForever];
    
    
    [self addChild:rock];
}


static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}
static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

@end
