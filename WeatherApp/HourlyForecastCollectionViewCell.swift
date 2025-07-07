//
//  HourlyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Caio Luna on 05/07/25.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
	
	static let identifier: String = "HourlyForecast"
	
	private lazy var hourLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.whiteMain
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
		return label
	}()
	
	private lazy var iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private lazy var temperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.whiteMain
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		return label
	}()
	
	private lazy var hourlyForecastStatStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [hourLabel, iconImageView, temperatureLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 4
		stackView.layer.borderWidth = 1
		stackView.layer.borderColor = UIColor.whiteTransparent.cgColor
		stackView.layer.cornerRadius = 20
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func loadData(time: String?, icon: UIImage?, temp: String?) {
		hourLabel.text = time
		iconImageView.image = icon
		temperatureLabel.text = temp
	}
	
	private func setupView() {
		setHierarchy()
		setConstraints()
	}
	
	private func setHierarchy() {
		contentView.addSubview(hourlyForecastStatStackView)
	}
	
	private func setConstraints() {
		hourlyForecastStatStackView.setConstraintsToParent(contentView)
		iconImageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
	}
	
}
