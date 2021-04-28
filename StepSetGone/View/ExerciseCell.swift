//
//  ExerciseCell.swift
//  StepSetGone
//
//  Created by Sachin's Macbook Pro on 29/04/21.
//

import UIKit
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
    
    let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Loading"
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-BoldItalic", size: 28)
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

