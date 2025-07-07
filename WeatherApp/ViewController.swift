//
//  ViewController.swift
//  WeatherApp
//
//  Created by Caio Luna on 04/07/25.
//

import UIKit

class ViewController: UIViewController {
	
	private lazy var backgroundView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var headerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.whiteMain.withAlphaComponent(0.1)
		view.layer.cornerRadius = 20
		return view
	}()
	
	private lazy var cityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 20, weight: .semibold)
		return label
	}()
	
	private lazy var temperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints	= false
		label.textAlignment = .left
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 70, weight: .bold)
		return label
	}()
	
	private lazy var weatherIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private lazy var humidityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Umidade"
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var humidityValueLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints	= false
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var windLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Vento"
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var windValueLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints	= false
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var humidityStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		return stackView
	}()
	
	private lazy var windStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		return stackView
	}()
	
	private lazy var statsStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 6
		stackView.backgroundColor = UIColor.blueLight
		stackView.layer.cornerRadius = 10
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
		return stackView
	}()
	
	private lazy var hourlyForecastLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "PREVISÃO POR HORA"
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var hourlyCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: 67, height: 84)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.dataSource = self
		collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = .clear
		return collectionView
	}()
	
	private lazy var dailyForecastLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "PRÓXIMOS DIAS"
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var dailyForecastTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = self
		tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
		tableView.delegate = self
		tableView.showsVerticalScrollIndicator = false
		tableView.separatorColor = UIColor.whiteMain
		tableView.separatorInset = .zero
		tableView.backgroundColor = .clear
		return tableView
	}()
	
	private let service = Service()
	private var city = City(lat: "-23.705943187390012", lon: "-46.6933772557763", name: "São Paulo")
	private var forecastResponse: ForecastResponse?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		fetchData()
	}
	
	private func fetchData() {
		
		service.fetchData(city: city) { [weak self] response in
			
			DispatchQueue.main.async {
				self?.forecastResponse = response
				self?.loadData()
			}
		}
	}
	
	private func loadData() {
		backgroundView.image = forecastResponse?.current.dt.isDayTime() ?? true ? UIImage(named: "background-day") : UIImage(named: "background-night")
		
		cityLabel.text = city.name
		weatherIcon.image = UIImage(named: forecastResponse?.current.weather[0].icon ?? "sun-icon")
		temperatureLabel.text =  forecastResponse?.current.temp.toCelcius()
		
		humidityValueLabel.text = "\(forecastResponse?.current.humidity ?? 0) mm"
		windValueLabel.text = "\(forecastResponse?.current.windSpeed ?? 0) km/h"
		
		hourlyCollectionView.reloadData()
		dailyForecastTableView.reloadData()
	}
	
	private func setHierarchy() {
		view.addSubview(backgroundView)
		view.addSubview(headerView)
		view.addSubview(statsStackView)
		view.addSubview(hourlyForecastLabel)
		view.addSubview(hourlyCollectionView)
		view.addSubview(dailyForecastLabel)
		view.addSubview(dailyForecastTableView)
		
		headerView.addSubview(cityLabel)
		headerView.addSubview(temperatureLabel)
		headerView.addSubview(weatherIcon)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46),
			headerView.heightAnchor.constraint(equalToConstant: 169),
		])
		
		NSLayoutConstraint.activate([
			cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
			cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
			cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
			cityLabel.heightAnchor.constraint(equalToConstant: 20),
		])
		
		NSLayoutConstraint.activate([
			temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
			temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
			temperatureLabel.heightAnchor.constraint(equalToConstant: 71),
		])
		
		NSLayoutConstraint.activate([
			weatherIcon.heightAnchor.constraint(equalToConstant: 86),
			weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
			weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 16),
			weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
		])
		
		NSLayoutConstraint.activate([
			statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
			statsStackView.widthAnchor.constraint(equalToConstant: 204),
			statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])
		
		NSLayoutConstraint.activate([
			hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 20),
			hourlyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])
		
		NSLayoutConstraint.activate([
			hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
			hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
			hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
		
		NSLayoutConstraint.activate([
			dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 30),
			dailyForecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])
		
		NSLayoutConstraint.activate([
			dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 22),
			dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
			dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
		])
	}
	
	private func setupView() {
		setHierarchy()
		setConstraints()
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return forecastResponse?.hourly.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as? HourlyForecastCollectionViewCell else { return UICollectionViewCell() }
		
		let forecast = forecastResponse?.hourly[indexPath.row]
		cell.loadData(time: forecast?.dt.toHourFormat(), icon: UIImage(named: forecast?.weather.first?.icon ?? "sun-icon"), temp: forecast?.temp.toCelcius())
		return cell
	}
	
	
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return forecastResponse?.daily.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as? DailyForecastTableViewCell else { return UITableViewCell() }
		
		let forecast = forecastResponse?.daily[indexPath.row]
		cell.loadData(weekDay: forecast?.dt.toWeekdayName(), icon: UIImage(named: forecast?.weather.first?.icon ?? "sun-icon"), min: forecast?.temp.min.toCelcius(), max: forecast?.temp.max.toCelcius())
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		60
	}
	
}
