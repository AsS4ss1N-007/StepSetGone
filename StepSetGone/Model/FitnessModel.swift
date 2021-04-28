//
//  FitnessModel.swift
//  StepSetGone
//
//  Created by Sachin's Macbook Pro on 29/04/21.
//

import UIKit
struct FitnessModel: Codable {
    let success: String
    let code: Int
    let data: FitnessModelData
}

// MARK: - DataClass
struct FitnessModelData: Codable {
    let heartRate, sleepTime, trainingTime: String
    
    enum CodingKeys: String, CodingKey {
        case heartRate = "heart-rate"
        case sleepTime = "sleep-time"
        case trainingTime = "training-time"
    }
}
