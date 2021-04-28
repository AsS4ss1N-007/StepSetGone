//
//  ViewController.swift
//  StepSetGone
//
//  Created by Sachin's Macbook Pro on 28/04/21.
//

import UIKit

class HomeViewController: UIViewController {
    var exercisesScore: FitnessModel?
    fileprivate let greatDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Have a great day ahead"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    fileprivate let walkHeartCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.register(ExerciseCell.self, forCellWithReuseIdentifier: "Heart")
        return cv
    }()
    
    fileprivate let sleepTrainCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.register(ExerciseCell.self, forCellWithReuseIdentifier: "Sleep")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI(){
        fetchFitnessData()
        setupNavigationBar()
        greatDayLabelLayout()
        walkHeartCVLayout()
        sleepTrainCVLayout()
        setupDelegates()
    }
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Good Morning, Yash"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupDelegates(){
        sleepTrainCV.delegate = self
        sleepTrainCV.dataSource = self
        walkHeartCV.delegate = self
        walkHeartCV.dataSource = self
    }
    
    private func greatDayLabelLayout(){
        view.addSubview(greatDayLabel)
        greatDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        greatDayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        greatDayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }
    
    private func walkHeartCVLayout(){
        view.addSubview(walkHeartCV)
        walkHeartCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        walkHeartCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        walkHeartCV.topAnchor.constraint(equalTo: greatDayLabel.bottomAnchor, constant: 20).isActive = true
        walkHeartCV.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
    }
    
    private func sleepTrainCVLayout(){
        view.addSubview(sleepTrainCV)
        sleepTrainCV.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2).isActive = true
        sleepTrainCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sleepTrainCV.topAnchor.constraint(equalTo: greatDayLabel.bottomAnchor, constant: 20).isActive = true
        sleepTrainCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func fetchFitnessData(){
        ApiService.shared.getFitnessData { (fitnessData) in
            self.exercisesScore = fitnessData
            self.walkHeartCV.reloadData()
            self.sleepTrainCV.reloadData()
        }
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == walkHeartCV{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Heart", for: indexPath) as! ExerciseCell
            if indexPath.item == 0{
                let color = UIColor(red: 230/255, green: 247/255, blue: 255/255, alpha: 1)
                cell.setupGradient(color: color)
                cell.exerciseImage.image = #imageLiteral(resourceName: "pedestrian-man")
                cell.exerciseNameLabel.text = "Walking Step Counter"
                cell.progressBar.isHidden = false
            }else{
                let color = UIColor(red: 255/255, green: 197/255, blue: 197/255, alpha: 1)
                cell.setupGradient(color: color)
                cell.exerciseImage.image = #imageLiteral(resourceName: "heart")
                cell.exerciseNameLabel.text = "Heart Rate"
                if let heartRate = exercisesScore?.data.heartRate{
                    cell.scoreLabel.text = heartRate
                }
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sleep", for: indexPath) as! ExerciseCell
            if indexPath.item == 0{
                let color = UIColor(red: 185/255, green: 197/255, blue: 255/255, alpha: 1)
                cell.setupGradient(color: color)
                cell.exerciseImage.image = #imageLiteral(resourceName: "moon")
                cell.exerciseNameLabel.text = "Sleeping time"
                if let sleepTime = exercisesScore?.data.sleepTime{
                    cell.scoreLabel.text = "\(sleepTime) Hours"
                }
            }else{
                let color = UIColor(red: 152/255, green: 253/255, blue: 187/255, alpha: 1)
                cell.setupGradient(color: color)
                cell.exerciseImage.image = #imageLiteral(resourceName: "clock")
                cell.exerciseNameLabel.text = "Training time"
                if let trainingTime = exercisesScore?.data.trainingTime{
                    cell.scoreLabel.text = trainingTime
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == walkHeartCV{
            if indexPath.item == 0{
                return CGSize(width: self.walkHeartCV.frame.size.width - 8, height: 300)
            }else{
                return CGSize(width: self.walkHeartCV.frame.size.width - 8, height: 250)
            }
        }else{
            return CGSize(width: self.sleepTrainCV.frame.size.width - 8, height: 240)
        }
    }
}
