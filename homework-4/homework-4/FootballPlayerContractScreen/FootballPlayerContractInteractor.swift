//
//  FootballPlayerContractInteractor.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import Foundation

protocol IFootballPlayerContractInteractor {
	
}

final class FootballPlayerContractInteractor {
	weak var presenter: FootballPlayerContractPresenter?
}

extension FootballPlayerContractInteractor: IFootballPlayerContractInteractor {

}
