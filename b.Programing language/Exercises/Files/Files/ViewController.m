//
//  ViewController.m
//  Files
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Colors.h"

@interface ViewController ()

@property(strong, nonatomic)NSString *fileName;
@property(strong,nonatomic)UIColor * col;
@property(weak,nonatomic)NSString *file;

@property(weak,nonatomic)NSArray *paths;
@property(strong,nonatomic)NSString *documentsDir;

@property(strong,nonatomic)NSMutableArray *array;
@property(strong,nonatomic)NSString *data;

@property(strong,nonatomic)NSArray *arrayColors;
@property(strong,nonatomic)NSString *path;
@property(strong,nonatomic)NSString *contain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fileName = [[self documentsPath] stringByAppendingPathComponent:@"ColorFile.txt"];
    
    if ([self readFromFile:self.fileName] != nil) {
        
        self.file = [self readFromFile:self.fileName];
        
        self.col = [self colorWithHexString:self.file];
        
        self.view.backgroundColor = self.col;
        
        if ([self.view.backgroundColor isEqual: [UIColor blueColor]]) {
            self.ButtonColor.tintColor = [UIColor whiteColor];
            self.ButtonFile1Color.tintColor = [UIColor whiteColor];
            self.ButtonFile2Color.tintColor = [UIColor whiteColor];
        } else {
            self.ButtonColor.tintColor = [UIColor blueColor];
            self.ButtonFile1Color.tintColor = [UIColor blueColor];
            self.ButtonFile2Color.tintColor = [UIColor blueColor];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *) documentsPath {
    
    self.paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    self.documentsDir = [self.paths objectAtIndex:0];
    
    return self.documentsDir;
}

-(void) writeToFile:(NSString *)text withFileName:(NSString *)filePath {
    
    self.array = [[NSMutableArray alloc]init];
    
    [self.array addObject:text];
    
    [self.array writeToFile:filePath atomically:YES];
    
    self.array = nil;
}

-(NSString *) readFromFile:(NSString *)filePath {
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        self.array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        
        self.data = [NSString stringWithFormat:@"%@", [self.array objectAtIndex:0]];
        
        self.array = nil;

        
        return self.data;
    }
    else
        return nil;
}

-(UIColor *)colorWithHexString:(NSString *)hexString
{
    
    NSUInteger red;
    NSUInteger green;
    NSUInteger blue;
    
    sscanf([hexString UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
}

- (NSString *)hexStringFromColor:(UIColor *)color {
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

- (IBAction)PressColor:(UIButton *)sender {
    
    int var = rand() % 8;
    
    self.arrayColors = [self  colors];
    
    id deep = [self.arrayColors objectAtIndex:var];
    
    if (deep != self.view.backgroundColor) {
        
        self.view.backgroundColor = deep;
        
        self.fileName = [[self documentsPath] stringByAppendingPathComponent:@"ColorFile.txt"];
        
        [self writeToFile:[self hexStringFromColor:self.view.backgroundColor] withFileName:self.fileName];
        
        if (self.view.backgroundColor == [UIColor blueColor]) {
            self.ButtonColor.tintColor = [UIColor whiteColor];
            self.ButtonFile1Color.tintColor = [UIColor whiteColor];
            self.ButtonFile2Color.tintColor = [UIColor whiteColor];
        } else {
            self.ButtonColor.tintColor = [UIColor blueColor];
            self.ButtonFile1Color.tintColor = [UIColor blueColor];
            self.ButtonFile2Color.tintColor = [UIColor blueColor];
        }
    
    } else {
        
        deep = [self.arrayColors objectAtIndex:var+1];
        
        self.view.backgroundColor = deep;
        
        self.fileName = [[self documentsPath] stringByAppendingPathComponent:@"ColorFile.txt"];
        
        [self writeToFile:[self hexStringFromColor:self.view.backgroundColor] withFileName:self.fileName];
        
        if (self.view.backgroundColor == [UIColor blueColor]) {
            self.ButtonColor.tintColor = [UIColor whiteColor];
            self.ButtonFile1Color.tintColor = [UIColor whiteColor];
            self.ButtonFile2Color.tintColor = [UIColor whiteColor];
        } else {
            self.ButtonColor.tintColor = [UIColor blueColor];
            self.ButtonFile1Color.tintColor = [UIColor blueColor];
            self.ButtonFile2Color.tintColor = [UIColor blueColor];
        }
        
    }
}

- (IBAction)ButtonFile1:(UIButton *)sender {
    
    if (self.TextFile1.text.length > 0 && self.TextFile2.text.length > 0) {
        
        self.path = self.TextFile1.text;
        self.contain = self.TextFile2.text;
        
        self.path = [self.path stringByAppendingString:@".log"];
        
        self.fileName = [[self documentsPath] stringByAppendingPathComponent: self.path];
        
        if ([self readFromFile:self.fileName] == nil) {
        
            [self writeToFile: self.contain withFileName:self.fileName];
            
            self.LabelFiles.text = @"File Added.";
            self.TextFile1.text = @"";
            self.TextFile2.text = @"";
            
        } else {
            
            self.LabelFiles.text = @"That File already Exist.";
            self.TextFile1.text = @"";
            self.TextFile2.text = @"";
            
        }
        
    } else {
        
        self.LabelFiles.text = @"Please Add some informations.";
    
    }
    
}

- (IBAction)ButtonFile2:(UIButton *)sender {

    self.path = self.TextFile1.text;
    
    self.path = [self.path stringByAppendingString:@".log"];
    
    if (self.TextFile1.text.length > 0) {
        
        self.fileName = [[self documentsPath] stringByAppendingPathComponent: self.path];
        
        self.TextFile2.text = [self readFromFile:self.fileName];
        
        self.LabelFiles.text = @"File Retrived.";
        
        
    } else {
        
        self.LabelFiles.text = @"Please Add the File's Name.";
        self.TextFile2.text = @"";
    
    }
}
@end
