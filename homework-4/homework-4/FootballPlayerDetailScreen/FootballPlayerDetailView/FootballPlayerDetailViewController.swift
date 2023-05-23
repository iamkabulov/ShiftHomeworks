//
//  FootballPlayerDetailViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

final class FootballPlayerDetailViewController: UIViewController {
	
	private enum Metrics {
		enum Spacing {
			static let small: CGFloat = 8
		}
	}
	
	private let footballPlayerDetailView = FootballPlayerDetailView(frame: .zero)
	private var presenter: IFootballPlayerDetailPresenter
	
	init(presenter: IFootballPlayerDetailPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func loadView() {
		super.loadView()
		self.view = self.footballPlayerDetailView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(ui: self.footballPlayerDetailView, vc: self)
	}
}

