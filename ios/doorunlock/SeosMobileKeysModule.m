
//  SeosMobileKeysModule.m
//  doorunlock

//  Created by Arun Patel on 25/02/25.


//#import "SeosMobileKeysSDK/SeosMobileKeysSDK.h"
//#import "SeosMobileKeysSDK/MobileKeysManager.h"
#import "SeosMobileKeysModule.h"
#import "doorunlock-Swift.h"

@implementation SeosMobileKeysModule {
  BOOL hasListeners;
}

RCT_EXPORT_MODULE(SeosMobileKeysModule);

+ (instancetype)sharedInstance {
  static SeosMobileKeysModule *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

// Register events that can be sent to React Native
- (NSArray<NSString *> *)supportedEvents {
  return @[@"onMessageFromSeos", @"onError"];
}

// ✅ Register listeners when React Native subscribes to events
- (void)startObserving {
  hasListeners = YES;
}

// ✅ Unregister listeners when React Native unsubscribes
- (void)stopObserving {
  hasListeners = NO;
}

// Emit events from Swift
- (void)emitEventWithName:(NSString *)name body:(id)body {
  if (hasListeners) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self sendEventWithName: name body:body];
    });
  }
  //    [[self sharedInstance] sendEventWithName:name body:body];
}

RCT_EXPORT_METHOD(getName: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  resolve(@"SeosMobileKeysModule custom modules from RN");
}

RCT_EXPORT_METHOD(initializeSDK:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  // Check if MobileKeysManager has an init method
  //   MobileKeysManager *manager = [[MobileKeysManager alloc] init];
  //
  //   if (manager) {
  //       resolve(@YES);
  //   } else {
  //       reject(@"INIT_ERROR", @"Failed to initialize MobileKeysManager", nil);
  //   }
  //  MobileKeysController *manager = [[MobileKeysController alloc] init];
  dispatch_sync(dispatch_get_main_queue(), ^{
    [[MobileKeysController sharedInstance] start];
  });
  resolve(@"mobile keys controller sdk started successfully");
  //  NSString *message =
  //  [manager start];
  //  if (message) {
  //    resolve(message);
  //  } else{
  //    reject(@"INIT_ERROR", @"Failed to initialize swift class manager", nil);
  //  }
  
}

RCT_EXPORT_METHOD(enableSDK:(NSString *)invitationCode) {
  if (![invitationCode isEqualToString:@""]) {  // Check if the string is not empty
    dispatch_async(dispatch_get_main_queue(), ^{
      [[MobileKeysController sharedInstance] didPressRegistrationButton:invitationCode];
    });
  }
}

RCT_EXPORT_METHOD(setupEndpoint){
  dispatch_async(dispatch_get_main_queue(), ^{
    [[MobileKeysController sharedInstance] setupEndpoint];
  });
}

//RCT_EXPORT_METHOD(getTheMobileKeys:(RCTPromiseResolveBlock)resolve
//                  rejecter:(RCTPromiseRejectBlock)reject) {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // ✅ Get MobileKeysController instance
//        MobileKeysController *mobileKeysManager = [MobileKeysController sharedInstance];
//
//        // ✅ Call getTheMobileKeys
//        NSArray *keys = [mobileKeysManager getTheMobileKeys];
//
////        if (keys == nil || [keys count] == 0) {
//////            RCTLogError(@"No keys found.");
////            reject(@"NO_KEYS", @"No mobile keys available", nil);
////        } else {
//            // ✅ Log raw response for debugging
//            NSLog(@"DEBUG Raw Mobile Keys Response: %@", keys);
//            RCTLogInfo(@"DEBUG Raw Mobile Keys Response: %@", keys);
//
//            // ✅ Send the response back to React Native
//            resolve(keys);
////        }
//    });
//}


// ✅ Convert any Objective-C object to NSDictionary dynamically
- (NSDictionary *)dictionaryFromObject:(id)obj {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  unsigned int propertyCount;
  objc_property_t *properties = class_copyPropertyList([obj class], &propertyCount);
  
  for (unsigned int i = 0; i < propertyCount; i++) {
    const char *propertyName = property_getName(properties[i]);
    NSString *key = [NSString stringWithUTF8String:propertyName];
    
    id value = [obj valueForKey:key];
    if (value) {
      dict[key] = value;
    } else {
      dict[key] = @"null"; // Handle nil values
    }
  }
  
  free(properties);
  return dict;
}

RCT_EXPORT_METHOD(getSavedKey:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
  NSArray *keys = [[MobileKeysController sharedInstance] keys];
  if (keys == nil || [keys count] == 0) {
    RCTLogError(@"No mobile keys found.");
    reject(@"NO_KEYS", @"No mobile keys available", nil);
  } else {
    NSMutableArray *keysArray = [NSMutableArray array];
    
    for (id key in keys) {
      NSDictionary *keyDict = [self dictionaryFromObject:key];
      [keysArray addObject:keyDict];
    }
    
    // ✅ Log full key details
    NSLog(@"Mobile Keys Data: %@", keysArray);
    RCTLogInfo(@"Mobile Keys Data: %@", keysArray);
    
    // ✅ Send formatted keys back to React Native
    resolve(keysArray);
  }
  
}

// ✅ Fetch mobile keys and return as JSON to React Native
RCT_EXPORT_METHOD(getTheMobileKeys:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    // ✅ Get MobileKeysController instance
    MobileKeysController *mobileKeysManager = [MobileKeysController sharedInstance];
    
    // ✅ Fetch mobile keys
    NSArray *keys = [mobileKeysManager getTheMobileKeys];
    
    if (keys == nil || [keys count] == 0) {
      RCTLogError(@"No mobile keys found.");
      reject(@"NO_KEYS", @"No mobile keys available", nil);
    } else {
      NSMutableArray *keysArray = [NSMutableArray array];
      
      for (id key in keys) {
        NSDictionary *keyDict = [self dictionaryFromObject:key];
        [keysArray addObject:keyDict];
      }
      
      // ✅ Log full key details
      NSLog(@"Mobile Keys Data: %@", keysArray);
      RCTLogInfo(@"Mobile Keys Data: %@", keysArray);
      
      // ✅ Send formatted keys back to React Native
      resolve(keysArray);
    }
  });
}

RCT_EXPORT_METHOD(toggleScanning:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    BOOL state = [[MobileKeysController sharedInstance] toggleScanning];
    resolve(@(state));
  });
}

RCT_EXPORT_METHOD(scanningState:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    BOOL state = [[MobileKeysController sharedInstance] scanningState]; // ✅ Get BOOL value
    resolve(@(state)); // ✅ Convert BOOL to NSNumber before resolving
  });
}


/// Required for React Native
+ (BOOL)requiresMainQueueSetup {
  return YES;
}

@end
