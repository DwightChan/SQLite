//
//  CDH_SQLiteManager.swift
//  SQLite
//
//  Created by chendehao on 16/8/6.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_SQLiteManager: NSObject {
    // 工具类一般都设计为单例对象
    static let shareInstance : CDH_SQLiteManager = CDH_SQLiteManager()
    
    // MARK : - 定义数据对象
    var db : COpaquePointer = nil
}

// MARK : - 打开数据库的操作
extension CDH_SQLiteManager{
    func openDB(dbPath : String) -> Bool {
        // 2. 将该语句进行执行
        // 1> 参数一: 数据库对象
        // 2> 参数二: 要执行的SQL语句 createTableSQL转化为 C语言的字符串
        let cDBPath = dbPath.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        return sqlite3_open(cDBPath, &db) == SQLITE_OK
    }
}

// MARK : - 执行 SQLiteManager 的操作
extension CDH_SQLiteManager {
    func execSQL(sqlString : String) -> Bool {

        // 1.将 SQLString 转成 C语言字符串
        let cSQLString = sqlString.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        // 2.执行 SQL 语句
        return sqlite3_exec(db, cSQLString, nil, nil, nil) == SQLITE_OK
    }
}

// MARK : - 事务相关的操作
extension CDH_SQLiteManager {
    func beginTansation() -> Void {
        
        // 1.开启事务的语句
        let beginTransaction  = "BEGIN TRANSACTION;"
        
        // 2.执行
        execSQL(beginTransaction)
    }
    
    func commitTransation() -> Void {
        //1.提交事务的语句
        let commitTransation = "COMMIT TRANSACTION;"
        
        //2.执行
        execSQL(commitTransation)
    }
    
    func rollbackTransation() -> Void {
        // 1.回滚事务语句
        let rollbackTransation = "ROLLBACK TRANSACTION;"
        
        // 2.执行
        execSQL(rollbackTransation)
    }
}

// MARK : - 查询数据操作
extension CDH_SQLiteManager {
    func queryData(querySQLString : String) -> [[String : NSObject]] {
        
        // 1.将 querySQLString 转成 C 语言字字符串
        let cQuerySQLString = querySQLString.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        // 1.定义游标(指针)
        var stmt : COpaquePointer = nil
        
        
        // 2.准备查询, 并给游标赋值
        /**
         *  2.准备查询, 并给游标赋值
         *
         *  @param COpaquePointer##COpaquePointer#>                                                       数据库对象 description#>
         *  @param UnsafePointer<Int8>##UnsafePointer<Int8>#>                                             查询 SQL 语句 description#>
         *  @param Int32##Int32#>                                                                         SQL语句的长度. -1表示自动计算长度 description#>
         *  @param UnsafeMutablePointer<COpaquePointer>##UnsafeMutablePointer<COpaquePointer>#>           游标(指针)-->获取到数据库中的游标 description#>
         *  @param UnsafeMutablePointer<UnsafePointer<Int8>>##UnsafeMutablePointer<UnsafePointer<Int8>>#> description#>
         *
         *  @return
         */
        sqlite3_prepare_v2(db, cQuerySQLString, -1, &stmt, nil)
        
        // 3.开始查询数据
        // 3.1取出列数
        let count = sqlite3_column_count(stmt)
        
        // 3.2定义数组
        var tempArray = [[String : NSObject]]()
        
        // 3.3查询数据
        while sqlite3_step(stmt) == SQLITE_ROW {
            
            // 遍历所有的键值对
            var dict = [String : NSObject]()
            for i in 0..<count {
                // 查询到 C 语言的字符
                let cKey = sqlite3_column_name(stmt, i)
                let cValue = UnsafePointer<Int8>(sqlite3_column_text(stmt, i))
                
                // 转为 oc 字符
                let key = String(CString: cKey, encoding: NSUTF8StringEncoding)!
                let value = String(CString: cValue, encoding : NSUTF8StringEncoding)!
                
                dict[key] = value
            }
            
            // 将字典放入到数组中
            tempArray.append(dict)
        }

        return tempArray
    }
}









