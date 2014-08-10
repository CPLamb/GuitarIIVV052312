//
//  ChordViewController.m
//  GuitarIIVV
//
//  Created by Wormhole on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChordViewController.h"

@interface ChordViewController ()

@end

@implementation ChordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
// set up an audioPlayer for testing
    NSURL *urlButton = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01ChordC" ofType:@"mp3"]];
    audioPlayerChord01 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlButton error:NULL];
    audioPlayerChord01.delegate = self; 
    [audioPlayerChord01 prepareToPlay];
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

- (IBAction)startSound:(UIButton *)sender {
    NSLog(@"Started sound");
    [audioPlayerChord01 stop];
    audioPlayerChord01.currentTime = 0;
    [audioPlayerChord01 play];
}

- (IBAction)stopSound:(UIButton *)sender {
    NSLog(@"Stopped sound");
//    [audioPlayerChord01 stop];
}
@end
