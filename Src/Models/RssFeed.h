//
//  RssFeed.h
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssCategory.h"

@interface RssFeedPK : NSObject {
    NSString *m_title;    
}

@property (nonatomic, strong) NSString *title;

-(id)initWithTitle:(NSString *)title;
@end

@interface RssFeed : NSObject {
    int         m_rssFeedId;
    NSString    *m_title;
    NSString    *m_link;
    NSString    *m_website;
    NSString    *m_description;
    RssCategory *m_rssCategory;
    int         m_rate; // From 0 to 4
    
    RssFeedPK   *m_rssFeedPK;
}

@property (nonatomic)           int         rssFeedId;
@property (nonatomic, strong)     NSString    *title;
@property (nonatomic, strong)     NSString    *link;
@property (nonatomic, strong)     NSString    *website;
@property (nonatomic, strong)     NSString    *description;
@property (nonatomic, strong)   RssCategory *rssCategory;
@property int rate;

- (id)initWithRssFeedPK:(RssFeedPK *)rssFeedPK;
- (RssFeedPK *)rssFeedPK;

- (BOOL)isEqual:(id)object;
@end
