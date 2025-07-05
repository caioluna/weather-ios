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
		imageView.image = UIImage(named: "background")
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var headerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 20
		return view
	}()
	
	private lazy var cityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "São Paulo"
		label.textAlignment = .center
		label.textColor = UIColor(named: "primaryColor")
		label.font = .systemFont(ofSize: 20, weight: .semibold)
		return label
	}()
	
	private lazy var temperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints	= false
		label.text = "28°C"
		label.textAlignment = .left
		label.textColor = UIColor(named: "primaryColor")
		label.font = .systemFont(ofSize: 70, weight: .bold)
		return label
	}()
	
	private lazy var weatherIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "sun-icon")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
	}
	
	private func setHierarchy() {
		view.addSubview(backgroundView)
		view.addSubview(headerView)
		
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
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
			headerView.heightAnchor.constraint(equalToConstant: 169),
		])
		
		NSLayoutConstraint.activate([
			cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
			cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
			cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
		])
		
		NSLayoutConstraint.activate([
			temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
			temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
		])
		
		NSLayoutConstraint.activate([
			weatherIcon.heightAnchor.constraint(equalToConstant: 86),
			weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
			weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 16),
			weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
		])
	}

	private func setupView() {
		setHierarchy()
		setConstraints()
	}
}

