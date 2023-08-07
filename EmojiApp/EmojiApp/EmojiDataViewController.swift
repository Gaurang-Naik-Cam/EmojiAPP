//
//  EmojiDataViewController.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-08-07.
//

import UIKit

class EmojiDataViewController: UIViewController {
    
    var emojiList:[Emoji] = [Emoji]()
    var selectedEmojiIndex:Int!
    
    @IBOutlet weak var EmojiName :UILabel!
    @IBOutlet weak var uEmoji :UILabel!
    @IBOutlet weak var EmojiCategory :UILabel!
    @IBOutlet weak var EmojiGroup :UILabel!
    @IBOutlet weak var EmojiHTMLCode :UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(emojiList[selectedEmojiIndex].name)
        print(selectedEmojiIndex!)
        
        if(selectedEmojiIndex > 0){
            
            EmojiName.text! = emojiList[selectedEmojiIndex].name
            //uEmoji.text! = emojiList[selectedEmojiIndex].unicode.first!
            EmojiCategory.text! = emojiList[selectedEmojiIndex].category
            EmojiGroup.text! = emojiList[selectedEmojiIndex].group
            EmojiHTMLCode.text! = emojiList[selectedEmojiIndex].htmlCode.first!
            
            //String to Unicode
            if let unicode = emojiList[selectedEmojiIndex].unicode.first! as String? {
                if let int = Int(unicode.replacingOccurrences(of: "U+", with: ""), radix: 16) {
                    if let scalar = UnicodeScalar(int) {
                        // cell.textLabel!.text = String(scalar)
                        uEmoji.text! = String(scalar)
                    }
                }
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
