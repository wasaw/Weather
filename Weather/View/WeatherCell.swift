//
//  WeatherCell.swift
//  Weather
//
//  Created by Александр Меренков on 9/28/21.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    static let identifire = "WeatherCell"
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Optima Regular", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(informationLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        informationLabel.frame = CGRect(x: 0, y: 10, width: contentView.frame.width, height: 30)
    }
    
}
