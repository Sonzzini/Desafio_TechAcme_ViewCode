//
//  PullRequestViewController.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation
import UIKit

class PullRequestViewController: UIViewController, PullRequestDisplayer {
	
	init(repository: Repository) {
		self.repository = repository
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable, message: "Use init(repository:) instead")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var pullRequestInteractor: BusinessPullRequest?
	var repository: Repository
	var isLoading: Bool = false
	var errorMessage: String? = nil
	
	var pullRequests: [PullRequest] = []
	
	lazy var pullRequestView = PullRequestView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))

	override func viewDidLoad() {
		super.viewDidLoad()
		//
		self.title = repository.name
		
		fetchPullRequests()
		setElements()
		
		pullRequestView.tableView.dataSource = self
		pullRequestView.tableView.delegate = self
	}
	
	func fetchPullRequests() {
		let request = PullRequestWebAccess.Request(owner: repository.ownerName,
																 repository: repository.name,
																 state: "closed")
		
		pullRequestInteractor?.startFetchingPullRequests(request: request)
	}
	
	func displayPullRequests() {
		DispatchQueue.main.async {
			self.pullRequestView.tableView.reloadData()
		}
	}
	
	func setElements() {
		view.addSubview(pullRequestView)
	}
}

extension PullRequestViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pullRequests.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestTableViewCell.identifier, for: indexPath) as? PullRequestTableViewCell else {
			fatalError("Could not reuse PullRequestTableViewCell")
		}
		
		let pullRequest = pullRequests[indexPath.row]
		cell.configure(with: pullRequest)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		_ = pullRequests[indexPath.row]
	}
}
