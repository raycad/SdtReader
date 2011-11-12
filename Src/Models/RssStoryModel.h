//
//  RssStoryModel.h
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssStory.h"

@interface RssStoryModel : NSObject {
    NSMutableArray  *m_rssStoryList;    
}

- (BOOL)addRssStory:(RssStory *)rssStory;

- (RssStory *)rssStoryAtIndex:(int)index;

- (BOOL)copyDataFrom:(RssStoryModel *)other;

- (void)clear;

- (int)count;
@end