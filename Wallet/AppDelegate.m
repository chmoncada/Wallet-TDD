//
//  AppDelegate.m
//  Wallet
//
//  Created by Charles Moncada on 11/07/16.
//  Copyright © 2016 Charles Moncada Pizarro. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTWallet.h"
#import "AGTBroker.h"
#import "AGTWalletTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Test model for tableview
    AGTWallet *wallet = [[AGTWallet alloc] initWithAmount:20.0 currency:@"EUR"];
    [wallet addMoney:[AGTMoney dollarWithAmount:5]];
    [wallet addMoney:[AGTMoney dollarWithAmount:5]];
    [wallet addMoney:[AGTMoney euroWithAmount:20]];
    
    AGTBroker *broker = [AGTBroker new];
    [broker addRate:1.3
       fromCurrency:@"EUR"
         toCurrency:@"USD"];
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    AGTWalletTableViewController *vc = [[AGTWalletTableViewController alloc] initWithModel:wallet
                                                                                    broker:broker];
    [vc.navigationItem setTitle:@"AGTWallet"];
        
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self.window setRootViewController:nVC];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
