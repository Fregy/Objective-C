//
//  XMLClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "XMLClass.h"
#import "RegexKitLite.h"

@implementation XMLClass

- (NSMutableArray *) getXMLParsing:(NSURL *)url {
    
    _bandXML                =   NO;
    _bandNews               =   NO;
    _bandLink               =   NO;
    _bandDescription        =   NO;
    
    _currentElement         =   [[NSString alloc] init];
    _myXml                  =   [[NSMutableArray alloc] init];
    _myString               =   [[NSMutableString alloc] init];
    _news                   =   [[NewsClass alloc] init];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    _parser                  =   [[NSXMLParser alloc] initWithData:data];
    _parser.delegate         =   self;
    [_parser parse];

    _news.myHtml = [[NSString stringWithFormat:@"%@", _myString] stringByReplacingOccurrencesOfString:@"<img src=\"" withString:@"<img src=\"http:"];
    _news.myDescription = [_news.myHtml stringByReplacingOccurrencesOfRegex:@"<[^>]+>" withString:@""];
    [_myXml addObject:_news];
    
    return _myXml;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (_bandXML) {
        if ([_currentElement isEqualToString:@"description"]) {
            [_myString appendString:string];
           
        } else if ([_currentElement isEqualToString:@"title"]) {
            [_myString appendString:string];
            _news.myNews = [NSString stringWithFormat:@"%@", _myString];
            
        } else if ([_currentElement isEqualToString:@"link"]) {
            [_myString appendString:string];
            _news.myLink = [NSString stringWithFormat:@"%@", _myString];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        _bandXML = YES;
        if (![_myString isEqualToString:@""]) {
            _news.myHtml = [[NSString stringWithFormat:@"%@", _myString] stringByReplacingOccurrencesOfString:@"<img src=\"" withString:@"<img src=\"http:"];
            _news.myDescription = [_news.myHtml stringByReplacingOccurrencesOfRegex:@"<[^>]+>" withString:@""];
            [_myXml addObject:_news];
            _news                   =   [[NewsClass alloc] init];
        }
    }
    
    [_myString setString:@""];
    
    _currentElement  =   elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    _currentElement  =   @"";
}
@end
