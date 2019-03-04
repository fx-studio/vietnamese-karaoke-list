# Vietnamese Karaoke List
Demo Vietnamese Karaoke List, SQLite, FMDB

- Versions : 1.0.0
- iOS 11+
- Xcode 10.1
- Swift 4.2
- Database : SQLite
- Framework:
  - FMDB v2.7 https://github.com/ccgus/fmdb

### SQL Query

```sql lite
SELECT * FROM song limit 0, 100
```

### Swift code

* Edit query string `SQLiteSong.swift`

```swift
struct SQLString {
        let table = "Song"
        
        func listSong(index: Int = 0, limit: Int = 100) -> String {
            return "SELECT * FROM \(table) limit \(index), \(limit)"
        }
    }
```

* Open DataBase `SQLiteManager.swift`

```swift
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
```

* Query data `SQLiteSong.swift`

```swift
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
```



### Screenshoot:

![Screenshoot](/images/1.png)



