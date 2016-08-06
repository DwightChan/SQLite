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