//
//  DailyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Caio Luna on 05/07/25.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
	
	static var identifier: String = "DailyForecast"
	
	private lazy var weekDayLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var weatherIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private lazy var minTemperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.white
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var maxTemperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.white
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var dailyForecastStatsStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [weekDayLabel, weatherIconImageView, minTemperatureLabel, maxTemperatureLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = 15
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
		return stackView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func loadData(weekDay: String?, icon: UIImage?, min: String?, max: String?) {
		weekDayLabel.text = weekDay
		weatherIconImageView.image = icon
		minTemperatureLabel.text = min
		maxTemperatureLabel.text = max
	}
	
	private func setupView() {
		backgroundColor = .clear
		selectionStyle = .none
		
		setHierarchy()
		setConstraints()
	}
	
	private func setHierarchy() {
		contentView.addSubview(dailyForecastStatsStackView)
	}
	
	private func setConstraints() {
		dailyForecastStatsStackView.setConstraintsToParent(contentView)
		
		weekDayLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
		weatherIconImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 160).isActive = true
	}
	
}
