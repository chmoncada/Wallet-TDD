//
//  AGTMoney.m
//  Wallet
//
//  Created by Charles Moncada on 13/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import "AGTMoney.h"
#import "NSObject+GNUStepAddons.h"
#import "AGTBroker.h"

@interface AGTMoney ()
@property (nonatomic) NSNumber *amount;
@end

@implementation AGTMoney

+(id) euroWithAmount: (float) amount {
    return [[AGTMoney alloc] initWithAmount:amount currency:@"EUR"];
}

+(id) dollarWithAmount: (float) amount {
    return [[AGTMoney alloc] initWithAmount:amount currency:@"USD"];
}

-(id) initWithAmount: (float) amount currency:(NSString *)currency {
    if (self = [super init]) {
        _amount = [NSNumber numberWithFloat: amount];
        _currency = currency;
    }
    return self;
}

-(id<AGTMoney>) times:(float) multiplier{
    
    AGTMoney *newMoney = [[AGTMoney alloc]
                        initWithAmount:[self.amount floatValue]*multiplier currency:self.currency];
    
    return newMoney;
}

-(id<AGTMoney>) plus:(AGTMoney *) other {
    
    // It should add only if the currency of both AGTMoney are the same
    if( [self.currency isEqual:[other currency]]) {

        float totalAmount = [self.amount floatValue] + [other.amount floatValue];
        AGTMoney *total = [[AGTMoney alloc] initWithAmount:totalAmount currency:self.currency];
        
        return total;
    } else {
        // If there are different currencies throws an Exception
        NSException *e = [NSException exceptionWithName:@"CannotMakePlusMethod"
                                                 reason:@"*** Cannot use plus: with different currencies" userInfo:nil];
        @throw e;
    }
    
}

-(id<AGTMoney>) reduceToCurrency:(NSString *) currency withBroker: (AGTBroker *) broker {
    
    AGTMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                       toCurrency:currency]] doubleValue];
    
    // Comprobamos que divisa de origen y de destino son las mismas
    if ([self.currency isEqual:currency]) {
        result = self;
    } else if (rate == 0) {
        // No hay tasa de conversion, excepcion que te crio
        [NSException raise:@"NoConversionRateException" format:@"Must have a conversion from %@ to %@", self.currency, currency];
    } else {
        float newAmount = [self.amount floatValue] * rate;
        
        result = [[AGTMoney alloc]
                  initWithAmount:newAmount
                  currency:currency];
    }
    
    return result;
    
}

#pragma mark - Overwritten

-(NSString*) description {
    
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
    
}

-(BOOL)isEqual:(id)object{
    
    if ([self.currency isEqual:[object currency]]) {
        return [self amount] == [object amount];
    } else {
        return NO;
    }
}

-(NSUInteger) hash {
    return [self.amount floatValue];
}


@end
