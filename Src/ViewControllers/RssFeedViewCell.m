//
//  StudentViewCell.m
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssFeedViewCell.h"

@implementation RssFeedViewCell

@synthesize titleLabel          = m_titleLabel;
@synthesize indexLabel          = m_indexLabel;
@synthesize thumbnailImageView  = m_thumbnailImageView;
@synthesize rssFeed             = m_rssFeed;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        m_titleLabel = [[UILabel alloc]init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_titleLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 16px; font-weight: bold;"];
        
        m_indexLabel = [[UILabel alloc]init];
        m_indexLabel.textAlignment = UITextAlignmentRight;
        //m_indexLabel.font = [UIFont systemFontOfSize:10];
        m_indexLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 15px; font-weight: bold; font-style : italic;"];
        m_indexLabel.textColor = [UIColor grayColor];
        
        m_thumbnailImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:m_titleLabel];
        [self.contentView addSubview:m_indexLabel];
        [self.contentView addSubview:m_thumbnailImageView];        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat leftBoundsX = contentRect.origin.x;
    CGFloat rightBoundsX = contentRect.size.width;
    CGRect frame;
    frame = CGRectMake(leftBoundsX+7, 7, 35, 35);
    m_thumbnailImageView.frame = frame;
    
    frame = CGRectMake(leftBoundsX+52, 5, 170, 25);
    m_titleLabel.frame = frame;
    
    frame = CGRectMake(rightBoundsX-50, 18, 40, 20);
    m_indexLabel.frame = frame;
}

- (void)dealloc
{
    [m_rssFeed release];
    [m_titleLabel release];
    [m_indexLabel release];
    [m_thumbnailImageView release];
}
@end