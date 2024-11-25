//
//  RepositoryView.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation
import UIKit

class RepositoryView: UIView {
	
	// MARK: - TableView
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		return tableView
	}()
	private func setupTableView() {
		addSubview(tableView)
		tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
		tableView.rowHeight = 150
//		tableView.rowHeight = UITableView.automaticDimension
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	// MARK: - ErrorLabel
	lazy var errorMessageLabel: UILabel = {
		let label = UILabel()
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = nil
		
		return label
	}()
	
	// MARK: - SetupView
	private func setupView() {
		setupTableView()
	}
	
	// MARK: - Inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
}
