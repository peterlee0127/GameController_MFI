//
//  InfoViewController.m
//  GameController
//
//  Created by Peterlee on 5/28/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction) closeInfoVC:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
