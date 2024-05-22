//
//  FootballPlayersView.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.05.2023.
//

import UIKit

protocol IFootballPlayersView: AnyObject {
	var tapButtonHandler: ((String) -> Void)? { get set }
	func set(model: [FootballPlayersEntity])
}

final class FootballPlayersView: UICollectionView {
	
	private enum Metrics {
		static let spacingInterItem: CGFloat = 1
		static let inset: CGFloat = 16
		static let zeroInset: CGFloat = 0
		
		enum Cell {
			static let width: CGFloat = 100
			static let height: CGFloat = 160
		}
	}
	
	var tapButtonHandler: ((String) -> Void)?
	private var model = [FootballPlayersEntity]()
	
	private var footballerCollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.collectionViewLayout = layout
		collectionView.backgroundColor = .secondarySystemBackground
		return collectionView
	}()
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		backgroundColor = .secondarySystemBackground
		configureView()
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Extension
extension FootballPlayersView: IFootballPlayersView {
	func set(model: [FootballPlayersEntity]) {
		self.model = model
	}
}

private extension FootballPlayersView {
	func configureView() {
		footballerCollectionView.register(FootballPlayerCell.self,
										  forCellWithReuseIdentifier: FootballPlayerCell.identifier)
		footballerCollectionView.delegate = self
		footballerCollectionView.dataSource = self
	}
	
	func setupView() {
		addSubview(footballerCollectionView)
		footballerCollectionView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
			make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
		}
	}
}

extension FootballPlayersView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let name = model[indexPath.item].name
		self.tapButtonHandler?(name)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		model.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = footballerCollectionView.dequeueReusableCell(withReuseIdentifier: FootballPlayerCell.identifier,
																	  for: indexPath) as? FootballPlayerCell else { return UICollectionViewCell() }
		let cellModel = FootballPlayerCellModel(with: model[indexPath.item])
		cell.set(model: cellModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: Metrics.Cell.width,
					  height: Metrics.Cell.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return Metrics.spacingInterItem
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt  section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets.init(top: Metrics.zeroInset,
								 left: Metrics.inset,
								 bottom: Metrics.zeroInset,
								 right: Metrics.inset)
		
	}
}
