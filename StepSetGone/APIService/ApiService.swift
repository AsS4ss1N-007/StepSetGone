//
//  ApiService.swift
//  StepSetGone
//
//  Created by Sachin's Macbook Pro on 28/04/21.
//

import UIKit
class ApiService: NSObject {
    static let shared = ApiService()
    
    func getFitnessData(completionHandler: @escaping(FitnessModel) -> Void){
        guard let url = URL(string: "https://api.jsonbin.io/b/60816ce39a9aa933335504a8") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            guard let safeData = data else {return}
            DispatchQueue.main.async {
                do{
                    let jsonData = try JSONDecoder().decode(FitnessModel.self, from: safeData)
                    completionHandler(jsonData)
                }catch let jsonErr{
                    print(jsonErr.localizedDescription)
                    return
                }
            }
        }.resume()
        
    }
}
