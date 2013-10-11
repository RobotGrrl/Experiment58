//
//  RaindropNode.m
//  Experiment58
//
//  Created by Erin Kennedy on 2013-10-10.
//  Copyright (c) 2013 Erin Kennedy. All rights reserved.
//

#import "RaindropNode.h"

@implementation RaindropNode

- (id) initWithSize:(CGSize)s type:(int)t {
    
    if (self = [super init]) {
        
        self.size = s;
        
        switch (t) {
            case 0:
                self.name = @"rain1";
                self.color = [SKColor blueColor];
                break;
            case 1:
                self.name = @"rain2";
                self.color = [SKColor yellowColor];
                break;
            case 2:
                self.name = @"rain3";
                self.color = [SKColor purpleColor];
                break;
            case 3:
                self.name = @"rain4";
                self.color = [SKColor greenColor];
                break;
            case 4:
                self.name = @"rain5";
                self.color = [SKColor orangeColor];
                break;
            default:
                break;
        }
        
        [self newDrop];
        
        return self;
    } else {
        return nil;
    }
    
}

- (SKSpriteNode *) newDrop
{
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.restitution = 0.8f;
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeAlphaTo:0.8 duration:0.1],
                                           [SKAction fadeAlphaTo:1.0 duration:0.1]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [self runAction: blinkForever];
    
    SKAction *tilt = [SKAction sequence:@[
                                          [SKAction rotateByAngle:-10.0 duration:0.1],
                                          [SKAction rotateByAngle:10.0 duration:0.1]]];
    SKAction *tiltForever = [SKAction repeatActionForever:tilt];
    [self runAction: tiltForever];
    
    return self;
    
}

@end
