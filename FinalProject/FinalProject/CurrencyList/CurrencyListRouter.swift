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
	func currencyConverter(viewController: CurrencyListViewController, _ code: String) {
		viewController.navigationController?.pushViewController(UIViewController(), animated: true)
	}
}
