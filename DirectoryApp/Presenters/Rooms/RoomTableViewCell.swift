//
//  RoomTableViewCell.swift
//  DirectoryApp
//
//  Created by Przemek on 24/10/2022.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var maxOccupancyLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var occupiedSwitch: UISwitch!

    func setupCell(with data: Room) {
        idLbl.text = data.roomId
        maxOccupancyLbl.text = "Max Occupancy: " + String(data.maxOccupancy)
        createdAtLbl.text = "Created At: " + data.createdAt.toDateFormat()
        occupiedSwitch.isOn = data.isOccupied
    }
    
}
