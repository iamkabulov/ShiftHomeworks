//
//  ConverterRoute.swift
//  FinalProject
//
//  Created by Nursultan Kabulov on 09.12.2023.
//

import UIKit

protocol IConverterRouter: AnyObject
{

}

final class ConverterRouter
{

}


//MARK: - ICurrencyListRouter
extension ConverterRouter: ICurrencyListRouter, RouterProtocol
{
	func showAlert(viewController: UIViewController, title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let actions = UIAlertAction(title: "OK", style: .cancel)
		alert.addAction(actions)
		viewController.present(alert, animated: true)
	}
}
