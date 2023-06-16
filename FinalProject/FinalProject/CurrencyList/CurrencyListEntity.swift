//
//  CurrencyListEntity.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import Foundation

struct CurrencyResponse: Decodable {
	let result: String
	let documentation: URL
	let termsOfUse: URL
	let supportedCodes: [[String]]

	enum CodingKeys: String, CodingKey {
		case result
		case documentation
		case termsOfUse = "terms_of_use"
		case supportedCodes = "supported_codes"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		result = try container.decode(String.self, forKey: .result)
		documentation = try container.decode(URL.self, forKey: .documentation)
		termsOfUse = try container.decode(URL.self, forKey: .termsOfUse)
		supportedCodes = try container.decode([[String]].self, forKey: .supportedCodes)
	}
}

struct Currency: Decodable {
	let code: String
	let name: String
}
