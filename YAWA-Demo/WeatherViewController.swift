//
//  WeatherViewController.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

protocol WeatherDisplayLogic: class {
    func displayWeatherList(viewModel: Weather.LoadWeatherList.ViewModel)
    func displayWeatherDetail(viewModel: Weather.SelectDayWeather.ViewModel)
}

class WeatherViewController: UIViewController {
    
    // MARK: Clean Swift
    var interactor: WeatherBusinessLogic?
    var router: WeatherRoutingLogic?
    
    // MARK: View Models
    
    var dayWeathers: [Weather.DayWeatherViewModel] = []
    
    private func setup() {
        self.title = "WEATHER"
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = WeatherWorker()
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor.gray
        
        let nib = UINib.init(nibName: "WeatherTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kWeatherTableViewCellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadWeather(cityName: String) {
        let request = Weather.LoadWeatherList.Request(cityName: cityName)
        interactor?.loadWeatherList(request: request)
    }
    
    func selectDayWeather(index: Int) {
        let request = Weather.SelectDayWeather.Request(index: index)
        interactor?.selectDayWeather(request: request)
    }
}


extension WeatherViewController: WeatherDisplayLogic {
    
    func displayWeatherList(viewModel: Weather.LoadWeatherList.ViewModel) {
        self.dayWeathers = viewModel.dayWeathers
        self.tableView.reloadData()
    }
    
    func displayWeatherDetail(viewModel: Weather.SelectDayWeather.ViewModel) {
        router?.navigateTo(dayWeather: viewModel.dayWeather)
    }
}
