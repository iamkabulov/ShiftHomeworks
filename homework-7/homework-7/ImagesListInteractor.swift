//
//  ImagesInteractor.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit
import CoreData

enum NetworkError: Error {
	case alreadyExist
	case inValidURL
	case serverError
	case decodingError
	case statusCode(Int)
}

enum DataError: Error {
	case read
	case create
	case alreadySaved
}

protocol IImagesListInteractor: AnyObject {
	func loadImageByLink(url: String)
	func pauseLoadImage(url: String)
	func resumeLoadImage(url: String)
	func saveImage(url: String, image: UIImage)
	func savedImages()
}

final class ImagesListInteractor {
	private var network: ImagesListInteractorNetworking
	private let container = NSPersistentContainer(name: "Model")
	private var context: NSManagedObjectContext
	private let image: Image
	var presenter: IImageListPresenter?

	init() {
		self.context = self.container.viewContext
		self.network = ImagesListInteractorNetworking()
		self.image = Image(context: self.context)
		self.container.loadPersistentStores { _, error in
			print("Container: Something went wrong")
		}
		self.network.delegate = self
	}
}

extension ImagesListInteractor: IImagesListInteractorNetworking {

	func imageDownloaded(url: String, _ image: UIImage?) {
		guard let image = image else { return }
		DispatchQueue.main.async {
			self.presenter?.showImage(url: url, image)
		}
	}

	func imageDownloadFailed(url: String, with error: NetworkError) {
		DispatchQueue.main.async {
			self.presenter?.showError(url: url, error)
		}
	}

	func savedImages() {
		let request = Image.fetchRequest()
		do {
			let entities = try context.fetch(request)
			entities.forEach { entity in
				guard let data = entity.data, let image = UIImage(data: data), let url = entity.url else { return }
				self.presenter?.loadSavedImage(url: url, image)
			}
		} catch {
			DispatchQueue.main.async {
				self.presenter?.showDataError(.read)
			}
		}
	}
}

extension ImagesListInteractor: IImagesListInteractor {
	func loadImageByLink(url: String) {
		self.network.getImageByUrl(url)
	}

	func pauseLoadImage(url: String) {
		self.network.pauseDownload(url)
	}

	func resumeLoadImage(url: String) {
		self.network.resumeDownload(url)
	}

	func saveImage(url: String, image: UIImage) {
		let request = Image.fetchRequest()
		request.predicate = NSPredicate(format: "url == '\(url)'")
		do {
			let isExist = try context.fetch(request)
			if isExist.count == 0 {
				if let imageData = image.pngData() {
					self.image.data = imageData
					self.image.url = url
					do {
						try context.save()
					} catch {
						DispatchQueue.main.async {
							self.presenter?.showDataError(.create)
						}
					}
				} else if let imageData = image.jpegData(compressionQuality: 1.0) {
					self.image.data = imageData
					self.image.url = url
					do {
						try context.save()
					} catch {
						DispatchQueue.main.async {
							self.presenter?.showDataError(.create)
						}
					}
				}
			} else {
				self.presenter?.showDataError(.alreadySaved)
			}
		} catch {
			self.presenter?.showDataError(.create)
		}

	}
}
