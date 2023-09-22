//
//  AirPressureCell.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import UIKit

class AirPressureCell: UITableViewCell, WeatherDetailProtocol {
    
    @IBOutlet weak var windflowLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    
    func configureCell(rowModel: WeatherAppRowProtocol?) {
        guard let model = rowModel as? AirPressureRowModel  else { return }
        windflowLabel?.text = model.humidity
        highTemperatureLabel?.text = model.highTemp
        lowTemperatureLabel?.text = model.lowTemp
    }
}
