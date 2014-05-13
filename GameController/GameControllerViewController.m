//
//  GameControllerViewController.m
//  GameController
//
//  Created by Peterlee on 5/13/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "GameControllerViewController.h"

@interface GameControllerViewController ()

@end

@implementation GameControllerViewController

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
    self.title=@"Avaiable Controllers";
    
    [GCController startWirelessControllerDiscoveryWithCompletionHandler:^{
       
        [[GCController controllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            GCController *controller=(GCController *)obj;
            NSLog(@"discover:%@ %@",controller.vendorName,controller.gamepad);
        }];
    }];
    
    GCExtendedGamepad *profile = self.gameController.extendedGamepad;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            NSLog(@"rightTrigger:%@,Value:%f,Pressed:%d",button,value,pressed);
        }
          
    };
    profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            NSLog(@"leftTrigger:%@,Value:%f,Pressed:%d",button,value,pressed);
        }
    };

    // Do any additional setup after loading the view from its nib.
}



@end
