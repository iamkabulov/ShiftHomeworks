//
//  CurrencyListRouter.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import UIKit

protocol ICurrencyListRouter: AnyObject
{

}

final class CurrencyListRouter
{

}

//MARK: - ICurrencyListRouter
extension CurrencyListRouter: ICurrencyListRouter, RouterProtocol
{
	func currencyConverter(viewController: CurrencyListViewController, _ code: Currency) {
		let converterBuilder = ModuleBuilder<ConverterViewController, ConverterInteractor, ConverterPresenter, ConverterRouter>()

		let converterInteractor = ConverterInteractor()
		let converterRouter = ConverterRouter()
		let converterPresenter = ConverterPresenter()
		let converterViewController = ConverterViewController(code: code)

		let moneyVC = converterBuilder.setView(converterViewController)
			.setInteractor(converterInteractor)
			.setPresenter(converterPresenter)
			.setRouter(converterRouter)
			.buildModule()

//		viewController.navigationController?.pushViewController(converterViewController, animated: true)
	}
}
