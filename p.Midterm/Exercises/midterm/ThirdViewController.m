//
//  ThirdViewController.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bandFree       =   YES;
    _bandLine       =   NO;
    _bandCircle     =   NO;
    
    _currentPoint   =   CGPointMake(0.0, 0.0);
    
    _red            =   255.0/255.0;
    _green          =   102.0/255.0;
    _blue           =   0.0/255.0;
    _brush          =   4.0;
    _opacity        =   1.0;
    
    _sql            =   [[SQLiteClass alloc] init];
    _context        =   [[ContextClass alloc] init];
    
    NSString* docsDirectory;
    NSArray* dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDirectory       =   [dirPaths objectAtIndex:0];
    _databasePath       =   [[NSString alloc] initWithString:[docsDirectory stringByAppendingPathComponent:@"draw.db"]];
    
    NSDictionary * dic  =   [NSDictionary dictionaryWithObjectsAndKeys:
                             @"BLOB", @"image", nil];
    
    [_sql CreateTableDB:_databasePath dataBase:drawDB table:@"IMAGE" atrib:dic];
    
    if([_sql NumberOfTable:_databasePath dataBase:drawDB table:@"IMAGE" element:@"image"] > 0) {
        [_sql showImage:_databasePath dataBase:drawDB table:@"IMAGE" atrib:@"image" image:self.mainImage];
    }
}

- (void)saveImage {
    [_sql ResetTableValues:_databasePath dataBase:drawDB table:@"IMAGE"];
    
    NSDictionary * dic  =   [NSDictionary dictionaryWithObjectsAndKeys:
                             @"BLOB", @"image", nil];
    
    [_sql CreateTableDB:_databasePath dataBase:drawDB table:@"IMAGE" atrib:dic];
    
    [_sql saveImage:_databasePath dataBase:drawDB table:@"IMAGE" atrib:@"image" image:self.mainImage];
}

- (void)colorLine:(NSInteger)color {
    
    switch(color)
    {
        case 0: // BLACK
            _red = 0.0/255.0;
            _green = 0.0/255.0;
            _blue = 0.0/255.0;
        break;
        case 1: // RED
            _red = 255.0/255.0;
            _green = 0.0/255.0;
            _blue = 0.0/255.0;
        break;
        case 2: // GREEN
            _red = 102.0/255.0;
            _green = 255.0/255.0;
            _blue = 0.0/255.0;
        break;
        case 3: // BLUE
            _red = 51.0/255.0;
            _green = 204.0/255.0;
            _blue = 255.0/255.0;
        break;
        case 4: // ORANGE
            _red = 255.0/255.0;
            _green = 102.0/255.0;
            _blue = 0.0/255.0;
        break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _mouseSwiped    =   NO;
    UITouch *touch  =   [touches anyObject];
    _lastPoint      =   [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    _currentPoint = [touch locationInView:self.view];
    
    if (_bandFree) {
    
        [_context makeLine:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity];
        
        _lastPoint = _currentPoint;
    } else if (_bandLine) {
        [self colorLine:3];
        self.tempImage.image = nil;
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        [_context makeLine:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity];
        
    } else if (_bandCircle) {
        [self colorLine:3];
        self.tempImage.image = nil;
        
        float circle= [_context calculateDistanceBetween:_currentPoint point2:_lastPoint];

        [_context makeCircle:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity distance:circle];
        
        [self colorLine:1];
        
        [_context makeLine:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_bandFree) {
        
        if(!_mouseSwiped) {
            [_context makeLine:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity];
        }
        
        [_context imageViewPagination:self.view principal:self.mainImage theCanvas:self.tempImage opacityValue:_opacity];
        
    } else if (_bandLine) {
        
        [self colorLine:2];
        
        if(!_mouseSwiped) {
            [_context makeLine:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity];
        }
        [_context makeLine:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity];
        
        [_context imageViewPagination:self.view principal:self.mainImage theCanvas:self.tempImage opacityValue:_opacity];
    } else if (_bandCircle) {
        
        [self colorLine:1];
        
        self.tempImage.image = nil;
        
        float circle= [_context calculateDistanceBetween:_currentPoint point2:_lastPoint];

        [_context makeCircle:self.view theCanvas:self.tempImage colorRed:_red colorGreen:_green colorBlue:_blue theBrush:_brush lastPoint:_lastPoint currentPoint:_currentPoint opacityValue:_opacity distance:circle];
        

        [_context imageViewPagination:self.view principal:self.mainImage theCanvas:self.tempImage opacityValue:_opacity];
    }
    [self saveImage];
}

- (IBAction)bFree:(UIButton *)sender {
    _bandFree       =   YES;
    _bandLine       =   NO;
    _bandCircle     =   NO;
    
    [self colorLine:4];
}

- (IBAction)bLine:(UIButton *)sender {
    _bandFree       =   NO;
    _bandLine       =   YES;
    _bandCircle     =   NO;
}

- (IBAction)bCircle:(UIButton *)sender {
    _bandFree       =   NO;
    _bandLine       =   NO;
    _bandCircle     =   YES;
}

- (IBAction)bClear:(UIButton *)sender {
    self.mainImage.image = nil;
    
    _bandFree       =   YES;
    _bandLine       =   NO;
    _bandCircle     =   NO;
    
    [self colorLine:4];
}

@end
