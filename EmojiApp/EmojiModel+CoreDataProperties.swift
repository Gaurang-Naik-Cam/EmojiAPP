//
//  EmojiModel+CoreDataProperties.swift
//  EmojiApp
//
//  Created by Foram Patel on 2023-08-12.
//
//

import Foundation
import CoreData


extension EmojiModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmojiModel> {
        return NSFetchRequest<EmojiModel>(entityName: "EmojiModel")
    }

    @NSManaged public var category: String?
    @NSManaged public var group: String?
    @NSManaged public var htmlCode: String?
    @NSManaged public var isFav: Bool
    @NSManaged public var name: String?
    @NSManaged public var unicode: String?
    @NSManaged public var id: Int
    
    @objc public class func createEmojiModel(in context: NSManagedObjectContext) -> EmojiModel {
        let emojiModel = EmojiModel(context: context)
        // Additional setup if needed
        return emojiModel
    }

}

extension EmojiModel : Identifiable {

}
