//
//  WeatherViewController.swift
//  20230920-AbhishekRai-Chase
//
//  Created by Abhishek Rai on 20/09/23.
//

import UIKit
import CoreLocation
import SwiftUI

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var cityTextField: UITextField!
    var viewModel = WeatherViewModel(webservice: Webservice())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Today's Weather"
        viewModel.reloadUI = { [weak self] in
            self?.reloadData()
        }
        setupLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let location = viewModel.lastCitySearched() {
            fetchDetailBy(location: location)
        }
    }
    
    private func setupLocation() {
        viewModel.locationUpdated = { [weak self] location in
            let geoLocation = GeoLocation(name: nil, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self?.fetchDetailBy(location: geoLocation)
        }
    }
    
    private func setLastCityName() {
        cityTextField.text = viewModel.getCityName()
    }
    
    private func clearTextField() {
        cityTextField.text = ""
        viewModel.clearTextfield()
    }
    
    private func fetchDetailBy(cityName: String) {
        Task.init(operation: {
             await viewModel.fetchWeatherDetails(city: cityName)
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        })
    }
    
    private func reloadData() {
        setLastCityName()
        weatherTableView.reloadData()
    }
    
    private func fetchDetailBy(location: GeoLocation) {
        cityTextField.resignFirstResponder()
        Task.init(operation: {
             await viewModel.fetchWeatherDetails(geoLocation: location)
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        })
    }
    
    @IBAction func moreDetails(_ sender: Any) {
        let geoLocation = GeoLocation(name: viewModel.getCityName(), lat: viewModel.weatherInfo?.coord?.lat, lon: viewModel.weatherInfo?.coord?.lon)
        let moreInformation = UIHostingController(rootView: LocationDetails(location: geoLocation))
        navigationController?.pushViewController(moreInformation, animated: true)
    }
    
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowModel = viewModel.getRowModel(atIndex: indexPath.row) else { return UITableViewCell() }
        switch rowModel.type {
        case .basicDetails:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherDetailCell.reuseIdentifier, for: indexPath) as? CityWeatherDetailCell else { return UITableViewCell() }
            cell.configureCell(rowModel: rowModel)
            return cell
        case .airPressureDetails:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AirPressureCell.reuseIdentifier, for: indexPath) as? AirPressureCell else { return UITableViewCell() }
            cell.configureCell(rowModel: rowModel)
            return cell
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let cityName = textField.text else { return true}
        fetchDetailBy(cityName: cityName)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        clearTextField()
        return true
    }
}
