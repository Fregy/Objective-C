//
//  ViewController.h
//  Files
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (NSString *) documentsPath;
- (NSString*) readFromFile: (NSString *) filePath;
- (void) writeToFile:(NSString *) text withFileName: (NSString *) filePath;
-(UIColor *)colorWithHexString:(NSString *)hexString;
- (NSString *)hexStringFromColor:(UIColor *)color;

- (IBAction)PressColor:(UIButton *)sender;
@property (nonatomic) NSInteger var;
@property (strong, nonatomic) IBOutlet UIButton *ButtonColor;
//
@property (strong, nonatomic) IBOutlet UILabel *LabelFiles;
@property (strong, nonatomic) IBOutlet UITextField *TextFile1;
@property (strong, nonatomic) IBOutlet UITextView *TextFile2;

- (IBAction)ButtonFile1:(UIButton *)sender;
- (IBAction)ButtonFile2:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *LabelDocumentationName;
@property (strong, nonatomic) IBOutlet UILabel *LabelAddInformation;
@property (strong, nonatomic) IBOutlet UIButton *ButtonFile1Color;
@property (strong, nonatomic) IBOutlet UIButton *ButtonFile2Color;


@end

