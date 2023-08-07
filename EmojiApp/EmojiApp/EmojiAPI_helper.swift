//
//  EmojiAPI_helper.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-07-27.
//

import Foundation
import UIKit

enum EmojiAPI_Errors: Error {

        case cannotConvertURL
}


class EmojiAPI_Helper {
    
    private static var baseURLString =  "https://emojihub.yurace.pro/api/all"
    //private static var baseURLStringData =  "https://dog.ceo/api/breeds/image/random"
    
    public static func fetch(urlString:String) async throws -> Data {
        
        guard
            let url = URL(string: urlString)
        else { throw EmojiAPI_Errors.cannotConvertURL }
        
        let (data,_) = try await URLSession.shared.data(from:url)
       //print(data.first)
        return data
    }
    
    public static func fetchEmojis() async throws -> [Emoji] {
        
        do
        {
            let data = try await fetch(urlString: baseURLString)
            print(data);
            let decoder = JSONDecoder()
            
           // let emoji = Emoji()
            let emojis = try decoder.decode([Emoji].self, from: data)
           // let emoji.category = try decoder.decode(Emoji.self, from: data)
            
            return emojis
            
        } catch {
            
                fatalError("\(error)")
        }
    }
    
}

