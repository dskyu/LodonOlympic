//
//  DB.m
//  exploreolympic
//
//  Created by bunny on 12-4-11.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "DB.h"

@implementation DB

-(void)createDatabaseIfNeeded:(NSString *)filename{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) 
        return;
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] 
							   stringByAppendingPathComponent:filename];

    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) { 
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
    [pool release];
    
}
-(void)openDB {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documenthPath = [[paths objectAtIndex:0] 
							   stringByAppendingPathComponent:DbFile];
	int returnValue = sqlite3_open([documenthPath UTF8String], &database);
   
    if (returnValue != SQLITE_OK) {
        sqlite3_close(database);   
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
}

-(void)closeDB {
    if(sqlite3_close(database)!=SQLITE_OK)
		NSAssert1(0,@"Error while closing the connection to th db.%s",sqlite3_errmsg(database));

}

-(NSArray *) fetchQuery:(NSString *) query{
    
    sqlite3_stmt* stmt;
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    char const *sql = [query UTF8String];
    if (sqlite3_prepare(database, sql, strlen(sql), &stmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW) { 
            int col = sqlite3_column_count(stmt);
            for (int i=0; i<col; i++) {
                NSString *d=[[[NSString alloc] initWithCString:(char *)sqlite3_column_text(stmt, i) encoding:NSUTF8StringEncoding] autorelease]; 
                [result addObject:d];
                
            }
        }
    }
    else
    {
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
    }
    sqlite3_finalize(stmt);
    return result;
}

-(NSDictionary *) fetchMutliQuery:(NSString *) query{
    
    sqlite3_stmt* stmt;
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:150];
    NSMutableArray *resultcol = [[NSMutableArray alloc] initWithCapacity:11];
    char const *sql = [query UTF8String];
    if (sqlite3_prepare(database, sql, strlen(sql), &stmt, NULL) == SQLITE_OK)
    {
        
        NSInteger index = 0;
        while (sqlite3_step(stmt)==SQLITE_ROW) { 
            int col = sqlite3_column_count(stmt);
            for (int i=0; i<col; i++) {
                NSMutableString *value=[[[NSMutableString alloc] initWithCString:(char *)sqlite3_column_text(stmt, i) encoding:NSUTF8StringEncoding] autorelease]; 
                
                [resultcol addObject:value];
                
            }
            [result setValue:[resultcol copy] forKey:[NSString stringWithFormat:@"%d",index]];
            [resultcol removeAllObjects];
           
            index ++;
        }

    }
    else
    {
        NSLog(@"%@",[NSString stringWithCString:sqlite3_errmsg(database) encoding:NSUTF8StringEncoding]);
    }
    sqlite3_finalize(stmt);
    [resultcol release];
    return result;
}

-(BOOL) execQuery:(NSString *) query
{
    char const *sql = [query UTF8String];
    if (sqlite3_exec(database, sql, nil, nil, nil) == SQLITE_OK){
        return YES;
    }
    return NO;
    
}

@end
