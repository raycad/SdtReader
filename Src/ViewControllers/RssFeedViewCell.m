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
@synthesize thumbnailImageView  = m_thumbnailImageView;
@synthesize rssFeed             = m_rssFeed;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        m_titleLabel = [[UILabel alloc]init];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_titleLabel.font = [UIFont systemFontOfSize:15];
        /*m_idNumberLabel = [[UILabel alloc]init];
        m_idNumberLabel.textAlignment = UITextAlignmentLeft;
        //m_categoryLabel.font = [UIFont systemFontOfSize:10];
        m_idNumberLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Arial; font-size: 11px; font-weight: bold; font-style : italic;"];
        m_idNumberLabel.textColor = [UIColor orangeColor];*/
        m_thumbnailImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:m_titleLabel];
        //[self.contentView addSubview:m_idNumberLabel];
        [self.contentView addSubview:m_thumbnailImageView];        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame = CGRectMake(boundsX+10 ,0, 50, 50);
    m_thumbnailImageView.frame = frame;
    
    frame = CGRectMake(boundsX+70 ,5, 200, 25);
    m_titleLabel.frame = frame;
    
    /*frame = CGRectMake(boundsX+70 ,32, 100, 15);
    m_idNumberLabel.frame = frame;*/
}

- (void)dealloc
{
    [m_rssFeed release];
    [m_titleLabel release];
    [m_thumbnailImageView release];
}
@end