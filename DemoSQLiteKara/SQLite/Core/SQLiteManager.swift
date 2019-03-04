//
//  SQLiteManager.swift
//  DemoSQLiteKara
//
//  Created by Tien Le P. on 2/26/19.
//  Copyright © 2019 Tien Le P. All rights reserved.
//

import Foundation
import FMDB

class SQLiteDataManager {
    // MARK: - Properties
    
    static var shared: SQLiteDataManager = {
        let shared = SQLiteDataManager()
        // Configuration
        shared.databasePath = SQLiteDataManager.getDBPath(fileName: SQLConfig.dbName)
        return shared
    }()
    
    var databasePath: String?
    
    // Initialization
    private init() {}
    
    //MARK: Private functions
    static private func getDBPath(fileName: String) -> String? {
        if let filePath = Bundle.main.url(forResource: fileName, withExtension: SQLConfig.dbType) {
            return filePath.absoluteString
        } else {
            return nil
        }
    }
    
    //MARK: public functions
    func query(sqlString: String, completion: SQLCompletion<FMResultSet>) {
        //open DB
        let database = FMDatabase(path: databasePath)
        
        guard database.open() else {
            let error = SQLError(code: 1, description: "Unable to open database", kind: .canNotOpenDB)
            completion(.failure(error))
            return
        }
        
        do {
            let results = try database.executeQuery(sqlString, values: nil)
            completion(.success(results))
        } catch {
            let error = SQLError(code: 1, description: error.localizedDescription, kind: .executeQuery)
            completion(.failure(error))
        }
        
        database.close()
    }
}
