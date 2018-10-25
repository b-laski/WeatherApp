//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bartomiej Łaski on 14/10/2018.
//  Copyright © 2018 Bartomiej Łaski. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class ViewController: UITableViewController {
    var url: String = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22";
    var weather: WeatherModel?
    var cellID = "CELLID"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItem.Style.plain, target: self, action: #selector(openMap))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        fetchUI { (data) in
            let jsonDecoder = JSONDecoder()
            if(data != nil) {
                self.weather = try? jsonDecoder.decode(WeatherModel.self, from: data!)
                NSLog(String(bytes: data!, encoding: .utf8) ?? "", [])
                NSLog(self.weather.debugDescription, [])
                self.navigationItem.title = self.weather?.cityName
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchUI(complete: @escaping (Data?) -> ()){
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                complete(response.data)
            case .failure(let error):
                NSLog(error.localizedDescription, [])
                break
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        switch indexPath.item {
        case 0:
            cell.textLabel?.text = "Temperatura: \(weather?.Temp.description ?? "Brak wartości")"
        case 1:
            cell.textLabel?.text = "Ciśnienie: \(weather?.Pressure.description ?? "Brak wartości")"
        case 2:
            cell.textLabel?.text = "Temperatura minimalna: \(weather?.TempMin.description ?? "Brak wartości")"
        case 3:
            cell.textLabel?.text = "Temperatura maksymalna: \(weather?.TempMax.description ?? "Brak wartości")"
        default:
            cell.textLabel?.text = "Nienzana dana!"
        }
        
        return cell
    }
    
    @objc func openMap(){
        if(weather != nil) {
            let map = MapView()
            map.data = [-0.13, 51.51]
            self.navigationController?.pushViewController(map, animated: true)
        } else {
            self.navigationController?.pushViewController(MapView(), animated: true)
        }
    }
}

