# TestProjects

## AnalyticsServices

### GoogleAnalytics
===================
[GoogleAnalytics](http://www.google.com/analytics/)

**Requirements**
* libz.dylib
* CoreData.framework

**Create tracker**

```  objective-c
static NSString *const kTrackingId = @"UA-********-1";
static NSString *const kAppTracking = @"App2";

[GAI sharedInstance].optOut = YES;
[GAI sharedInstance].dispatchInterval = 120;
[GAI sharedInstance].trackUncaughtExceptions = YES;

self.tracker = [[GAI sharedInstance] trackerWithName:kAppTracking
                                          trackingId:kTrackingId];
```

**Send message**

```  objective-c
NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory:@"CategoryActions"
                                                                         action:@“ActionButtonClicked"
                                                                          label:@“MessageMyButton"
                                                                          value:nil] build];
[[GAI sharedInstance].defaultTracker send:event];
[[GAI sharedInstance] dispatch];
```

### Flurry
==========
[Flurry](https://dev.flurry.com/home.do)

**Requirements**
* SystemConfigurations.framework

**Create tracker**

```  objective-c
static NSString *const kFlurryAppKey = @"*******************";

[Flurry startSession:kFlurryAppKey];
```

**Send message**

```  objective-c
NSDictionary *actionInfo = @{@“ActionButtonClicked" : @"MessageMyButton"};
[Flurry logEvent:@“CategoryActions" withParameters:actionInfo];
```

### Mixpanel
============
[Mixpanel](https://mixpanel.com/)

**Requirements**
* Install CocoaPods using gem install cocoapods
* Create a file in your Xcode project called Podfile and add the following line:
* pod 'Mixpanel'
* Run pod install in your Xcode project directory. CocoaPods should download and install the Mixpanel library, and create a new Xcode workspace. Open up this workspace in Xcode.

**Create tracker**

```  objective-c
static NSString *const kMixpanelProjectToken = @"********************************";

        self.mixpanel = [Mixpanel sharedInstanceWithToken:kMixpanelProjectToken];
        self.mixpanel.checkForSurveysOnActive = YES;
        self.mixpanel.showSurveyOnActive = YES;
        self.mixpanel.checkForNotificationsOnActive = YES;
        self.mixpanel.showNotificationOnActive = YES;
        self.mixpanel.flushInterval = 20;
```

**Send message**

```  objective-c
NSDictionary *actionInfo = @{@“ActionButtonClicked" : @"MessageMyButton"};
[[Mixpanel sharedInstance] track:@"CategoryActions" properties:actionInfo];
```

### Localytics
==============
[Localytics](https://localytics.com)

**Requirements**
* AdSupport.framework
* libz.dylib
* libsqlite3.dylib
* SystemConfiguration.framework

**Create tracker**

```  objective-c
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[LocalyticsSession shared] LocalyticsSession:kLocalyticsAppKey];
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
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
```

**Send message**

```  objective-c
NSDictionary *actionInfo = @{@“ActionButtonClicked" : @"MessageMyButton"};
[[LocalyticsSession shared] tagEvent:@"CategoryActions" attributes:actionInfo];
```
