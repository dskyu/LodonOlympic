//
//  DB.h
//  exploreolympic
//
//  Created by bunny on 12-4-11.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "define.h"

@interface DB: NSObject {
    sqlite3 *database;
}
    
-(void)createDatabaseIfNeeded:(NSString *)filename;
-(void)openDB;
-(void)closeDB;
-(NSArray *) fetchQuery:(NSString *) query;
-(NSDictionary *) fetchMutliQuery:(NSString *) query;
-(BOOL) execQuery:(NSString *) query;
@end
