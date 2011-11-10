//
//  RssFeedViewCell.h
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssFeed.h"

@interface RssFeedViewCell : UITableViewCell {
    UILabel     *m_titleLabel;
    UIImageView *m_thumbnailImageView;
    RssFeed     *m_rssFeed;
}

@property (nonatomic, retain) UILabel     *titleLabel;
@property (nonatomic, retain) UIImageView *thumbnailImageView;
@property (nonatomic, retain) RssFeed     *rssFeed;
@end
