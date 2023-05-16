//
//  FootballPlayerCell.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit
import SnapKit

protocol IFootballPlayerCell: AnyObject
{
	func set(model: FootballPlayerCellModel)
}

final class FootballPlayerCell: UICollectionViewCell {
	
	private enum Metrics {
		static let height: CGFloat = 140
		static let width: CGFloat = 100
	}
	var cellDataLoadHandler: (() -> Void)?

	static let identifier = "collectionViewId"
	private let stackView = UIStackView()
	private let label = UILabel()
	private let imageView = UIImageView()


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
}

extension FootballPlayerCell: IFootballPlayerCell {
	func set(model: FootballPlayerCellModel) {
		label.text = model.name
		imageView.image = model.image
	}
}

private extension FootballPlayerCell {
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
