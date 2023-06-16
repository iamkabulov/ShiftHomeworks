//
//  ConverterNetwork.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import Foundation

protocol IConverterNetwork
{
	func loadRates(code: String, completion: @escaping (Result<[CurrencyRate], NetworkError>) -> Void)
}

final class ConverterNetwork
{

}

extension ConverterNetwork: IConverterNetwork
{
	func loadRates(code: String, completion: @escaping (Result<[CurrencyRate], NetworkError>) -> Void) {
		let url = URL(string: "https://v6.exchangerate-api.com/v6/b859b860bc82683eb9de37fd/latest/\(code)")!
		URLSession.shared.dataTask(with: url) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) {
				guard let data = data, error == nil else {
					completion(.failure(.serverError))
					return
				}
				do {
					let response = try JSONDecoder().decode(CurrencyRateResponse.self, from: data)
					var rates = [CurrencyRate]()
					for (code, rate) in response.conversionRates {
						let currency = CurrencyRate(code: code, rate: rate)
						rates.append(currency)
					}
					completion(.success(rates))
				} catch {
					completion(.failure(.decodingError))
				}
			}
		}.resume()
	}
}
