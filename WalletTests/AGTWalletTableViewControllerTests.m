//
//  AGTWalletTableViewControllerTests.m
//  Wallet
//
//  Created by Charles Moncada on 19/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"
#import "AGTBroker.h"

@interface AGTWalletTableViewControllerTests : XCTestCase

@property(nonatomic, strong) AGTWalletTableViewController *walletVC;
@property(nonatomic, strong) AGTWallet *wallet;
@property(nonatomic, strong) AGTBroker *broker;

@end

@implementation AGTWalletTableViewControllerTests

- (void)setUp {
    [super setUp];
    // Creamos el entorno de laboratorio
    //Creamos el wallet y le colocamos 2 monedas
    self.wallet = [[AGTWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[AGTMoney euroWithAmount:1]];
    // to have more than 1 money of USD to test number of cells
    [self.wallet plus:[AGTMoney dollarWithAmount:5]];
    self.broker = [AGTBroker new];
    
    
    self.walletVC = [[AGTWalletTableViewController alloc] initWithModel: self.wallet broker:self.broker];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testThatTableHasOneSectionPerCurrencyPlusOneForTotal {
    
    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil]; //nos hacemos pasar como otra cosa
    
    XCTAssertEqual(sections, 3, @"There must exist 3 sections ( USD, EUR and Total)");
    
}

-(void) testThatNumberOfCellsIsNumberOfMoneysPlusOne {
    
    //The seccion 0 (USD) must contain 3 cells
    XCTAssertEqual(3, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Number of cells is the number of money plus 1 (USD case = 3)");
    //The seccion 1 (EUR) must contain 2 cells
    XCTAssertEqual(2, [self.walletVC tableView:nil numberOfRowsInSection:1], @"Number of cells is the number of money plus 1 (EUR case = 2)");
    //The total section must contain 1 cell
    XCTAssertEqual(1, [self.walletVC tableView:nil numberOfRowsInSection:2], @"Total must contain 1 cell");
    
}


@end
