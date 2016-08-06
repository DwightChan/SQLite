//
//  CDH_SQLiteManager.swift
//  SQLite
//
//  Created by chendehao on 16/8/6.
//  Copyright © 2016年 CDHao. All rights reserved.
//  使用 FMDB 封装的 SQLite 数据库的方法

import UIKit
import FMDB

class CDH_SQLiteManager: NSObject {
    // 工具类一般都设计为单例对象
    static let shareInstance : CDH_SQLiteManager = CDH_SQLiteManager()
    
    // MARK : - 定义数据对象
    var db : FMDatabase!
}

// MARK : - 打开数据库的操作
extension CDH_SQLiteManager{
    func openDB(dbPath : String) -> Bool {
        db = FMDatabase(path: dbPath)
        
        return db.open()
    }
}

// MARK : - 执行 SQLiteManager 的操作
extension CDH_SQLiteManager {
    func execSQL(sqlString : String) -> Bool {

        return db.executeUpdate(sqlString, withArgumentsInArray: nil)
    }
}

// MARK : - 事务相关的操作
extension CDH_SQLiteManager {
    func beginTansation() -> Void {
        
        db.beginTransaction()
    }
    
    func commitTransation() -> Void {
       db.commit()
    }
    
    func rollbackTransation() -> Void {
    
        db.rollback()
    }
}

// MARK : - 查询数据操作
extension CDH_SQLiteManager {
    func queryData(querySQLString : String) -> [[String : NSObject]] {
        
        // 1.执行查询语句
        // 这里看没有进行校验 , 最好加上校验,
        let resultSet = db.executeQuery(querySQLString, withArgumentsInArray: nil)

        // 2.开始查询数据
        let count = resultSet.columnCount()
        
        // 3.2定义数组
        var tempArray = [[String : NSObject]]()
        
        // 3.3查询数据
        while resultSet.next() {
            
            // 遍历所有的键值对
            var dict = [String : NSObject]()
            for i in 0..<count {
                
                // 转为 oc 字符
                let key = resultSet.columnNameForIndex(i)
                let value = resultSet.stringForColumnIndex(i)
                
                dict[key] = value
            }
            
            // 将字典放入到数组中
            tempArray.append(dict)
        }

        return tempArray
    }
}









