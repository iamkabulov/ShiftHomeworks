//
//  CurrencyRateEntity.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import Foundation

struct CurrencyRateResponse: Decodable {
	let result: String
	let documentation: URL
	let termsOfUse: URL
	let timeLastUpdateUnix: Int
	let timeLastUpdateUTC: String
	let timeNextUpdateUnix: Int
	let timeNextUpdateUTC: String
	let baseCode: String
	let conversionRates: [String: Double]

	enum CodingKeys: String, CodingKey {
		case result
		case documentation
		case termsOfUse = "terms_of_use"
		case timeLastUpdateUnix = "time_last_update_unix"
		case timeLastUpdateUTC = "time_last_update_utc"
		case timeNextUpdateUnix = "time_next_update_unix"
		case timeNextUpdateUTC = "time_next_update_utc"
		case baseCode = "base_code"
		case conversionRates = "conversion_rates"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		result = try container.decode(String.self, forKey: .result)
		documentation = try container.decode(URL.self, forKey: .documentation)
		termsOfUse = try container.decode(URL.self, forKey: .termsOfUse)
		timeLastUpdateUnix = try container.decode(Int.self, forKey: .timeLastUpdateUnix)
		timeLastUpdateUTC = try container.decode(String.self, forKey: .timeLastUpdateUTC)
		timeNextUpdateUnix = try container.decode(Int.self, forKey: .timeNextUpdateUnix)
		timeNextUpdateUTC = try container.decode(String.self, forKey: .timeNextUpdateUTC)
		baseCode = try container.decode(String.self, forKey: .baseCode)
		conversionRates = try container.decode([String: Double].self, forKey: .conversionRates)
	}
}

struct CurrencyRate: Decodable {
	let code: String
	let rate: Double

	enum CodingKeys: String, CodingKey {
		case code
		case rate
	}
}
