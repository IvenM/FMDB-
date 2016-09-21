//
//  FMDBEncapsulation.m
//  FMDB封装
//
//  Created by Iven on 16/9/20.
//  Copyright © 2016年 Iven. All rights reserved.
//

#import "FMDBEncapsulation.h"
#import "FMDB.h"

@implementation FMDBEncapsulation{

    FMDatabase *_db;
}

//初始化数据库文件，然后打开数据库文件
-(id)initWithFilePath:(NSString*)filePath{

    if ([super init]) {
        _db = [FMDatabase databaseWithPath:filePath];
        
        BOOL isOpen = [_db open];
        if (!isOpen) {
            NSLog(@"打开失败");
        }
    }

    return self;
}

//创建表格
-(void)createTableWithCreateSQL:(NSString*)SQL{

//    例子
//    NSString *createSQL = @" CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL); ";

    BOOL isCreateTable = [_db executeQuery:SQL];
    
    if (isCreateTable) {
        NSLog(@"创建表格成功");
    }

}

//添加数据
-(void)insertSucWithSQL:(NSString*)SQL withValue:(NSString*)name{

    BOOL insertSuc = [_db executeUpdateWithFormat:SQL,name];
    
    // ！！！不好使
    //        BOOL insertSuc = [db executeUpdate:@" insert into t_student(name, age) values (?,?); ",name,20];
    //例子
//    BOOL insertSuc = [db executeUpdateWithFormat:@"insert into t_student(name, age) values (%@,%d)",name,20];
    if(insertSuc){
        NSLog(@"数据插入成功");
    }
}

//删除数据
-(void)deleteSucWithSQL:(NSString*)SQL{

    BOOL deleteSuc = [_db executeUpdate:SQL];
    // 例子
//    BOOL deleteSuc = [db executeUpdate:@" delete from t_student where id > 10; "];
    
    if (deleteSuc) {
        NSLog(@"删除成功");
    }

}

//刷新数据
-(void)updataSucWithSQL:(NSString*)SQL{

    BOOL updateSuc = [_db executeUpdate:SQL];
//    例子
//    BOOL updataSuc = [db executeUpdate:@" update t_student set name = \"二娘\" where id < 10; "];
    
    if (updateSuc) {
        NSLog(@"数据刷新成功");
    }
}

//数据查询
-(void)resultSet:(NSString*)SQL{

    FMResultSet *set = [_db executeQuery:SQL];
    //例：
    //    FMResultSet *set = [db executeQuery:@" select * from t_student; "];

    
    while ([set next]) {
        
        NSString *name = [set stringForColumn:@"name"];
        int age = [set intForColumn:@"age"];
        
        NSLog(@"%@   %d",name, age);

    }
    
}

//关闭数据库文件
-(void)closeFMDB{
    [_db close];
}

@end
