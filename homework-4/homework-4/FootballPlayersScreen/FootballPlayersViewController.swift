//
//  ViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

class FootballPlayersViewController: UIViewController {

	private let data: [FootballPlayerModel] = FootballPlayerModel.getDefaultModel()

	private let footballerCollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.collectionViewLayout = layout
		return collectionView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		setupView()

	}
}

private extension FootballPlayersViewController {
	func configureViewController() {
		view.backgroundColor = .systemBackground
		title = "Footballers"
		footballerCollectionView.register(FootballPlayerCell.self,
							 forCellWithReuseIdentifier: FootballPlayerCell.identifier)
		footballerCollectionView.delegate = self
		footballerCollectionView.dataSource = self
	}

	func setupView() {
		view.addSubview(footballerCollectionView)
		footballerCollectionView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
			make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}
}

extension FootballPlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailInfoModel = FootballPlayerDetailViewModel(with: data[indexPath.item])
		let detailViewController = FootballPlayerDetailViewController(with: detailInfoModel)
		
		navigationController?.pushViewController(detailViewController, animated: true)
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		data.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = footballerCollectionView.dequeueReusableCell(withReuseIdentifier: FootballPlayerCell.identifier,
														 for: indexPath) as? FootballPlayerCell else { return UICollectionViewCell() }
		let cellModel = FootballPlayerCellModel(with: data[indexPath.item])
		cell.setData(data: cellModel)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 100, height: 160)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt  section: Int) -> UIEdgeInsets {

		return UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)

	}
}
