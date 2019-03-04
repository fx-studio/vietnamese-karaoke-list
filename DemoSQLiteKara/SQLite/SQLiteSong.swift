//
//  SQLiteSong.swift
//  DemoSQLiteKara
//
//  Created by Tien Le P. on 2/26/19.
//  Copyright © 2019 Tien Le P. All rights reserved.
//

import Foundation

extension SQLite.Song {
    struct SongResult {
        var songs: [Song]
    }
    
    struct SQLString {
        let table = "Song"
        
        func listSong(index: Int = 0, limit: Int = 100) -> String {
            return "SELECT * FROM \(table) limit \(index), \(limit)"
        }
    }
    
    static func query(index: Int, limit: Int, completion:SQLCompletion<SongResult>) {
        let sqlStr = SQLString().listSong(index: index, limit: limit)
        SQLiteDataManager.shared.query(sqlString: sqlStr) { (result) in
            switch (result) {
            case .success(let rs):
                var songs: [Song] = []
                while rs.next() {
                    let song = Song(results: rs)
                    songs.append(song)
                }
                completion(.success(SongResult(songs: songs)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
