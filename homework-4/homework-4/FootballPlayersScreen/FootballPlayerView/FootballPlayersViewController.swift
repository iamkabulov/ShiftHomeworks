//
//  ViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

final class FootballPlayersViewController: UIViewController {

	private let uiView = FootballPlayersView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	var presenter: IFootballPlayerPresenter

	init(presenter: IFootballPlayerPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(ui: self.uiView, vc: self)
		self.setupView()
		view.backgroundColor = .systemBackground
		title = "Footballers"
	}
}

extension FootballPlayersViewController {

	func setupView() {
		view.addSubview(uiView)
		uiView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
			make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}
	
}
