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

@property NSString *title;

-(id)initWithTitle:(NSString *)title;
@end

@interface RssFeed : NSObject {
    NSString    *m_title;
    NSString    *m_link;
    NSString    *m_website;
    NSString    *m_description;
    RssCategory *m_category;
    int         m_rate; // From 0 to 4
    
    RssFeedPK   *m_rssFeedPK;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *website;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, retain) RssCategory *category;
@property int rate;

- (id)initWithRssFeedPK:(RssFeedPK *)rssFeedPK;
- (RssFeedPK *)rssFeedPK;

- (BOOL)isEqual:(id)object;
@end
