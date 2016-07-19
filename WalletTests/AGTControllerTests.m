//
//  AGTControllerTests.m
//  Wallet
//
//  Created by Charles Moncada on 18/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTSimpleViewController.h"

@interface AGTControllerTests : XCTestCase
@property (nonatomic,strong) AGTSimpleViewController *simpleVC;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *label;
@end

@implementation AGTControllerTests

- (void)setUp {
    [super setUp];
    // Creamos el entorno de laboratorio
    self.simpleVC = [[AGTSimpleViewController alloc] initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;
}

- (void)tearDown {
    
    [super tearDown];
    // Lo destruimos
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
    
}

-(void) testThatTextOnLabelIsEqualToTextOnButton {
    
    // mandamos el mensaje
    [self.simpleVC displayText:self.button];
    
    // comprobamos que etiqueta y botón tiene el mismo texto
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Button and label should have the same text");
    
}


@end
