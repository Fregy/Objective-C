//
//  ViewController.m
//  XML&Json
//
//  Created by Alfredo Alba on 10/19/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "SongTableViewCell.h"
#import "sqlite3.h"

#define URLJson     [NSURL URLWithString: @"http://itunes.apple.com/us/rss/topalbums/limit=10/json"]

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sql                =   [[SQLiteClass alloc] init];
    _song               =   [[SongClass alloc] init];
    _json               =   [[JSONClass alloc] init];
    
    _songsArray         =   [[NSArray alloc] init];
    
    NSString            * docsDirectory;
    NSArray             * dirPaths;
    
    dirPaths            = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    docsDirectory       =   [dirPaths objectAtIndex:0];
    _databasePath       =   [[NSString alloc] initWithString:[docsDirectory stringByAppendingPathComponent:@"songs.db"]];
    
    NSDictionary * dic  = [NSDictionary dictionaryWithObjectsAndKeys: @"TEXT UNIQUE", @"GENRE", nil];
    
    [_sql CreateTableDB:_databasePath dataBase:songDB table:@"GENRES" atrib:dic];
    
    dic                 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"TEXT UNIQUE", @"SONG",
                          @"TEXT", @"ALBUM",
                          @"TEXT", @"FAVORITE",
                          @"INTEGER", @"GENREID", nil];
    
    [_sql CreateTableForeignDB:_databasePath dataBase:songDB table:@"SONGS" atrib:dic foreignValue:@"GENREID" foreignEntity:@"GENRE" ];
    
    
    
    dispatch_async(mainQueue, ^{
        
        _json.delegate  =   self;
        [_json dataRetreived:URLJson];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TABLE VIEW
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%ld", (long)[_sql NumberOfTable:_databasePath dataBase:songDB table:@"GENRES" element:@"genre"]);
    return [_sql NumberOfTable:_databasePath dataBase:songDB table:@"GENRES" element:@"genre"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"%@", [_sql GetIDFromQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT GENRE FROM GENRES WHERE ID = %ld", section+1]]);
    return [_sql GetIDFromQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT GENRE FROM GENRES WHERE ID = %ld", section+1]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sql NumberOfTable:_databasePath dataBase:songDB table:[NSString stringWithFormat:@"SONGS WHERE GENREID = %ld", section+1] element:@"song"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SongTableViewCell *cell = (SongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.lbSong.text    =   [[_sql GetFromQueryArray:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT song FROM SONGS WHERE GENREID = %ld", indexPath.section+1]] objectAtIndex:indexPath.row];
    cell.lbAlbum.text  =    [[_sql GetFromQueryArray:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT album FROM SONGS WHERE GENREID = %ld", indexPath.section+1 ]]objectAtIndex:indexPath.row];
    cell.lbGenre.text   =   [_sql GetIDFromQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT GENRE FROM GENRES WHERE ID = %ld", indexPath.section+1]];
    cell.imgFav.image   =   [UIImage imageNamed:[_sql GetIDFromQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT favorite FROM SONGS WHERE song = '%@'", cell.lbSong.text]]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SongTableViewCell *cell = (SongTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([[_sql GetIDFromQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT favorite FROM SONGS WHERE song = '%@'", cell.lbSong.text]] isEqualToString:@"fav"]) {
        
        if ([_sql ModifyElementQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"UPDATE SONGS SET favorite = 'N' WHERE GENREID = %ld and song = '%@'",indexPath.section+1, cell.lbSong.text]]) {
            cell.imgFav.image   =   [UIImage imageNamed:@"N"];
        }
    } else {
        
        if ([_sql ModifyElementQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"UPDATE SONGS SET favorite = 'fav' WHERE GENREID = %ld and song = '%@'",indexPath.section+1, cell.lbSong.text]]) {
            cell.imgFav.image   =   [UIImage imageNamed:@"fav"];
        }
    }
}

-(void)didFinishJSon:(NSArray *)data {
    
    _songsArray =   data;
    
    for (SongClass *s in data) {
        NSString * query    =   [NSString stringWithFormat:@"INSERT INTO GENRES (GENRE) VALUES ('%@')",s.myGenre];
        
        [_sql InsertElementsDBQuery:_databasePath dataBase:songDB query:query];
    }
    for (SongClass *s in data) {
        
        NSInteger foreign   =   [[_sql GetIDFromQuery:_databasePath dataBase:songDB query:[NSString stringWithFormat:@"SELECT ID FROM GENRES WHERE GENRE = '%@'", s.myGenre]] integerValue];
        
        NSString  * query    =   [NSString stringWithFormat:@"INSERT INTO SONGS (SONG, ALBUM, GENREID, FAVORITE) VALUES ('%@', '%@', %ld, 'N')", s.myTitle , s.myAlbum, (long)foreign];
        
        [_sql InsertElementsDBQuery:_databasePath dataBase:songDB query:query];
    }
    
    [_tableView reloadData];
}

@end
