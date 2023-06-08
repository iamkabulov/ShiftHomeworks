//
//  ImagesListPresenter.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

protocol IImageListPresenter: AnyObject {
	func viewDidLoad(tableView: IImagesListView, viewController: ImagesListViewController)
	func showImage(url: String, _ image: UIImage)
	func loadSavedImage(url: String, _ image: UIImage)
	func showError(url: String, _ error: NetworkError)
	func showDataError(_ error: DataError)
	func showDownloading(url: String)
}

final class ImagesListPresenter {

	weak var tableView: IImagesListView?
	weak var viewController: IImagesListViewController?
	var interactor: IImagesListInteractor?
	private let router: IImagesListRouter

	init(router: IImagesListRouter) {
		self.router = router
	}
}

extension ImagesListPresenter: IImageListPresenter {
	func showDataError(_ error: DataError) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		switch error {
		case DataError.create:
			alert.message = "Can't save image. Please try later."
			self.viewController?.present(vc: alert, animated: true, completion: nil)
		case DataError.read:
			alert.message = "Can't load image. Please try later."
			self.viewController?.present(vc: alert, animated: true, completion: nil)
		case DataError.alreadySaved:
			alert.message = "This image had already saved."
			self.viewController?.present(vc: alert, animated: true, completion: nil)
		}
	}

	func loadSavedImage(url: String, _ image: UIImage) {
		self.tableView?.loadSavedImage(url: url, image: image)
	}

	func showDownloading(url: String) {
		self.tableView?.startLoad(url: url)
	}

	func showError(url: String, _ error: NetworkError) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		switch error {
		case NetworkError.alreadyExist:
			alert.message = "Already downloading or paused download"
			self.tableView?.removeFailedImage(url: url)
			self.tableView?.reload()
			self.viewController?.present(vc: alert, animated: true, completion: nil)
		case NetworkError.inValidURL:
			alert.message = "Invalid URL"
			self.tableView?.reload()
			self.viewController?.present(vc: alert, animated: true, completion: nil)
		default:
			alert.message = "Something went wrong. Try again later"
			self.tableView?.loadingFailed(url: url)
			self.tableView?.reload()
			self.viewController?.present(vc: alert, animated: true, completion: nil)
		}
	}

	func showImage(url: String, _ image: UIImage) {
		self.tableView?.set(url: url, image: image)
		self.tableView?.reload()
	}
	

	func viewDidLoad(tableView: IImagesListView, viewController: ImagesListViewController) {
		self.tableView = tableView
		viewController.title = "HOMEWORK #7"
		self.viewController = viewController
		self.viewController?.seachButtonTapped = { url in
			if self.isValidURL(url) {
				self.loadImage(url)
				self.tableView?.startLoad(url: url)
				self.tableView?.reload()
			} else {
				self.showError(url: url, NetworkError.inValidURL)
				self.tableView?.reload()
			}
		}
		self.interactor?.savedImages()
		self.tableView?.reload()

		self.tableView?.pauseButtonTapped = { url in
			self.pauseLoadImage(url)
		}

		self.tableView?.resumeButtonTapped = { url in
			self.resumeLoadImage(url)
		}

		self.tableView?.saveButtonTapped = { url, image in
			guard let image = image else {
				return self.showDataError(.create)
			}
			self.saveImage(url, image)
		}
	}
}

private extension ImagesListPresenter {
	func loadImage(_ url: String) {
		self.interactor?.loadImageByLink(url: url)
	}

	func pauseLoadImage(_ url: String) {
		self.interactor?.pauseLoadImage(url: url)
	}

	func resumeLoadImage(_ url: String) {
		self.interactor?.resumeLoadImage(url: url)
	}

	func saveImage(_ url: String, _ image: UIImage) {
		self.interactor?.saveImage(url: url, image: image)
	}

	func isValidURL(_ urlString: String) -> Bool {
		let urlRegEx = #"((https?|http)://)(([a-zA-Z0-9\-])+\.?)+([a-zA-Z]{2,})(/[a-zA-Z0-9\-_.?=&]+)*"#
		let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
		return urlPredicate.evaluate(with: urlString)
	}
}
