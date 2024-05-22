//
//  LabelBuilder.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 23.05.2023.
//

import UIKit

final class LabelBuilder {
	private var label: UILabel

	init() {
		label = UILabel()
	}
}

extension LabelBuilder {
	func cornerRaduis(_ raduis: CGFloat) -> LabelBuilder {
		label.layer.cornerRadius = raduis
		return self
	}

	func font(_ font: UIFont.TextStyle) -> LabelBuilder {
		label.font = UIFont.preferredFont(forTextStyle: font)
		return self
	}

	func numberOfLines(_ numberOfLines: Int) -> LabelBuilder {
		label.numberOfLines = numberOfLines
		return self
	}

	func textAlignment(_ textAlignment: NSTextAlignment) -> LabelBuilder {
		label.textAlignment = textAlignment
		return self
	}

	func build() -> UILabel {
		label
	}
}
