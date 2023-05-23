//
//  ViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

final class FootballPlayersViewController: UIViewController {

	private let playersView = FootballPlayersView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	private var presenter: IFootballPlayerPresenter

	init(presenter: IFootballPlayerPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = self.playersView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(ui: self.playersView, vc: self)
	}
}
