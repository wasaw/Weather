//
//  View.swift
//  Weather
//
//  Created by Александр Меренков on 9/28/21.
//

import UIKit

class View: UIView {
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Optima Regular", size: 80)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let conditionLabel: UILabel = {
        let label =  UILabel()
        label.font = UIFont(name: "Optima Regular", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Optima Regular", size: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
}
