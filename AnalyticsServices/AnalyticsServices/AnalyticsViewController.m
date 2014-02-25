//
//  AnalyticsViewController.m
//  AnalyticsServices
//
//  Created by Alexander Voityuk on 2/19/14.
//  Copyright (c) 2014 Videal. All rights reserved.
//

#import "AnalyticsViewController.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "Flurry.h"
#import "Mixpanel.h"
#import "LocalyticsSession.h"

// categories
#define kCategoryViewDidLoad @"CategoryViewDidLoad"
#define kCategoryActions @"CategoryActions"
#define kCategoryVerbose @"CategoryVerbose"
#define kCategoryInfo @"CategoryInfo"
#define kCategoryWarning @"CategoryWarning"
#define kCategoryError @"CategoryError"

// actions
#define kActionViewDidLoad @"ActionViewDidLoad"
#define kActionButtonClicked @"ActionButtonClicked"

@interface AnalyticsViewController ()

- (IBAction)verboseClicked:(id)sender;
- (IBAction)infoClicked:(id)sender;
- (IBAction)warningClicked:(id)sender;
- (IBAction)errorClicked:(id)sender;

@end

@implementation AnalyticsViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Google Analytics
    self.screenName = @"this is my ViewController 2";
    
    // Localytics
    [[LocalyticsSession shared] tagScreen:@"this is my ViewController 2"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self sendEventWithCategory:kCategoryViewDidLoad action:kActionViewDidLoad message:@"AnalyticsViewController - viewDidLoad"];
}

#pragma mark - Button Actions

- (IBAction)verboseClicked:(id)sender {
    [self sendEventWithCategory:kCategoryError action:kActionButtonClicked message:@"verboseClicked"];
}

- (IBAction)infoClicked:(id)sender {
    [self sendEventWithCategory:kCategoryError action:kActionButtonClicked message:@"infoClicked"];
}

- (IBAction)warningClicked:(id)sender {
    [self sendEventWithCategory:kCategoryError action:kActionButtonClicked message:@"warningClicked"];
}

- (IBAction)errorClicked:(id)sender {
    [self sendEventWithCategory:kCategoryError action:kActionButtonClicked message:@"errorClicked"];
}

#pragma mark - Send Analitics

- (void)sendEventWithCategory:(NSString *)category action:(NSString *)action message:(NSString *)message {
    
    NSDictionary *actionInfo = @{action : message};
    
    // Google Analytics
    NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory:category
                                                                         action:action
                                                                          label:message
                                                                          value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
    // Flurry
    [Flurry logEvent:category withParameters:actionInfo];
    
    // Mixpanel
    [[Mixpanel sharedInstance] track:category properties:actionInfo];
    
    // Localytics
    [[LocalyticsSession shared] tagEvent:category attributes:actionInfo];
}

@end
