//
//  AGTSimpleViewController.h
//  Wallet
//
//  Created by Charles Moncada on 18/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTSimpleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

- (IBAction)displayText:(id)sender;

@end
