//
//  ConverterViewController.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

final class ConverterViewController: UIViewController
{
	let ui = CurrencySelectorView()

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = self.ui
		self.ui.delegate = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension ConverterViewController: ICurrencySelectorView
{
	func textFieldDidReturn(_ textField: UITextField) {
		print("CS")
	}
}

