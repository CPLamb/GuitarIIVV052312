//
//  ChordViewController.h
//  GuitarIIVV
//
//  Created by Wormhole on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface ChordViewController : UIViewController  <AVAudioPlayerDelegate>
{
AVAudioPlayer *audioPlayerChord01;
}
- (IBAction)startSound:(UIButton *)sender;
- (IBAction)stopSound:(UIButton *)sender;

@end
