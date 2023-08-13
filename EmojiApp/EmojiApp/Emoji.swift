//
//  Emoji.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-07-27.
//

import Foundation

struct Emoji: Codable {
    var name:String
    var category:String
    var group:String
    var htmlCode:[String]
    var unicode:[String]
    var isFav:Bool?
    //var message:String
    
    
    init() {
        self.name = ""
        self.category = ""
        self.group = ""
        self.htmlCode = []
        self.unicode = []
        self.isFav = false
       // self.message = ""
    }
}
