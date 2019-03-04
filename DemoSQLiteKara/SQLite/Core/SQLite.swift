//
//  KaraokeDataManager.swift
//  DemoSQLiteKara
//
//  Created by Tien Le P. on 2/26/19.
//  Copyright © 2019 Tien Le P. All rights reserved.
//

import Foundation
import FMDB

// Define
enum SQLResult<T> {
    case success(T)
    case failure(SQLError)
}

struct SQLError: Error {
    enum ErrorKind {
        case none
        case canNotOpenDB
        case executeQuery
    }
    
    let code: Int
    let description: String
    let kind: ErrorKind
}

typealias SQLCompletion<T> = (SQLResult<T>) -> Void

struct SQLConfig {
    static let dbName = "karaokevn"
    static let dbType = "db"
}

//MARK: SQLite
class SQLite {
    //MARK: Tables in Data
    struct Song { }
}
