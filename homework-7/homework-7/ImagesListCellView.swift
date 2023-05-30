//
//  ImagesListCellView.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

protocol IImageListCellView: AnyObject {
	func setImage(image: UIImage)
}

final class ImagesListCellView: UITableViewCell {

	private enum Metrics {
		static let height: CGFloat = 120
		static let width: CGFloat = 120
		enum Spacing {
			static let small: CGFloat = 2
		}
	}

	static let reuseIdentifier = "cellId"
	static let rowHeight: CGFloat = 120
	private let image = UIImageView()
	private let label = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ImagesListCellView: IImageListCellView {

	func setImage(image: UIImage) {
		self.image.image = image
	}

	func setupUI() {
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit

		addSubview(image)
		NSLayoutConstraint.activate([
			image.centerYAnchor.constraint(equalTo: centerYAnchor),
			image.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: Metrics.Spacing.small),
			image.heightAnchor.constraint(equalToConstant: Metrics.height),
			image.widthAnchor.constraint(equalToConstant: Metrics.width),
		])
	}
}

