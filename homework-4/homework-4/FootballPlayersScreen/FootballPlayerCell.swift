//
//  FootballPlayerCell.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit
import SnapKit

class FootballPlayerCell: UICollectionViewCell {
	
	static let identifier = "collectionViewId"
	let stackView = UIStackView()
	let label = UILabel()
	let imageView = UIImageView()


	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		configureStackView()
		configureImageView()
		configureNameLabel()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureNameLabel() {
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textAlignment = .center
	}

	func configureImageView() {
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
	}

	func configureStackView() {
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 4
	}

	func setData(data model: FootballPlayerCellModel) {
		label.text = model.name
		imageView.image = model.image
	}

	func setupViews() {
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(label)
		contentView.addSubview(stackView)

		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		imageView.snp.makeConstraints { make in
			make.height.equalTo(Metrics.height)
			make.width.equalTo(Metrics.width)
		}
	}
}

private enum Metrics {
	static let height: CGFloat = 140
	static let width: CGFloat = 100
}
