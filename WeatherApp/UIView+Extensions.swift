//
//  UIView+Extensions.swift
//  WeatherApp
//
//  Created by Caio Luna on 05/07/25.
//

import Foundation
import UIKit

extension UIView {
	func setConstraintsToParent(_ parent: UIView) {
		
		NSLayoutConstraint.activate([
			self.topAnchor.constraint(equalTo: parent.topAnchor),
			self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
		])
	}
}
