//
//  AGTWalletTests.m
//  Wallet
//
//  Created by Charles Moncada on 17/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTMoney.h"
#import "AGTBroker.h"
#import "AGTWallet.h"

@interface AGTWalletTests : XCTestCase

@end

@implementation AGTWalletTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// €40 + $20 = $100 2:!
-(void) testAdditionWithReduction {
    
    AGTBroker *broker = [AGTBroker new];
    [broker addRate: 2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    AGTWallet *wallet = [[AGTWallet alloc] initWithAmount:40 currency:@"EUR"];
    [wallet plus: [AGTMoney dollarWithAmount:20]];
    
    AGTMoney *reduced = [broker reduce:wallet toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [AGTMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
    
}

-(void) testAddMoney {
    
    // Creo un wallet con monedas
    AGTWallet *wallet = [[AGTWallet alloc] initWithAmount:10 currency:@"EUR"];
    
    // Añado un nuevo money
    AGTMoney *newMoney = [AGTMoney euroWithAmount:10];
    [wallet addMoney: newMoney];
    
    // Veo cuanto hay de esa moneda en mi wallet
    AGTMoney *totalEuros = [wallet getTotalOfCurrency: @"EUR"];
    
    // testeo si el nuevo money se anadio al wallet
    XCTAssertEqualObjects(totalEuros, [AGTMoney euroWithAmount:20], @"The new money should be in the wallet, €10 + €10 = €20");
    
}

-(void) testTakeMoney {
    
    // Creo un wallet con monedas
    AGTWallet *wallet = [[AGTWallet alloc] initWithAmount:50 currency:@"EUR"];
    [wallet plus:[AGTMoney dollarWithAmount:50]];
    
    // Tomo monedas
    [wallet takeMoney: [AGTMoney euroWithAmount:20]];
    
    
    // Veo cuanto sobra de esa moneda en mi wallet
    AGTMoney *totalEuros = [wallet getTotalOfCurrency:@"EUR"];
    
    // Testeo
    XCTAssertEqualObjects(totalEuros, [AGTMoney euroWithAmount:30], @"The wallet should be diminished by the money taken, €50 - €20 = €30");
    // Test para comprobar que si se intenta sacar mas monedas de las que existen tira una excepcion
    XCTAssertThrows([wallet takeMoney:[AGTMoney dollarWithAmount:60]], @"It is forbidden to take out more money that exists");
    // Test para comprobar que si intento sacar una moneda con un currency que no existe tira una excepcion
    XCTAssertThrows([wallet takeMoney:[[AGTMoney alloc] initWithAmount:10 currency:@"AUD"]], @"The currency should exist in the wallet" );
}



@end
