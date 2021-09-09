//
//  ReactExecuteScript.h
//  Pods
//
//  Created by 崔本勇 on 2020/2/11.
//

#ifndef ReactExecuteScript_h
#define ReactExecuteScript_h
#import <React/RCTBridge.h>
@interface RCTBridge (ReactExecuteScript)

- (void)executeSourceCode:(NSData *)sourceCode sync:(BOOL)sync;

- (void)executeSourceCode:(NSData *)sourceCode bundleUrl:(NSURL *)bundleUrl sync:(BOOL)sync;

@end
#endif /* ReactExecuteScript_h */
