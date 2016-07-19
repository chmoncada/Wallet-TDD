//
//  NSObject+GNUStepAddons.m
//  Wallet
//
//  Created by Charles Moncada on 13/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import "NSObject+GNUStepAddons.h"
#import <objc/runtime.h>

@implementation NSObject (GNUStepAddons)

-(id) subclassResponsability: (SEL)aSel {
    
    char prefix = class_isMetaClass(object_getClass(self)) ? '+' : '-';
    
    [NSException raise:NSInvalidArgumentException
                format:@"%@%c%@ ahould be overriden by its subclass",
     NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];
    
    return self; // not reached
    
}

@end
