//
//  ReaderModel.m
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//
#import "ReaderModel.h"


@implementation ReaderModel

static ReaderModel *_instance = nil;

+ (ReaderModel *)instance
{
	@synchronized([ReaderModel class]) {
		if (!_instance)
			[[self alloc] init];
        
		return _instance;
	}
    
	return nil;
}

+ (id)alloc
{
	@synchronized([ReaderModel class]) {
		NSAssert(_instance == nil, @"Attempted to allocate a second instance of a singleton.");
		_instance = [super alloc];
		return _instance;
	}
    
	return nil;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		// Initialize parameters
	}
    
	return self;
}

@end
