//
//  Help145ViewController.m
//  GuitarIIVV
//
//  Created by Chris Lamb on 5/12/12.
//  Copyright (c) 2012 CPL Consulting. All rights reserved.
//

#import "Help145ViewController.h"

@interface Help145ViewController ()

@end

@implementation Help145ViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {    
        return YES;
    } else {
        return NO;
    }
}

@end
