//
//  ReaderModel.h
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssFeedModel.h"

@interface ReaderModel : NSObject {
    RssFeedModel *m_rssFeedModel; 
}

// Declare the singleton
+ (ReaderModel *)instance;

@property (nonatomic, retain) RssFeedModel *rssFeedModel;
@end
