//
//  AppDelegate.m
//  AnalyticsServices
//
//  Created by Alexander Voityuk on 2/19/14.
//  Copyright (c) 2014 Videal. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"
#import "Flurry.h"
#import "Mixpanel.h"
#import "LocalyticsSession.h"

@interface AppDelegate ()

@property(nonatomic, strong) id<GAITracker> tracker;
@property (strong, nonatomic) Mixpanel *mixpanel;

@end

static NSString *const kGATrackingId = @"UA-48213397-1";
static NSString *const kGAAppTracking = @"sanyokmilan2";

static NSString *const kGAAllowTracking = @"allowTracking";

static NSString *const kFlurryAppKey = @"Z2C54P49NN2W68KSBRK4";

static NSString *const kMixpanelProjectToken = @"b66828f206a12d33ece0b10595ef0236";

static NSString *const kLocalyticsAppKey = @"430be102d6c24b7bf9a351e-ac74d4da-9980-11e3-4121-00a426b17dd8";

@implementation AppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [GAI sharedInstance].optOut = ![[NSUserDefaults standardUserDefaults] boolForKey:kGAAllowTracking];
    
    [[LocalyticsSession shared] LocalyticsSession:kLocalyticsAppKey];
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Google Analytics
    {
        NSDictionary *appDefaults = @{kGAAllowTracking: @(YES)};
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
        
        [GAI sharedInstance].optOut = ![[NSUserDefaults standardUserDefaults] boolForKey:kGAAllowTracking];
        [GAI sharedInstance].dispatchInterval = 120;
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        
        self.tracker = [[GAI sharedInstance] trackerWithName:kGAAppTracking
                                                  trackingId:kGATrackingId];
    }
    
    // Flurry
    {
        [Flurry startSession:kFlurryAppKey];
    }
    
    // Mixpanel
    {
        self.mixpanel = [Mixpanel sharedInstanceWithToken:kMixpanelProjectToken];
        
        self.mixpanel.checkForSurveysOnActive = YES;
        self.mixpanel.showSurveyOnActive = YES;
        self.mixpanel.checkForNotificationsOnActive = YES;
        self.mixpanel.showNotificationOnActive = YES;
        self.mixpanel.flushInterval = 20;
    }
        
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

@end
