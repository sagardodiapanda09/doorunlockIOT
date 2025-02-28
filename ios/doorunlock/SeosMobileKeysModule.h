//
//  SeosMobileKeysModule.h
//  doorunlock
//
//  Created by Arun Patel on 25/02/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
//#import "doorunlock-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeosMobileKeysModule : RCTEventEmitter <RCTBridgeModule>

- (void)emitEventWithName:(NSString *)name body:(id)body;

@end

NS_ASSUME_NONNULL_END
