//
//  AGTMoney.h
//  Wallet
//
//  Created by Charles Moncada on 13/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTMoney;
@class AGTBroker;

@protocol AGTMoney <NSObject>

-(id) initWithAmount: (float) amount currency: (NSString *) currency;

-(id<AGTMoney>) times:(float) multiplier;

-(id<AGTMoney>) plus:(AGTMoney *) other;

-(id<AGTMoney>) reduceToCurrency:(NSString *) currency withBroker: (AGTBroker *) broker;

@end

@interface AGTMoney : NSObject<AGTMoney>

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, readonly) NSString *currency;

+(id) euroWithAmount: (float) amount;
+(id) dollarWithAmount: (float) amount;




@end
