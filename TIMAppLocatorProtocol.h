//
//  TIMAppLocatorProtocol.h
//
//  Created by Tim Schröder on 23.03.13.
//  Copyright (c) 2013 Tim Schröder. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TIMAppLocatorProtocol <NSObject>

@required

-(void)appLocations:(NSArray*)locations;

@end
