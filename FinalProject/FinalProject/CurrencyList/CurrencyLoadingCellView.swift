//
//  CurrencyLoadingCellView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import UIKit

protocol ICurrencyLoadingCellView: AnyObject
{

}

final class CurrencyLoadingCellView: UITableViewCell
{
	static let reuseId = "loadingcellId"
	static let rowHeight: CGFloat = 60

	private enum Metrics {
		static let height: CGFloat = 32
		static let width: CGFloat = 56
		enum Spacing {
			static let small: CGFloat = 2
			static let medium: CGFloat = 8
		}
	}

	lazy private var code: UILabel = {
		let code = UILabel()
		code.textColor = .black
		code.text = "                     "
		return code
	}()

	lazy private var name: UILabel = {
		let name = UILabel()
		name.textColor = .gray
		name.text = "                                             "
		name.font = .preferredFont(forTextStyle: .caption1)
		return name
	}()

	lazy private var flagImage: UIImageView = {
		let flagImage = UIImageView()
		flagImage.image = UIImage(named: "xx")
		flagImage.layer.cornerRadius = 5
		flagImage.contentMode = .scaleAspectFit
		return flagImage
	}()

	let flagImageLayer = CAGradientLayer()
	let codeLayer = CAGradientLayer()
	let nameLayer = CAGradientLayer()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupCell()
		setupLayers()
		setupAnimation()
		backgroundColor = .systemGray6

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		flagImageLayer.frame = flagImage.bounds
		flagImageLayer.cornerRadius = 5
		codeLayer.frame = code.bounds
		codeLayer.cornerRadius = 5
		codeLayer.frame.size.height /= 2
		nameLayer.frame = name.bounds
		nameLayer.cornerRadius = 5
		nameLayer.frame.size.height /= 1.2
	}
}

//MARK: - ICurrencyLoadingCellView
extension CurrencyLoadingCellView: ICurrencyLoadingCellView, SkeletonLoadable
{
	private func setupLayers() {
		flagImageLayer.startPoint = CGPoint(x: 0, y: 0.5)
		flagImageLayer.endPoint = CGPoint(x: 1, y: 0.5)
		flagImage.layer.addSublayer(flagImageLayer)

		codeLayer.startPoint = CGPoint(x: 0, y: 0.5)
		codeLayer.endPoint = CGPoint(x: 1, y: 0.5)
		code.layer.addSublayer(codeLayer)

		nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
		nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
		name.layer.addSublayer(nameLayer)
	}

	private func setupAnimation() {
		let typeGroup = makeAnimationGroup()
		typeGroup.beginTime = 0.0
		flagImageLayer.add(typeGroup, forKey: "backgroundColor")

		let nameGroup = makeAnimationGroup(previousGroup: typeGroup)
		nameLayer.add(nameGroup, forKey: "backgroundColor")

		let codeGroup = makeAnimationGroup(previousGroup: typeGroup)
		codeLayer.add(codeGroup, forKey: "backgroundColor")
	}

	func setupCell() {
		code.translatesAutoresizingMaskIntoConstraints = false
		name.translatesAutoresizingMaskIntoConstraints = false
		flagImage.translatesAutoresizingMaskIntoConstraints = false

		addSubview(flagImage)
		addSubview(code)
		addSubview(name)
		NSLayoutConstraint.activate([
			flagImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			flagImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			flagImage.heightAnchor.constraint(equalToConstant: Metrics.height),
			flagImage.widthAnchor.constraint(equalToConstant: Metrics.width),
			code.topAnchor.constraint(equalTo: flagImage.topAnchor),
			code.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: Metrics.Spacing.medium),
			name.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor),
			name.leadingAnchor.constraint(equalTo: code.leadingAnchor)
		])
	}
}


protocol SkeletonLoadable
{

}

extension SkeletonLoadable {

	func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
		let animDuration: CFTimeInterval = 1.2
		let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
		anim1.fromValue = UIColor.gradientLightGrey.cgColor
		anim1.toValue = UIColor.gradientDarkGrey.cgColor
		anim1.duration = animDuration
		anim1.beginTime = 0.0

		let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
		anim2.fromValue = UIColor.gradientDarkGrey.cgColor
		anim2.toValue = UIColor.gradientLightGrey.cgColor
		anim2.duration = animDuration
		anim2.beginTime = anim1.beginTime + anim1.duration

		let group = CAAnimationGroup()
		group.animations = [anim1, anim2]
		group.repeatCount = .greatestFiniteMagnitude
		group.duration = anim2.beginTime + anim2.duration
		group.isRemovedOnCompletion = false

		if let previousGroup = previousGroup {
			group.beginTime = previousGroup.beginTime + 0.26
		}
		return group
	}
}

extension UIColor {
	static var gradientDarkGrey: UIColor {
		return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
	}
	static var gradientLightGrey: UIColor {
		return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
	}
}
