//
//  MainViewController.m
//  Experiment58
//
//  Created by Erin Kennedy on 2013-10-10.
//  Copyright (c) 2013 Erin Kennedy. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize spriteView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    HelloScene *hello = [[HelloScene alloc] initWithSize:CGSizeMake(1024, 768)];
    [spriteView presentScene: hello];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
