//
//  FavouriteTableViewController.swift
//  EmojiApp
//
//  Created by Foram Patel on 2023-08-12.
//

import UIKit
import CoreData

class FavouriteTableViewController: UITableViewController, MyTableViewCellDelegate {

    var mainList:[EmojiModel] = []
    var managedContext: NSManagedObjectContext!
    var newEmojiList:[EmojiModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        Task {
            do {
                fetchData()
                tableView.reloadData()
            }
        }
    }
    
    
    func fetchData() {
        let fetchReq: NSFetchRequest<EmojiModel> = EmojiModel.fetchRequest()
        do{
            mainList = try managedContext.fetch(fetchReq)
            newEmojiList = mainList.filter{$0.isFav}
            print(newEmojiList.count)
        } catch {
            print("Error while checking data exist or not.")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newEmojiList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojicell", for: indexPath) as! MyEmojiCell
        tableView.rowHeight = 70
        if let unicode = newEmojiList[indexPath.row].unicode as String? {
            if let int = Int(unicode.replacingOccurrences(of: "U+", with: ""), radix: 16) {
                if let scalar = UnicodeScalar(int) {
                    cell.favEmoji.text = String(scalar)
                }
            }
        }
        cell.favName.text = newEmojiList[indexPath.row].name
        cell.favSwitch.isOn = newEmojiList[indexPath.row].isFav
        return cell
    }
    
    func switchValueChanged(cell: MyEmojiCell, isOn: Bool){
        
        if let indexPath = tableView.indexPath(for: cell){
            let id = newEmojiList[indexPath.row].id
            mainList[id].isFav = isOn
            
            do{
//                try managedContext.save()
                managedContext.refresh(mainList[id], mergeChanges: true)
                print("switch state saved successfully.")
            } catch{
                print("Error while saving the updated value...")
            }
        }
    }
    
    

}
