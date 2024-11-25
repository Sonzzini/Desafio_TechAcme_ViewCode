//
//  RepositoryViewController.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation
import UIKit

class RepositoryViewController: UIViewController, RepositoryDisplayer, UITableViewDelegate {
	
	private var router: Router?
	var repositoryInteractor: BusinessRepository?
	var repositories: [Repository] = []
	
	var isLoading: Bool = false
	
	var errorMessage: String? = nil
	
	lazy var repositoryView = RepositoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
	
	override func viewDidLoad() {
		super.viewDidLoad()		
		
		navigationController?.navigationBar.prefersLargeTitles = true
//		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
		title = "Repositories"
		router = Router(navigationController: navigationController!)
		
		fetchRepositories()
		
		setElements()
		
		repositoryView.tableView.delegate = self
		repositoryView.tableView.dataSource = self
	}
	
	func fetchRepositories() {
		let request = RepositoryWebAccess.Request(q: "language:Swift",
																sort: "stars",
																page: 1,
																order: nil)

		repositoryInteractor?.startFetchingRepositories(request: request)
	}
	
	func displayRepositories() {
		DispatchQueue.main.async {
			self.repositoryView.tableView.reloadData()
		}
	}
	
	func setElements() {
		view.addSubview(repositoryView)
	}

}

extension RepositoryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
			fatalError("Could not reuse RepositoryTableViewCell")
		}
		
		let repository = repositories[indexPath.row]
		cell.configure(with: repository)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let selectedRepository = repositories[indexPath.row]
		
		router?.navigateToRepositoryDetail(repository: selectedRepository)
	}
}
