//
//  Extensions.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension String {
    var withDegreeSymbol: String {
        return "\(self)°c"
    }
}


