//
//  WebViewController.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic) BOOL                  bandR;

@property (strong, nonatomic) NSString      *myLink;
@property (strong, nonatomic) NSString      *myHtml;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
