//
//  EmojiTableViewController.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-07-27.
//

import UIKit
import CoreData

class EmojiTableViewController: UITableViewController {
    
//    var emojiList:[Emoji] = [Emoji]()
    var list:[Emoji] = [Emoji] ()
    var managedContext: NSManagedObjectContext!
    var newEmojiList:[EmojiModel] = []
    //var selectedIndex:Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        managedContext.refreshAllObjects()
        fetchData()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        Task {
            do {
                let API_Response = try await EmojiAPI_Helper.fetchEmojis()
//                emojiList = API_Response
                list = API_Response
                
                fetchData()
                
                if(newEmojiList.count <= 0){
                    addDataToCoreData()
                }
                tableView.reloadData()
                //print(emojiList)
            }
            catch {
                preconditionFailure("Error Occured \(error)")
            }
        }
    }
    
    func fetchData() {
        let fetchReq: NSFetchRequest<EmojiModel> = EmojiModel.fetchRequest()
        do{
            newEmojiList = try managedContext.fetch(fetchReq)
            print(newEmojiList.count)
        } catch {
            print("Error while checking data exist or not.")
        }
    }
    
    func addDataToCoreData() {
            for emoji in list{
                let newItem = NSEntityDescription.insertNewObject(forEntityName: "EmojiModel", into: managedContext) as! EmojiModel
                newItem.category = emoji.category
                newItem.group = emoji.group
                newItem.htmlCode = emoji.htmlCode.first
                newItem.isFav = emoji.isFav ?? false
                newItem.unicode = emoji.unicode.first
                newItem.name = emoji.name
                
                // Retrieve the highest existing ID
                let request: NSFetchRequest<EmojiModel> = EmojiModel.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
                request.fetchLimit = 1
                
                do {
                    if let lastItem = try managedContext.fetch(request).first {
                        // Increment the highest existing ID
                        newItem.id = (lastItem.id) + 1
                    } else {
                        // No existing items, start with ID of 1
                        newItem.id = 0
                    }

                    // Save the managed object context to persist the changes
                    try managedContext.save()

                } catch {
                    print("Error inserting new data item: \(error)")
                }
            }

        fetchData()
        print(newEmojiList.count)
    }
    
    // Function to save Core Data changes
        func saveCoreDataChanges() {
            do {
                try managedContext.save()
            } catch {
                print("Error saving Core Data changes: \(error)")
            }
        }

    // MARK: - Table view data source
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return emojiList.count
        return newEmojiList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojicell", for: indexPath) as! MyEmojiCell
        //selectedIndex = indexPath.row
        // Configure the cell...
        tableView.rowHeight = 70
        //String to Unicode
//        if let unicode = emojiList[indexPath.row].unicode.first! as String? {
        if let unicode = newEmojiList[indexPath.row].unicode as String? {
            if let int = Int(unicode.replacingOccurrences(of: "U+", with: ""), radix: 16) {
                if let scalar = UnicodeScalar(int) {
                   // cell.textLabel!.text = String(scalar)
                    cell.uEmoji.text = String(scalar)
                }
            }
        }
//        cell.Name.text = emojiList[indexPath.row].name
        cell.Name.text = newEmojiList[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dst = segue.destination as! EmojiDataViewController
//        dst.newEmojiList = newEmojiList
        dst.selectedEmojiIndex = tableView.indexPathForSelectedRow?.row

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
