//
//  ImagesListLoadingCellView.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit
protocol IImagesListLoadingCellView: AnyObject {
	func startAnimating()
	func stopAnimating()
	var isAnimating: Bool { get }
	var btnPressed: (() -> Void)? { get set }
}

final class ImagesListLoadingCellView: UITableViewCell {

	private enum Metrics {
		enum Spacing {
			static let large: CGFloat = 16
		}
	}

	static let reuseIdentifier = "loadingCellId"
	private let spinner = UIActivityIndicatorView(style: .medium)
	private let button = UIButton(type: .system)
	private let btn = UIButton(type: .system)
	var btnPressed: (() -> Void)?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureButton()
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Configuration
extension ImagesListLoadingCellView: IImagesListLoadingCellView {
	var isAnimating: Bool {
		if spinner.isAnimating {
			return true
		}
		return false
	}

	func startAnimating() {
		spinner.startAnimating()
		button.setTitle("Pause", for: .normal)
	}

	func stopAnimating() {
		spinner.stopAnimating()
		button.setTitle("Continue", for: .normal)
	}

	func configureButton() {
		button.setTitle("Pause", for: .normal)
		btn.setTitle("PRESS", for: .normal)
		btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
	}

	func printBtnPressed() {
		print("CELL")
	}



	@objc func addButtonTapped() {
		printBtnPressed()
	}

	func setupUI() {
		button.translatesAutoresizingMaskIntoConstraints = false
		spinner.translatesAutoresizingMaskIntoConstraints = false
		btn.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(button)
		contentView.addSubview(spinner)
		contentView.addSubview(btn)
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
			button.centerYAnchor.constraint(equalTo: centerYAnchor),
			button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.large),
			btn.centerYAnchor.constraint(equalTo: centerYAnchor),
			btn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.large)
		])
	}
}

