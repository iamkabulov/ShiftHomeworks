//
//  CoverterView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

protocol ICoverterView: AnyObject
{
	
}

final class CoverterView: UIView
{
	lazy private var from: CurrencySelectorView = {
		let ui = CurrencySelectorView()
		return ui
	}()

	init() {
		super.init(frame: .zero)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CoverterView: ICoverterView
{

	func setupView() {
		from.translatesAutoresizingMaskIntoConstraints = false
		addSubview(from)
		NSLayoutConstraint.activate([
			from.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			from.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
		])
	}
}
