//
//  LoadingInputView.swift
//  FinalProject
//
//  Created by Nursultan Kabulov on 21.12.2023.
//

import UIKit

protocol ILoadingInputView: AnyObject
{

}

final class LoadingInputView: UIView
{
	private enum Metrics {
		static let height: CGFloat = 60
		static let width: CGFloat = 56
		enum Spacing {
			static let small: CGFloat = 2
			static let medium: CGFloat = 8
		}
	}

	lazy private var input: UILabel = {
		let code = UILabel()
		code.textColor = .black
		code.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		code.text = "    "
		return code
	}()

	let inputLayer = CAGradientLayer()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCell()
		setupLayers()
		setupAnimation()
//		backgroundColor = .systemGray6
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		inputLayer.frame = input.bounds
		inputLayer.cornerRadius = 5
	}
}

//MARK: - LoadingInputView
extension LoadingInputView: ILoadingInputView, SkeletonLoadable
{
	private func setupLayers() {
		inputLayer.startPoint = CGPoint(x: 0, y: 0.5)
		inputLayer.endPoint = CGPoint(x: 1, y: 0.5)
		input.layer.addSublayer(inputLayer)
	}

	private func setupAnimation() {
		let typeGroup = makeAnimationGroup()
		typeGroup.beginTime = 0.0
		let codeGroup = makeAnimationGroup(previousGroup: typeGroup)
		inputLayer.add(codeGroup, forKey: "backgroundColor")
	}

	func setupCell() {
		input.translatesAutoresizingMaskIntoConstraints = false
		addSubview(input)
		NSLayoutConstraint.activate([
			input.topAnchor.constraint(equalTo: topAnchor, constant: 1),
			input.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
			input.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
			input.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
		])
	}
}
