//
//  AGTWalletTableViewController.h
//  Wallet
//
//  Created by Charles Moncada on 19/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTWallet;
@class AGTBroker;

@interface AGTWalletTableViewController : UITableViewController

-(id) initWithModel: (AGTWallet *) model broker: (AGTBroker *) broker;

@end
