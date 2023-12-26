//
//  ConverterViewController.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

final class ConverterViewController: UIViewController
{
	let converterView = CoverterView()
	private var _presenter: ConverterPresenter?
	private var code: Currency?

	init(code: Currency?) {
		self.code = code
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = self.converterView
		self.converterView.loadCode(code)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self._presenter?.viewDidLoad(view: self.converterView, viewController: self)
	}
}

extension ConverterViewController: ViewProtocol
{
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? ConverterPresenter
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
		converterView.didChanged()
	}
}

