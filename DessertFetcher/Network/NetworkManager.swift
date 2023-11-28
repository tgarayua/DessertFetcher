//
//  NetworkManager.swift
//  DessertFetcher
//
//  Created by Thomas Garayua on 11/28/23.
//

import Foundation

class NetworkManager {
    private let mealsAPIUrl = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealDetailBaseUrl = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMealsNM(completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: mealsAPIUrl) else {
            print("Error finding mealsAPIUrl.")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching meals in URLSession: ", error.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let mealResponse = try? decoder.decode(MealResponse.self, from: data)
                    if let meals = mealResponse?.meals {
                        print("Meals are in Network response: \(meals.count)")
                        completion(meals)
                    } else {
                        print("No meals found in response.")
                        completion(nil)
                    }
                }
            }
            
        }.resume()
    }
    
    func fetchMealDetailsNM(with mealID: String, completion: @escaping (MealDetail?) -> Void) {
        let mealDetailAPIUrl = mealDetailBaseUrl + mealID
        
        guard let url = URL(string: mealDetailAPIUrl) else {
            print("Error unable to find mealDetailAPIUrl.")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching meal details in URLSession: ", error.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let mealDetailsResponse = try decoder.decode(MealDetailResponse.self, from: data)
                    if let mealDetails = mealDetailsResponse.meals.first {
                        print("Meal Detail Count: \(mealDetails)")
                        completion(mealDetails)
                    } else {
                        print("Unable to unwrap mealDetails")
                    }
                } catch {
                    print("Unable to fetch mealDetails in Do/Catch: ", error.localizedDescription)
                    completion(nil)
                }
            }
            
        }.resume()
    }
}
