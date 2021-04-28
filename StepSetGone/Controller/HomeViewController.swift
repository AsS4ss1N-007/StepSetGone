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

class ExerciseCell: UICollectionViewCell {
    let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.setProgress(0.25, animated: true)
        progressView.trackTintColor = UIColor(red: 255/255, green: 197/255, blue: 197/255, alpha: 0.6)
        progressView.tintColor = .systemOrange
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.layer.cornerRadius = 2.5
        progressView.clipsToBounds = true
        progressView.isHidden = true
        return progressView
    }()
    let exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    fileprivate let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    fileprivate let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Heart rate"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        exerciseImageLayout()
        exerciseNameLabelLayout()
        scoreLabelLayout()
        progressBarLayout()
    }
    
    func setupGradient(color: UIColor){
        let colorOne = color
        let colorTwo = colorOne.withAlphaComponent(0.6)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.masksToBounds = true
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func exerciseImageLayout(){
        addSubview(exerciseImage)
        exerciseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        exerciseImage.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        exerciseImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exerciseImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func exerciseNameLabelLayout(){
        addSubview(exerciseNameLabel)
        exerciseNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        exerciseNameLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 10).isActive = true
        exerciseNameLabel.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: 20).isActive = true
    }
    
    private func scoreLabelLayout(){
        addSubview(scoreLabel)
        scoreLabel.leadingAnchor.constraint(equalTo: exerciseNameLabel.leadingAnchor).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func progressBarLayout(){
        addSubview(progressBar)
        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        progressBar.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    
}
