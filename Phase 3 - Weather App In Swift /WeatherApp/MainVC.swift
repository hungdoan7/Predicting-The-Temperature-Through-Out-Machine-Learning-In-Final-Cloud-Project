//
//  ViewController.swift
//  WeatherApp
//
//  Created by Hung Doan on 7/5/20.
//  Copyright © 2020 Hung Doan. All rights reserved.
//

import UIKit

class MainVC: UIViewController {


    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { timer in
            self.UpdateTemperature()
        }
    }

    
    func UpdateTemperature() {
        let urlObj = URL(string:"http://ec2-52-15-234-97.us-east-2.compute.amazonaws.com:8090/")!
        var temps:CurrentTemperatureModel?
        let session = URLSession.shared
        let task = session.dataTask(with: urlObj)
        {
            (data,response,error)  in
            do {
                temps = try JSONDecoder().decode(CurrentTemperatureModel.self, from: data!)
                DispatchQueue.main.async {
                    self.temperatureLabel.text = String(temps!.Current_Temperature)
                }
            }
            catch
            {
                print("error");
            }
        }
        task.resume()
    }
}

