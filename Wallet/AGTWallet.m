//
//  AGTWallet.m
//  Wallet
//
//  Created by Charles Moncada on 17/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import "AGTWallet.h"

@interface AGTWallet()
@property (nonatomic, strong) NSMutableArray *moneys;

@end

@implementation AGTWallet

-(id) initWithAmount:(NSInteger)amount currency:(NSString *)currency {
    if (self = [super init]) {
        AGTMoney *money = [[AGTMoney alloc]initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }
    return self;
}

-(id<AGTMoney>) plus:(AGTMoney *)money {
    
    [self.moneys addObject:money];
    
    return self;
}

-(id<AGTMoney>) times:(NSInteger)multiplier {
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    for (AGTMoney *each in self.moneys) {
        AGTMoney *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    
    self.moneys = newMoneys;
    
    return self;
    
}

-(id<AGTMoney>) reduceToCurrency:(NSString *)currency withBroker:(AGTBroker *)broker {
    
    AGTMoney *result = [[AGTMoney alloc] initWithAmount:0 currency:currency];
    
    for (AGTMoney *each in self.moneys) {
        result = [result plus:[each reduceToCurrency:currency withBroker:broker]];
        
    }
    return result;

}

@end
