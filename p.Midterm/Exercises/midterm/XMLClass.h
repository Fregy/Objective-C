//
//  XMLClass.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsClass.h"

@interface XMLClass : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NewsClass                 *news;

@property (nonatomic)         BOOL                      bandXML;
@property (nonatomic)         BOOL                      bandNews;
@property (nonatomic)         BOOL                      bandLink;
@property (nonatomic)         BOOL                      bandDescription;

@property (strong, nonatomic) NSXMLParser               *parser;

@property (strong, nonatomic) NSString                  *currentElement;
@property (strong, nonatomic) NSMutableString           *myString;

@property (strong, nonatomic) NSMutableArray            *myXml;

- (NSMutableArray *)getXMLParsing:(NSURL *)url;

@end
