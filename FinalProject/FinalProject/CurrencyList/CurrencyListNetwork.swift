//
//  CurrencyListNetwork.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import Foundation

protocol ICurrencyListNetwork
{
	func loadCurrencies(completion: @escaping (Result<[Currency], NetworkError>) -> Void)
}

enum NetworkError: Error {
	case serverError
	case decodingError
}

final class CurrencyListNetwork
{

}

extension CurrencyListNetwork: ICurrencyListNetwork
{
	func loadCurrencies(completion: @escaping (Result<[Currency], NetworkError>) -> Void) {
		let url = URL(string: "https://v6.exchangerate-api.com/v6/b859b860bc82683eb9de37fd/codes")!
		URLSession.shared.dataTask(with: url) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) {
				guard let data = data, error == nil else {
					completion(.failure(.serverError))
					return
				}
				do {
					let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)
					let currencies = response.supportedCodes.map { Currency(code: $0[0], name: $0[1])}
					completion(.success(currencies))
				} catch {
					completion(.failure(.decodingError))
				}
			}
		}.resume()
	}
}
