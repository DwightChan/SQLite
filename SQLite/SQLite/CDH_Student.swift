//
//  CDH_Student.swift
//  SQLite
//
//  Created by chendehao on 16/8/6.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class CDH_Student: NSObject {
    
    var name : String = ""
    var age : Int = 0
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
}

extension CDH_Student {
    func insertIntoDB() -> Void {
        
        // 1. 拼接插入语句
        let inserSQL = "INSERT INTO t_student (name, age) VALUES ('\(name)','\(age)');"
        
        // 2. 执行 sql 语句
        CDH_SQLiteManager.shareInstance.execSQL(inserSQL)
    }
}