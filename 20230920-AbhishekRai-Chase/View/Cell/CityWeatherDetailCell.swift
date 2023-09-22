//
//  CityWeatherDetailCell.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import UIKit

protocol WeatherDetailProtocol {
    func configureCell(rowModel: WeatherAppRowProtocol?)
}

class CityWeatherDetailCell: UITableViewCell, WeatherDetailProtocol {
    
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    func configureCell(rowModel: WeatherAppRowProtocol?) {
        guard let model = rowModel as? BasicRowModel  else { return }
        cityNameLabel?.text = model.cityName
        tempratureLabel?.text = model.temperature
        if let url = model.url {
            ImageCache.shared.getImage(for: url) { [weak self] image in
                DispatchQueue.main.async {
                    if let image = image {
                        self?.cloudImageView.image = image
                    } else {
                        /**
                         Set placeholder image in the case failure.
                         Simple image cache has been implemented as per the usecase.
                         Third party library like Kingfisher, SDWebCache can used for additional capabalities.
                         */
                    }
                }
            }
        }
    }
}
