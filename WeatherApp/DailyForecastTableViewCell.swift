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
		label.text = "TER"
		label.textColor = UIColor.whiteMain
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var weatherIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage.sunIcon
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private lazy var minTemperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "min 20ºC"
		label.textColor = UIColor.white
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		return label
	}()
	
	private lazy var maxTemperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "max 25ºC"
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
		weekDayLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 36).isActive = true
		weatherIconImageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
	}
	
}
