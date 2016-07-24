//
//  AGTMoneyTest.m
//  Wallet
//
//  Created by Charles Moncada on 13/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTMoney.h"
@interface AGTMoneyTest : XCTestCase

@end

@implementation AGTMoneyTest

-(void) testCurrencies {

    XCTAssertEqualObjects(@"EUR", [[AGTMoney euroWithAmount:1] currency], @"The currency of euros should be EUR");
    XCTAssertEqualObjects(@"USD", [[AGTMoney dollarWithAmount:1] currency], @"The currency of dollars should be USD");
}

-(void)testMultiplication{
    
    AGTMoney *euro = [AGTMoney euroWithAmount:5];
    AGTMoney *tenEuros = [AGTMoney euroWithAmount:10];
    AGTMoney *totalEuros = [euro times:2];
    AGTMoney *dollar = [AGTMoney dollarWithAmount:5];
    AGTMoney *tenDollars = [AGTMoney dollarWithAmount:10];
    AGTMoney *totalDollar = [dollar times:2];
    
    XCTAssertEqualObjects(totalEuros, tenEuros, @"€5 * 2 should be €10");
    XCTAssertEqualObjects(totalDollar, tenDollars, @"USD5 * 2 should be USD10");
}

-(void) testEquality{
    AGTMoney *fiveEuros = [AGTMoney euroWithAmount:5];
    AGTMoney *tenEuros = [AGTMoney euroWithAmount:10];
    AGTMoney *totalEuros = [fiveEuros times:2];
    AGTMoney *fiveDollars = [AGTMoney dollarWithAmount:5];
    AGTMoney *tenDollars = [AGTMoney dollarWithAmount:10];
    AGTMoney *totalDollars = [fiveDollars times:2];
    
    XCTAssertEqualObjects(tenEuros, totalEuros, @"Equivalent objects should be equal!");
    XCTAssertEqualObjects(tenDollars, totalDollars, @"Equivalent objects should be equal!");
}

-(void) testDifferentCurrencies{
    AGTMoney *euro = [AGTMoney euroWithAmount:1];
    AGTMoney *dollar = [AGTMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal!");
}


-(void) testHash{
    
    AGTMoney *a = [AGTMoney euroWithAmount:2];
    AGTMoney *b = [AGTMoney euroWithAmount:2];
    AGTMoney *c = [AGTMoney dollarWithAmount:2];
    AGTMoney *d = [AGTMoney dollarWithAmount:2];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have the same hash");
    XCTAssertEqual([c hash], [d hash], @"Equal objects must have the same hash");
}

-(void) testAmountStorage {
    
    AGTMoney *euro = [AGTMoney euroWithAmount:2];
    AGTMoney *dollar = [AGTMoney dollarWithAmount:2];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue], @"The value retrieved should be te same as the stored");
    XCTAssertEqual(2, [[dollar performSelector:@selector(amount)]integerValue], @"The value retrieved should be te same as the stored");
#pragma clang diagnostic pop
    
    
}

-(void) testSimpleAddition {
    
    // Test if we can simple add
    XCTAssertEqualObjects([[AGTMoney dollarWithAmount:5] plus: [AGTMoney dollarWithAmount:5]],
                              [AGTMoney dollarWithAmount:10], @"$5 + $5 = $10");
    // Test if we cannot simple add two different currencies
    XCTAssertThrows([[AGTMoney dollarWithAmount:5] plus:[AGTMoney euroWithAmount:5]], @"Should not allow to simple add 2 different currencies");
    
}

-(void) testHashIsAmount{
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
    
}

-(void) testDecription {
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    NSString *desc = @"<AGTMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
    
}

@end
