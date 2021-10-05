//
//  ViewController.swift
//  Weather
//
//  Created by Александр Меренков on 9/27/21.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    private let insents = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private var currentData = [Current]()
    private var localData = [Location]()
    private let temperatureLabel = View().temperatureLabel
    private let conditionLabel = View().conditionLabel
    private let dayLabel = View().dayLabel
    private let imageView = View().imageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.localData = Request().locationData
            self.currentData = Request().currentData
            if self.localData.count != 0 && self.currentData.count != 0 {
                self.addLoadInformation()
                self.fetchImage()
                self.collectionView.reloadData()
            }
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifire)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(temperatureLabel)
        view.addSubview(conditionLabel)
        view.addSubview(dayLabel)
        view.addSubview(imageView)
        
        setConstraint()
        
        let choiceColor = checkTime()
        print(choiceColor)
        setBackground(choiceColor: choiceColor)
    }
    
    func setConstraint() {
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width / 2 - 120).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        conditionLabel.leftAnchor.constraint(equalTo: temperatureLabel.leftAnchor).isActive = true
        conditionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        conditionLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        
        dayLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: view.bounds.width / 3).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -5).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.bounds.width / 3 - 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addLoadInformation() {
        temperatureLabel.text = String(currentData[0].temp_c) + "º"
        conditionLabel.text = String(currentData[0].condition.text)
        dayLabel.text = localData[0].name
    }
    
    func fetchImage() {
        let myUrl = "http:" + currentData[0].condition.icon
        
        guard let url = URL(string: myUrl) else { return }
        let getDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
        getDataTask.resume()
    }
    
    func checkTime() -> Bool {
//        print(Date().description(with: .current))
//        let localDate = Date().description(with: .current)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH"
        let localTime = dateFormater.string(from: Date())
        
        if 8 < Int(localTime) ?? 0 && Int(localTime) ?? 0 < 20 {
            return true
        }
        return false
        //        print(TimeZone.current)
    }
    
    func setBackground(choiceColor: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))

        if choiceColor {
            guard let img = UIImage(named: "Background.png") else { return }
            imageView.image = img
        } else {
            guard let img = UIImage(named: "Background2.png") else { return }
            imageView.image = img
        }
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
}

//  MARK: - extension
extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifire, for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        if checkTime() {
            cell.backgroundColor = .systemOrange
        } else {
            cell.backgroundColor = .purple
        }
        if currentData.count != 0 {
        switch indexPath.row {
        case 0:
            cell.informationLabel.text = "Wmph"
        case 1:
            cell.informationLabel.text = "Wdir"
        case 2:
            cell.informationLabel.text = "Ph"
        case 3:
            cell.informationLabel.text = "Feels"
        case 4:
            cell.informationLabel.text = String(currentData[0].wind_mph)
        case 5:
            cell.informationLabel.text = currentData[0].wind_dir
        case 6:
            cell.informationLabel.text = String(currentData[0].pressure_mb)
        case 7:
            cell.informationLabel.text = String(currentData[0].feelslike_c)
        default:
            return cell
        }
        }
        return cell
    }
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 4
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
