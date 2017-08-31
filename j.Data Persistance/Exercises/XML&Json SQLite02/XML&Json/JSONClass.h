//
//  JSONClass.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParsingJSONClass.h"

@protocol JSONClassDelegate <NSObject>

-(void)didFinishJSon:(NSArray *)data;

@end

@interface JSONClass : NSObject <ParsingJSONClassDelegate>

@property (strong, nonatomic) ParsingJSONClass      *parsing;

@property (weak, nonatomic) id<JSONClassDelegate> delegate;

- (void)dataRetreived:(NSURL*) url;

@end
