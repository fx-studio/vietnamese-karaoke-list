//
//  Song.swift
//  DemoSQLiteKara
//
//  Created by Tien Le P. on 2/26/19.
//  Copyright © 2019 Tien Le P. All rights reserved.
//

import Foundation
import FMDB

class Song {
    var id: String
    var code: String
    var title: String
    var titleSimple: String
    var titleShort: String
    var lyric: String
    var lyricSimple: String
    
    var brandId = 0
    var brandText = ""
    var vol = 0
    var lang = ""
    
    var author = ""
    var authorSimple = ""
    var artist = ""
    var artistSimple = ""
    
    init(results: FMResultSet) {
        id = results.string(forColumn: "id") ?? ""
        code = results.string(forColumn: "code") ?? ""
        title = results.string(forColumn: "title") ?? ""
        titleSimple = results.string(forColumn: "title_simple") ?? ""
        titleShort = results.string(forColumn: "title_short") ?? ""
        lyric = results.string(forColumn: "lyric") ?? ""
        lyricSimple = results.string(forColumn: "lyric_simple") ?? ""
        
        brandId = Int(results.int(forColumn: "brand_id"))
        brandText = results.string(forColumn: "brand_text") ?? ""
        vol = Int(results.int(forColumn: "vol"))
        lang = results.string(forColumn: "lang") ?? ""
        
        author = results.string(forColumn: "author") ?? ""
        authorSimple = results.string(forColumn: "author_simple") ?? ""
        artist = results.string(forColumn: "artist") ?? ""
        artistSimple = results.string(forColumn: "artist_simple") ?? ""
    }
}
