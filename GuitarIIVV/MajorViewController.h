//
//  MajorViewController.h
//  GuitarIIVV
//
//  Created by Wormhole on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface MajorViewController : UIViewController <AVAudioPlayerDelegate, UIGestureRecognizerDelegate> 
{
    UISwipeGestureRecognizer *swipeRecognizerLeft;
    UISwipeGestureRecognizer *swipeRecognizerRight;
}
// Properties

@property (nonatomic, strong) AVAudioPlayer *audioPlayerLeft;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerMiddle;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerRight;

// Chord name display in 4 beats per measure
@property (strong, nonatomic) IBOutlet UILabel *m1Beat1;
@property (strong, nonatomic) IBOutlet UILabel *m1Beat2;
@property (strong, nonatomic) IBOutlet UILabel *m1Beat3;
@property (strong, nonatomic) IBOutlet UILabel *m1Beat4;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat1;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat2;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat3;
@property (strong, nonatomic) IBOutlet UILabel *m2Beat4;


//Methods & IBActions
-(IBAction)chartSwipedLeft: (UISwipeGestureRecognizer *)swipeGestureLeft;
-(IBAction)chartSwipedRight: (UISwipeGestureRecognizer *)swipeGestureRight;

// Hidden (alpha = 0.05) chord sound buttons
- (IBAction)leftChordButton:(UIButton *)sender;
- (IBAction)middleChordButton:(UIButton *)sender;
- (IBAction)rightChordButton:(UIButton *)sender;

@end
