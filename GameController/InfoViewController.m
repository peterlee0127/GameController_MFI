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
    self.view.backgroundColor=[UIColor clearColor];
    
    self.blurView=[[FXBlurView alloc] initWithFrame:self.view.frame];
    self.blurView.blurEnabled=YES;
    self.blurView.tintColor=[UIColor clearColor];
    self.blurView.blurRadius=12;
    self.blurView.iterations=3;
    self.blurView.dynamic=NO;
    [self.view addSubview:self.blurView];
    [self.view sendSubviewToBack:self.blurView];
    
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen"]];
    imageView.frame=self.view.frame;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction) closeInfoVC:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
