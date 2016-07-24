//
//  AGTWallet.h
//  Wallet
//
//  Created by Charles Moncada on 17/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTMoney.h"

@interface AGTWallet : NSObject<AGTMoney>

@property (nonatomic, readonly) NSUInteger numberOfCurrencies;
@property (nonatomic, strong) NSMutableArray *currencies;

-(void) addMoney:(AGTMoney *) money;
-(void) takeMoney:(AGTMoney *) money;

-(AGTMoney *) getTotalOfCurrency:(NSString *)currency;
-(NSInteger) numberOfMoneysForSection:(NSInteger) section;

-(NSMutableArray *) moneysForSection:(NSInteger) section;

@end
