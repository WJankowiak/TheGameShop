//
//  DatabaseManager.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 02/12/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import Foundation
import SQLite3

class DatabaseManager {
    
    init (){
        
    }
    
    static func createAndPopulate(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Games (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(16),description VARCHAR(255),  imageName TEXT, price FLOAT, platform TEXT, type TEXT, isInBasket Int, latitude FLOAT, longitude FLOAT, isFavourite INT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print ("error creating table: \(errmsg)")
        }
        for game in gameModelData().gamesData {
            let queryString = "INSERT INTO Games (name, description, imageName, price, platform, type, isInBasket,latitude, longitude, isFavourite) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing insert: \(errmsg)" )
                return
            }
            prepareStatement(db: db, stmt: stmt, num: 1, arg: game.name)
            prepareStatement(db: db, stmt: stmt, num: 2, arg: game.description)
            prepareStatement(db: db, stmt: stmt, num: 3, arg: game.imageName)
            prepareStatement(db: db, stmt: stmt, num: 5, arg: game.platform)
            prepareStatement(db: db, stmt: stmt, num: 6, arg: game.type)
            if sqlite3_bind_double(stmt, 4, Double(game.price)) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing price: \(errmsg)" )
                return
            }
            if sqlite3_bind_double(stmt, 8, Double(game.latitude)) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing lat: \(errmsg)" )
                return
            }
            if sqlite3_bind_double(stmt, 9, Double(game.longitude)) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing long: \(errmsg)" )
                return
            }
            if sqlite3_bind_int(stmt, 7, game.isInBasket ? 1 : 0) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing bask: \(errmsg)" )
                return
            }
            if sqlite3_bind_int(stmt, 10, game.isFavourite ? 1 : 0) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing fav: \(errmsg)" )
                return
            }
            
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("Error executing insert: \(errmsg)")
            }
        }
    }
    static private func prepareStatement(db: OpaquePointer?, stmt: OpaquePointer?, num: Int32, arg: String) {
        let finalArg = arg as NSString
        if sqlite3_bind_text(stmt, num, finalArg.utf8String, -1, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("error preparing argument nr \(num) : \(errmsg)" )
            return
        }
    }
    static func getAllGames() -> [Game] {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
        var games = [Game()]
        
        let selectAllQuery = "Select * FROM Games"
        var stmt: OpaquePointer?
        if(sqlite3_prepare(db, selectAllQuery, -1, &stmt, nil)) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("Error executing select all: \(errmsg)")
            return []
        }
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let name = String(cString:sqlite3_column_text(stmt, 1))
            let description = String(cString:sqlite3_column_text(stmt, 2))
            let imageName = String(cString:sqlite3_column_text(stmt, 3))
            let price = Float(sqlite3_column_double(stmt, 4))
            let platform = String(cString:sqlite3_column_text(stmt, 5))
            let type = String(cString:sqlite3_column_text(stmt, 6))
            let bask = sqlite3_column_int(stmt, 7) == 1 ? true : false
            let latitude = sqlite3_column_double(stmt, 8)
            let longitude = sqlite3_column_double(stmt, 9)
            let fav = sqlite3_column_int(stmt, 10) == 1 ? true : false
            if(price != 0){
                games.append(Game(name_: name, description_: description, imageName_: imageName, price_: price, platform_: platform, type_: type, isInBasket_: bask,latitude_: Float32(latitude), longitude_: Float32(longitude),isFavourite_: fav))
            }
        }
        
        for g in games {
            if g.name == "" {
                let index = games.index{$0 === g}
                games.remove(at: index!)
            }
        }
        print ("returning all games in count: \(games.count)")
        return games
    }
    static func DeleteGames() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
        let DropQuery = "DROP TABLE IF EXISTS Games"
        var stmt: OpaquePointer?
        if sqlite3_prepare(db, DropQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("error preparing insert: \(errmsg)" )
            return
        }
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("Error executing insert: \(errmsg)")
        }
    }
    static func getBasketGames() -> [Game] {
        var games = getAllGames()
        for g in games {
            if g.isInBasket == false {
                let index = games.index{$0 === g}
                games.remove(at: index!)
            }
        }
        return games
    }
    
    static func getFavGames() -> [Game] {
        var games = getAllGames()
        for g in games {
            if g.isFavourite == false {
                let index = games.index{$0 === g}
                games.remove(at: index!)
            }
        }
        return games
    }
    static func removeFromBasket (game: Game) {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
            let queryString = "UPDATE Games SET isInBasket = 0 WHERE name = \"\(game.name)\""
            print(queryString)
            var stmt: OpaquePointer?

            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("error preparing remove from basket: \(errmsg)" )
                return
            }
            
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String (cString: sqlite3_errmsg(db))
                print ("Error executing remove from basket: \(errmsg)")
            }
            print ("REMOVED SUCCESFULLY")
        }
    static func addToBasket (game: Game) {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
        let queryString = "UPDATE Games SET isInBasket = 1 WHERE name = \"\(game.name)\""
        print(queryString)
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("error preparing remove from basket: \(errmsg)" )
            return
        }
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("Error executing remove from basket: \(errmsg)")
        }
        print ("ADDED SUCCESFULLY")
    }
    
    static func addToFav (game: Game) {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
        let queryString = "UPDATE Games SET isFavourite = 1 WHERE name = \"\(game.name)\""
        print(queryString)
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("error preparing addToFav: \(errmsg)" )
            return
        }
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("Error executing addToFav: \(errmsg)")
        }
        print ("ADDED SUCCESFULLY")
    }
    
    static func removeFromFav (game: Game) {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("GamesDatabase.sqlite")
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print ("Error opening database")
        }
        let queryString = "UPDATE Games SET isFavourite = 0 WHERE name = \"\(game.name)\""
        print(queryString)
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("error preparing remove from Fav: \(errmsg)" )
            return
        }
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String (cString: sqlite3_errmsg(db))
            print ("Error executing remove from fav: \(errmsg)")
        }
        print ("REMOVED SUCCESFULLY")
    }
}
