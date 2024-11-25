//
//  RepositoryTableViewCell.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 21/11/24.
//

import Foundation
import UIKit

class RepositoryTableViewCell: UITableViewCell {
	static let identifier = "RepositoryTableViewCell"
	
	let repositoryOwnerImageView = UIImageView()
	let repositoryOwnerNameLabel = UILabel()
	
	let repositoryNameLabel = UILabel()
	let repositoryDescriptionLabel = UILabel()
	
	let repositoryStarsLabel = UILabel()
	let repositoryForksLabel = UILabel()
	let repositoryLanguageLabel = UILabel()
	
	private var imageSaveTask: URLSessionDataTask?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with repository: Repository) {
		let numFormatter = NumberFormatter()
		numFormatter.numberStyle = .decimal
		
		repositoryOwnerNameLabel.text = repository.ownerName
		repositoryNameLabel.text = repository.name
		repositoryDescriptionLabel.text = repository.description
		repositoryStarsLabel.text = "✩\(numFormatter.string(from: NSNumber(value: repository.stars)) ?? "")"
		repositoryForksLabel.text = "⑂\(numFormatter.string(from: NSNumber(value: repository.forks)) ?? "")"
		repositoryLanguageLabel.text = repository.language
		
		if let url = URL(string: repository.ownerAvatarURL) {
			loadImage(from: url)
		}
	}
	
	private func loadImage(from url: URL) {
		if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
			repositoryOwnerImageView.image = cachedImage
			return
		}
		
		imageSaveTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self,
					let data = data,
					let image = UIImage(data: data),
					error == nil
			else { return }
			
			ImageCache.shared.saveImage(image, forKey: url.absoluteString)
			
			DispatchQueue.main.async {
				self.repositoryOwnerImageView.image = image
			}
		}
		imageSaveTask?.resume()
	}
	
	private func setUI() {
		contentView.addSubview(repositoryOwnerImageView)
		contentView.addSubview(repositoryOwnerNameLabel)
		repositoryOwnerNameLabel.textColor = .secondaryLabel
		repositoryOwnerImageView.translatesAutoresizingMaskIntoConstraints = false
		repositoryOwnerNameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(repositoryNameLabel)
		repositoryNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		contentView.addSubview(repositoryDescriptionLabel)
		repositoryDescriptionLabel.lineBreakMode = .byWordWrapping
		repositoryDescriptionLabel.numberOfLines = 3
		repositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
		repositoryDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(repositoryStarsLabel)
		repositoryStarsLabel.textColor = .secondaryLabel
		contentView.addSubview(repositoryForksLabel)
		repositoryForksLabel.textColor = .secondaryLabel
		contentView.addSubview(repositoryLanguageLabel)
		repositoryLanguageLabel.textColor = .secondaryLabel
		repositoryStarsLabel.translatesAutoresizingMaskIntoConstraints = false
		repositoryForksLabel.translatesAutoresizingMaskIntoConstraints = false
		repositoryLanguageLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			repositoryOwnerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			repositoryOwnerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			repositoryOwnerImageView.widthAnchor.constraint(equalToConstant: 25),
			repositoryOwnerImageView.heightAnchor.constraint(equalToConstant: 25),
			
			repositoryOwnerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			repositoryOwnerNameLabel.leadingAnchor.constraint(equalTo: repositoryOwnerImageView.trailingAnchor, constant: 10),
			
			repositoryNameLabel.topAnchor.constraint(equalTo: repositoryOwnerNameLabel.bottomAnchor, constant: 5),
			repositoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			
			repositoryDescriptionLabel.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 5),
			repositoryDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			repositoryDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			repositoryDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
			
			repositoryStarsLabel.topAnchor.constraint(equalTo: repositoryDescriptionLabel.bottomAnchor, constant: 5),
			repositoryStarsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			
			repositoryForksLabel.topAnchor.constraint(equalTo: repositoryDescriptionLabel.bottomAnchor, constant: 5),
			repositoryForksLabel.leadingAnchor.constraint(equalTo: repositoryStarsLabel.trailingAnchor, constant: 5),
			
			repositoryLanguageLabel.topAnchor.constraint(equalTo: repositoryDescriptionLabel.bottomAnchor, constant: 5),
			repositoryLanguageLabel.leadingAnchor.constraint(equalTo: repositoryForksLabel.trailingAnchor, constant: 5)
		])
	}
	
}
