//
//  ViewController.swift
//  SQLite
//
//  Created by chendehao on 16/8/6.
//  Copyright © 2016年 CDHao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // COpaquePointer 就是个指针
    var db : COpaquePointer = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.打开数据库方法
        // 1> 参数一: 文件路径
        // 2> 参数二: 数据库对象
        let filePath = "/Users/chendehao/Desktop/mydb.sqlite"
        
        if CDH_SQLiteManager.shareInstance.openDB(filePath) {
            print("ok")
        }else{
            print("on")
        }
    
    }
}

// MARK : - DDL语句操作
extension ViewController{
    
    /// 创建表格
    @IBAction func createTableSQL(sender: AnyObject) {
        
        // 1. 获取创建表的语句
        let createTableSQL = "CREATE TABLE IF NOT EXISTS  t_student (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, height REAL);"
        // 注意区别在 Navicat 软件上的写法 CREATE TABLE IF NOT EXISTS  't_student' ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "name" TEXT, "age" INTEGER, "height" REAL);
        
        // 2. 将该语句进行执行
        if CDH_SQLiteManager.shareInstance.execSQL(createTableSQL) {
            print("创建成功")
        }else {
            print("创建失败")
        }
        
    }
    /// 删除表格
    @IBAction func dropTableSQL(sender: AnyObject) {
        // 1.获取删除表格的语句
        let dropTableSQL = "DROP TABLE IF  EXISTS t_student;"
        // 注意: 这个字符在如果在Navicat 软件的写法是不一样的 DROP TABLE IF  EXISTS 't_student';
        
        // 2. 执行 SQL 语句
        if CDH_SQLiteManager.shareInstance.execSQL(dropTableSQL){
            print("删除成功")
        }else{
            print("删除失败")
        }
    }
}

// MARK : - DML语句操作
extension ViewController {
    
}

/**
 
 -- 创建新的表格
 CREATE TABLE IF NOT EXISTS  't_teacher' ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "name" TEXT, "age" INTEGER, "height" REAL);
 
 -- 删除表格
 DROP TABLE IF  EXISTS 't_student';
 
 -- 创建新的表格
 CREATE TABLE IF NOT EXISTS  't_student' ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "name" TEXT, "age" INTEGER, "height" REAL);
 
 -- 出入数据
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 18, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 19, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 20, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 21, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 18, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 19, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 20, 1.88);
 INSERT INTO 't_student' (name ,age, height) VALUES ('cdh', 21, 1.88);
 
 -- 删除数据
 DELETE FROM t_student;
 
 -- 更新数据
 UPDATE t_student
	SET name = 'Aarak' WHERE age = 18 ;
 
 UPDATE t_student
	SET name = 'CDH' WHERE age = 21;
 
 DELETE FROM t_student
	WHERE age = 18 ;
 */




