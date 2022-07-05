//
//  CitiesListTableViewCell.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import UIKit
import Kingfisher

// MARK: - ViewModel
extension CitiesListTableViewCell {
    struct ViewModel {
        let cityImageURL: URL?
        let cityName: String
        let placeHolderImage: UIImage?
        
        init(city: City, imageURLString: String) {
            self.cityImageURL = URL(string: imageURLString)
            self.cityName = city.name
            self.placeHolderImage = UIImage(named: "placeholder")
        }
    }
}

// MARK: - Cell declaration
final class CitiesListTableViewCell: UITableViewCell {
    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    
    var vmodel: ViewModel? {
        didSet {
            guard let vm = vmodel else { return }
            configure(with: vm)
        }
    }
    
    static let identifier: String = "CitiesListTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "CitiesListTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - Private
private extension CitiesListTableViewCell {
    
    func configureUI() {
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = 10
    }
    
    func configure(with vmodel: ViewModel) {
        cityLabel.text = vmodel.cityName
        cityImageView.kf.cancelDownloadTask()
        cityImageView.kf.setImage(with: vmodel.cityImageURL, placeholder: vmodel.placeHolderImage)
    }
}
