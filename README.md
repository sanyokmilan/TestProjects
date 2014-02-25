# TestProjects

## AnalyticsServices

### GoogleAnalytics
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
NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory:@"Actions"
                                                                         action:@"buttonPress"
                                                                          label:@"sendEventClicked"
                                                                          value:nil] build];
[[GAI sharedInstance].defaultTracker send:event];
[[GAI sharedInstance] dispatch];
```

### Flurry
[Flurry](https://dev.flurry.com/home.do)

### Mixpanel
[Mixpanel](https://mixpanel.com/)

### Localytics
[Localytics](https://localytics.com)