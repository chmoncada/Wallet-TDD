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



-(id) initWithAmount:(float) amount currency:(NSString *)currency {
    if (self = [super init]) {
        AGTMoney *money = [[AGTMoney alloc]initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }
    return self;
}

-(NSUInteger) numberOfCurrencies {
    return [self.currencies count];
}

-(NSMutableArray *) currencies {
    NSMutableArray *arrayOfCurrencies = [NSMutableArray array];
    
    for (AGTMoney *each in self.moneys) {
        if (![arrayOfCurrencies containsObject:each.currency]) {
            [arrayOfCurrencies addObject:each.currency];
        }
    }

    return arrayOfCurrencies;
}

-(id<AGTMoney>) plus:(AGTMoney *)money {
    
    [self.moneys addObject:money];
    
    return self;
}

-(id<AGTMoney>) times:(float)multiplier {
    
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

-(void) addMoney:(AGTMoney *) money {
    [self.moneys addObject:money];
}

-(void) takeMoney:(AGTMoney *) money {
    
    //Creo una moneda negativa (una chapuza)
    AGTMoney *moneyWithdraw = [[AGTMoney alloc] initWithAmount:(0-[money.amount integerValue]) currency:money.currency];
    
    // Compruebo si hay monedas suficientes sino lanzo una excepcion (la comprobacion sirve tambien si el currency no existe ya que
    // uno de los componentes de la comparacion se hace nil y un integer es mayor a nil
    // Se podria mejorar la comparacion para que bote una excepcion especifica
    if ([money.amount integerValue] > [[[self getTotalOfCurrency:money.currency] amount] integerValue] ) {
        NSException *e = [NSException exceptionWithName:@"CannotTakeMoreMoneyThatExistOrTakeMoneyFromANonExistingCurrency"
                                                 reason:@"*** Cannot take more money from the wallet or the currency does not exist in the wallet" userInfo:nil];
        @throw e;
    } else {
        //Adiciono esa moneda negativa
        [self addMoney:moneyWithdraw];
    }
    
}


-(AGTMoney *) getTotalOfCurrency:(NSString *)currency {

    AGTMoney *total = [[AGTMoney alloc] initWithAmount:0 currency:currency];
    for (AGTMoney *each in self.moneys) {
        if ([each.currency isEqualToString:currency]) {
            total = [total plus:each];
        }
    }
    
    return total;
}

-(NSMutableArray *) moneysForSection:(NSInteger) section {
    NSString *currency = [self.currencies objectAtIndex:section];
    NSMutableArray *newMoneys = [NSMutableArray array];
    
    for (AGTMoney *each in self.moneys) {
        if([each.currency isEqualToString:currency]) {
            [newMoneys addObject:each];
        }
    }
    
    return newMoneys;
}

-(NSInteger) numberOfMoneysForSection:(NSInteger) section {
    return [[self moneysForSection:section] count];
}


@end
