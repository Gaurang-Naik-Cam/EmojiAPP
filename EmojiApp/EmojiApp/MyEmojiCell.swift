//
//  MyEmojiCell.swift
//  EmojiApp
//
//  Created by Gaurang Naik on 2023-08-07.
//

import UIKit

class MyEmojiCell: UITableViewCell {
    
    weak var delegate: MyTableViewCellDelegate?

    @IBAction func favSwitchHandler(_ sender: UISwitch) {
        delegate?.switchValueChanged(cell: self, isOn: sender.isOn)
    }
    @IBOutlet weak var favSwitch: UISwitch!
    @IBOutlet weak var favEmoji: UILabel!
    @IBOutlet weak var favName: UILabel!
    @IBOutlet weak var Name :UILabel!
    @IBOutlet weak var uEmoji :UILabel!

}

protocol MyTableViewCellDelegate: AnyObject {
    func switchValueChanged(cell: MyEmojiCell, isOn: Bool)
}
