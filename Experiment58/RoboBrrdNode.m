//
//  RoboBrrdNode.m
//  Experiment58
//
//  Created by Erin Kennedy on 2013-10-10.
//  Copyright (c) 2013 Erin Kennedy. All rights reserved.
//

#import "RoboBrrdNode.h"

@implementation RoboBrrdNode

- (id) initWithSize:(CGSize)s {
    
    if (self = [super init]) {

        self.size = s;
        [self newBrrd];
        
        return self;
    } else {
        return nil;
    }
        
}

- (SKSpriteNode *) newBrrd
{
    
    SKTexture *brrdTexture = [SKTexture textureWithImageNamed:@"rb_sprite"];
    
    self.name = @"robobrrd";
    self.texture = brrdTexture;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    
    [self peacefulHover];
    
    return self;
    
}


- (void) peacefulHover {
    
    int lift = skRand(20, 80);
    int horizontal = 3*lift;
    float t = skRand(1.0, 5.0);
    float del = 0;//.1;
    int trajectory = skRand(-60, 60);
    float angle = trajectory/10;
    
    CGPathRef ellipse = CGPathCreateWithEllipseInRect(CGRectMake(self.position.x-horizontal, self.position.y-lift, horizontal, lift), NULL);

    
    
    SKAction *hover = [SKAction sequence:@[
                                           
                                           [SKAction followPath:ellipse asOffset:YES orientToPath:YES duration:t],
                                           [SKAction waitForDuration:del],
                                           [SKAction rotateByAngle:angle duration:0.5],
                                           [SKAction moveBy:CGVectorMake(trajectory, 10) duration:t],
                                           [SKAction waitForDuration:del],
                                           
//                                           [SKAction moveBy:CGVectorMake(horizontal*0.63, lift*-0.75) duration:t], // B
//                                           [SKAction moveBy:CGVectorMake(horizontal*0.39, lift*-0.25) duration:t], // C
//                                           [SKAction moveBy:CGVectorMake(horizontal*-0.39, lift*-0.25) duration:t], // D
//                                           [SKAction moveBy:CGVectorMake(horizontal*-0.63, lift*-0.75) duration:t], // E
//                                           [SKAction moveBy:CGVectorMake(horizontal*-0.39, lift*0.25) duration:t], // F
//                                           [SKAction moveBy:CGVectorMake(horizontal*-0.63, lift*0.75) duration:t], // G
//                                           [SKAction moveBy:CGVectorMake(horizontal*0.39, lift*0.25) duration:t], // H
//                                           [SKAction moveBy:CGVectorMake(horizontal*0.63, lift*0.75) duration:t] // A
                                           
                                           ]];
    [self runAction: [SKAction repeatActionForever:hover]];
    
    
    
}


- (void) crazyUpwardFlying {
    
    SKAction *hover = [SKAction sequence:@[
                                           //[SKAction waitForDuration:0.1],
                                           [SKAction moveByX:skRand(-50, 50) y:skRand(25, 50) duration:0.1],
                                           //[SKAction waitForDuration:0.1],
                                           [SKAction moveByX:skRand(-50, 50) y:skRand(25, 50) duration:0.1]]];
    [self runAction: [SKAction repeatActionForever:hover]];
    
    SKAction *tilt = [SKAction sequence:@[
                                          [SKAction waitForDuration:1.0],
                                          [SKAction rotateByAngle:-1.0 duration:0.5],
                                          [SKAction waitForDuration:1.0],
                                          [SKAction rotateByAngle:1.0 duration:0.5]]];
    SKAction *tiltForever = [SKAction repeatActionForever:tilt];
    [self runAction: tiltForever];
    
}



- (void) lolFunnyError {
    
    int lift = 4*6;//skRand(4, 4*3);
    int horizontal = 8*6;//skRand(8, 8*3);
    float t = 1.0;
    
    int xpos = self.position.x;
    int ypos = self.position.y;
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction moveTo:CGPointMake(xpos, ypos+lift) duration:t], // A
                                           [SKAction moveTo:CGPointMake(xpos+(horizontal*0.63), ypos+(lift*0.75)) duration:t], // B
                                           [SKAction moveTo:CGPointMake(xpos+horizontal, ypos) duration:t], // C
                                           [SKAction moveTo:CGPointMake(xpos-(horizontal*0.63), ypos-(lift*0.75)) duration:t], // D
                                           [SKAction moveTo:CGPointMake(xpos, ypos-lift) duration:t], // E
                                           [SKAction moveTo:CGPointMake(xpos-(horizontal*0.63), ypos-(lift*0.75)) duration:t], // F
                                           [SKAction moveTo:CGPointMake(xpos-horizontal, ypos) duration:t], // G
                                           [SKAction moveTo:CGPointMake(xpos-(horizontal*0.63), ypos+(lift*0.75)) duration:t] // H
                                           
                                           ]];
    [self runAction: [SKAction repeatActionForever:hover]];
    
    
    
}



static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}
static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}


@end
