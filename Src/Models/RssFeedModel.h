//
//  RssFeedModel.h
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssFeed.h"

@interface RssFeedModel : NSObject {
    NSMutableArray  *m_rssFeedList;    
}

- (BOOL)addRssFeed:(RssFeed *)rssFeed;
- (RssFeed *)getRssFeedByPK:(RssFeedPK *)RssFeedPK;

- (BOOL)removeRssFeedByPK:(RssFeedPK *)rssFeedPK;
- (BOOL)removeRssFeedByIndex:(int)index;
- (BOOL)removeRssFeed:(RssFeed *)rssFeed;

- (RssFeed *)rssFeedAtIndex:(int)index;

- (BOOL)copyDataFrom:(RssFeedModel *)other;

- (RssFeedModel *)searchByTitle:(NSString *)searchText;
- (RssFeedModel *)searchByRate:(int)rate;

- (void)clear;

- (int)count;
@end
