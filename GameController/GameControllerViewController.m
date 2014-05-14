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
            self.title=[NSString stringWithFormat:@"Avaiable:%@",controller.vendorName];
            if(stop)
                [GCController stopWirelessControllerDiscovery];
        }];
        
    }];
    
    GCExtendedGamepad *profile = self.gameController.extendedGamepad;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"rightTrigger:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
    profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"leftTrigger:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
   
    
    profile.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
    {
        NSLog(@"leftThumbStick:%@,xValue:%f,yValue:%f",dpad,xValue,yValue);
    };
    profile.rightThumbstick.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
    {
        NSLog(@"rightThumbStick:%@,xValue:%f,yValue:%f",dpad,xValue,yValue);
    };
   
    
    profile.leftShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"leftShoulder:%@,Value:%f,Pressed:%d",button,value,pressed);
    };
    profile.rightShoulder.valueChangedHandler= ^ (GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"rightShoulder:%@,Value:%f,Pressed:%d",button,value,pressed);
    };

    // Do any additional setup after loading the view from its nib.
}



@end
