//
//  TIMAppLocator.h
//
//  Created by Tim Schröder on 23.03.13.
//  Copyright (c) 2013 Tim Schröder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIMAppLocator : NSObject <NSMetadataQueryDelegate>

-(BOOL)locateAppWithBundleIdentifier:(NSString*)bundleIdentifier;

@property (strong) NSMetadataQuery *query; // necessary with ARC to have the query retained until it finishes gathering
@property (assign) id delegate; // has to follow the TIMAppLocatorProtocol

@end
