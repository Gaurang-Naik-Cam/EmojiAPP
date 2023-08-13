//
//  EmojiDataViewController.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-08-07.
//

import UIKit
import CoreData

class EmojiDataViewController: UIViewController {
    
//    var emojiList:[Emoji] = [Emoji]()
    var selectedEmojiIndex:Int!
    
    var newEmojiList:[EmojiModel] = []

//        newEmojiList[selectedEmojiIndex].isFav = !(newEmojiList[selectedEmojiIndex].isFav )
    
    @IBAction func switchFav(_ sender: UISwitch) {
        newEmojiList[selectedEmojiIndex].isFav = !(newEmojiList[selectedEmojiIndex].isFav )
        saveCoreDataChanges()
    }
    @IBOutlet weak var switchFav: UISwitch!
    @IBOutlet weak var EmojiName :UILabel!
    @IBOutlet weak var uEmoji :UILabel!
    @IBOutlet weak var EmojiCategory :UILabel!
    @IBOutlet weak var EmojiGroup :UILabel!
    @IBOutlet weak var EmojiHTMLCode :UILabel!
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // print(emojiList[selectedEmojiIndex].name)
      //  print(selectedEmojiIndex!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        fetchEmojiListFromCoreData()
        
        if(selectedEmojiIndex != nil && selectedEmojiIndex >= 0){
            
            EmojiName.text! = newEmojiList[selectedEmojiIndex].name ?? ""
            //uEmoji.text! = emojiList[selectedEmojiIndex].unicode.first!
            EmojiCategory.text! = newEmojiList[selectedEmojiIndex].category ?? ""
            EmojiGroup.text! = newEmojiList[selectedEmojiIndex].group ?? ""
            EmojiHTMLCode.text! = newEmojiList[selectedEmojiIndex].htmlCode ?? ""
            
            //String to Unicode
//            if let unicode = emojiList[selectedEmojiIndex].unicode as String? {
            let unicode = newEmojiList[selectedEmojiIndex].unicode ?? ""
                if let int = Int(unicode.replacingOccurrences(of: "U+", with: ""), radix: 16) {
                    if let scalar = UnicodeScalar(int) {
                        // cell.textLabel!.text = String(scalar)
                        uEmoji.text! = String(scalar)
                    }
                }
//            }
            
//            switchFav.isOn = newEmojiList[selectedEmojiIndex].isFav
            switchFav.isOn = newEmojiList[selectedEmojiIndex].isFav
            
        }
        
    }
    
    
    func saveCoreDataChanges() {
        do {
            try managedContext.save()
            print("switch state saved successfully. ")
        } catch {
            print("Error saving Core Data changes: \(error)")
        }
    }
    
    
    func fetchEmojiListFromCoreData() {
        newEmojiList.removeAll()
        let fetchRequest: NSFetchRequest<EmojiModel> = EmojiModel.fetchRequest()
        do{
            let list = try managedContext.fetch(fetchRequest)
            newEmojiList = list
            print(newEmojiList.count)
        } catch {
            print("Error while fetching data.")
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
