//
//  RssFeed.h
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>

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
    
    RssFeedPK   *m_rssFeedPK;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *website;
@property (nonatomic, copy) NSString *description;

- (id)initWithRssFeedPK:(RssFeedPK *)rssFeedPK;
- (RssFeedPK *)rssFeedPK;

- (BOOL)isEqual:(id)object;
@end
