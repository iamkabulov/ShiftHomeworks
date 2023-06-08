//
//  ImagesListView.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

protocol IImagesListView: AnyObject {
	func set(url: String, image: UIImage)
	func loadingFailed(url: String)
	func startLoad(url: String)
	func removeFailedImage(url: String)
	func reload()
	func loadSavedImage(url: String, image: UIImage)
	var pauseButtonTapped: ((String) -> Void)? { get set }
	var resumeButtonTapped: ((String) -> Void)? { get set }
	var saveButtonTapped: ((String, UIImage?) -> Void)? { get set }
}

final class ImagesListView: UITableView {

	var pauseButtonTapped: ((String) -> Void)?
	var resumeButtonTapped: ((String) -> Void)?
	var saveButtonTapped: ((String, UIImage?) -> Void)?
	private var models = [ImagesListEntity]()
	private let tableView = UITableView()
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		configureTableView()
		setupTableView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - DataSource
extension ImagesListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let isLoaded = models[indexPath.item].isLoaded
		if !isLoaded {
			let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListLoadingCellView.reuseIdentifier, for: indexPath) as? ImagesListLoadingCellView
			guard models[indexPath.item].isPaused != nil else {
				cell?.startAnimating()
				return cell ?? UITableViewCell()
			}
			cell?.stopAnimating()
			return cell ?? UITableViewCell()
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCellView.reuseIdentifier, for: indexPath) as! ImagesListCellView
		if models[indexPath.item].isSaved ?? false {
			cell.hideSaveButton()
		}
		guard let image = models[indexPath.item].image else {
			return UITableViewCell()
		}
		cell.setImage(image: image)
		return cell
	}
}

// MARK: - Delegate
extension ImagesListView: UITableViewDelegate, IImagesListView {

	func loadSavedImage(url: String, image: UIImage) {
		self.models.append(ImagesListEntity(url: url, image: image, isSaved: true))
	}


	func removeFailedImage(url: String) {
		for item in 0..<self.models.count {
			if models[item].isPaused == nil && models[item].image == nil && models[item].isLoaded == false {
				self.models.remove(at: item)
			}
		}
	}

	func loadingFailed(url: String) {
		self.models = models.filter { $0.url != url }
	}

	func startLoad(url: String) {
		models.append(ImagesListEntity(url: url))
	}

	func set(url: String, image: UIImage) {
		for item in 0..<models.count {
			if url == models[item].url {
				models[item].image = image
			}
		}
	}

	func reload() {
		self.tableView.reloadData()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if let cell = tableView.cellForRow(at: indexPath) as? ImagesListLoadingCellView {
			if cell.isAnimating {
				cell.stopAnimating()
				let pauseUrl = models[indexPath.item].url
				pauseButtonTapped?(pauseUrl)
				models[indexPath.item].isPaused = true
			} else {
				cell.startAnimating()
				let resumeUrl = models[indexPath.item].url
				resumeButtonTapped?(resumeUrl)
				models[indexPath.item].isPaused = false
			}
		} else if let cell = tableView.cellForRow(at: indexPath) as? ImagesListCellView {
			let imageToSave = cell.saveImage()
			let urlToSave = models[indexPath.item].url
			saveButtonTapped?(urlToSave, imageToSave)
			cell.hideSaveButton()
		}

	}

	func configureTableView() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.rowHeight = ImagesListCellView.rowHeight
		self.tableView.register(ImagesListLoadingCellView.self, forCellReuseIdentifier: ImagesListLoadingCellView.reuseIdentifier)
		self.tableView.register(ImagesListCellView.self, forCellReuseIdentifier: ImagesListCellView.reuseIdentifier)
	}

	func setupTableView() {
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}
}




