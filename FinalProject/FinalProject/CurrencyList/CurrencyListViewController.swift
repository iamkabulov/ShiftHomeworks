import UIKit

final class CurrencyListViewController: UIViewController
{
	private let tableView = CurrencyListView(frame: .zero, style: .plain)
	private var _presenter: CurrencyListPresenter?

	init(
//		presenter: ICurrencyListPresenter
	) {
//		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = self.tableView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self._presenter?.viewDidLoad(tableView: self.tableView, viewController: self)
	}
}

extension CurrencyListViewController: ViewProtocol
{
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? CurrencyListPresenter
		}
	}


}
