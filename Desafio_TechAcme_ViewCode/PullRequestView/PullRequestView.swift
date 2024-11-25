//
//  PullRequestView.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation
import UIKit

class PullRequestView: UIView {
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	private func setupTableView() {
		addSubview(tableView)
		tableView.register(PullRequestTableViewCell.self, forCellReuseIdentifier: PullRequestTableViewCell.identifier)
		tableView.rowHeight = 150
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	lazy var errorMessageLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .red
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	private func setupView() {
		setupTableView()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
}
