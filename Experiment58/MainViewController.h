//
//  MainViewController.h
//  Experiment58
//
//  Created by Erin Kennedy on 2013-10-10.
//  Copyright (c) 2013 Erin Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "HelloScene.h"

@interface MainViewController : UIViewController {
    
    IBOutlet SKView *spriteView;
    
}

@property (nonatomic, retain) IBOutlet SKView *spriteView;

@end
