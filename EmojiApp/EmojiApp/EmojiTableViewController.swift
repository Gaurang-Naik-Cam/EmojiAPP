//
//  EmojiTableViewController.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-07-27.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojiList:[Emoji] = [Emoji]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        Task {
            do {
                let API_Response = try await EmojiAPI_Helper.fetchEmojis()
                emojiList = API_Response
                tableView.reloadData()
                print(emojiList)
            }
            catch {
                preconditionFailure("Error Occured \(error)")
            }
        }
    }

    // MARK: - Table view data source
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojiList.count
    }
    
  /*  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! EmojiCellView
        
        tableView.rowHeight = 70
     
        cell.Breed.text = Array(emojiList)[indexPath.row].key
        
        if(Array(emojiList)[indexPath.row].value.count > 0)
        {
            let subBreed:String =  Array(emojiList)[indexPath.row].value[0]
            cell.SubBreed.text =  subBreed
        }
        return cell
    }*/
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojicell", for: indexPath) as! MyEmojiCell

        // Configure the cell...
        tableView.rowHeight = 70
        //String to Unicode
        if let unicode = emojiList[indexPath.row].unicode.first! as String? {
            if let int = Int(unicode.replacingOccurrences(of: "U+", with: ""), radix: 16) {
                if let scalar = UnicodeScalar(int) {
                   // cell.textLabel!.text = String(scalar)
                    cell.uEmoji.text = String(scalar)
                    
                }
            }
        }
        
        
        cell.Name.text = emojiList[indexPath.row].name

        return cell
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
