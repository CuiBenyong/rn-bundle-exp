/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "CBYEvent.h"
#import <React/RCTAssert.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>

@implementation CBYEvent
{
    NSInteger _listenerCount;
}
RCT_EXPORT_MODULE();



+ (void)initialize
{
    if (self != [CBYEvent class]) {
        RCTAssert(RCTClassOverridesInstanceMethod(self, @selector(supportedEvents)),
                  @"You must override the `supportedEvents` method of %@", self);
    }
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"viewShow"];
}

- (void)sendEventWithName:(NSString *)eventName body:(id)body
{
    RCTAssert(_bridge != nil, @"Error when sending event: %@ with body: %@. "
              "Bridge is not set. This is probably because you've "
              "explicitly synthesized the bridge in %@, even though it's inherited "
              "from RCTEventEmitter.", eventName, body, [self class]);
    
    if (RCT_DEBUG && ![[self supportedEvents] containsObject:eventName]) {
        RCTLogError(@"`%@` is not a supported event type for %@. Supported events are: `%@`",
                    eventName, [self class], [[self supportedEvents] componentsJoinedByString:@"`, `"]);
    }
    if (_listenerCount > 0) {
        [_bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                        method:@"emit"
                          args:body ? @[eventName, body] : @[eventName]
                    completion:NULL];
    } else {
        RCTLogWarn(@"Sending `%@` with no listeners registered.", eventName);
    }
}

- (void)startObserving
{
    // Does nothing
}

- (void)stopObserving
{
    // Does nothing
}

- (void)dealloc
{
    if (_listenerCount > 0) {
        [self stopObserving];
    }
}

RCT_EXPORT_METHOD(addListener:(NSString *)eventName)
{
    if (RCT_DEBUG && ![[self supportedEvents] containsObject:eventName]) {
        RCTLogError(@"`%@` is not a supported event type for %@. Supported events are: `%@`",
                    eventName, [self class], [[self supportedEvents] componentsJoinedByString:@"`, `"]);
    }
    _listenerCount++;
    if (_listenerCount == 1) {
        [self startObserving];
    }
}

RCT_EXPORT_METHOD(removeListeners:(double)count)
{
    int currentCount = (int)count;
    if (RCT_DEBUG && currentCount > _listenerCount) {
        RCTLogError(@"Attempted to remove more %@ listeners than added", [self class]);
    }
    _listenerCount = MAX(_listenerCount - currentCount, 0);
    if (_listenerCount == 0) {
        [self stopObserving];
    }
}

@end
