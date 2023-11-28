//
//  MealsViewModel.swift
//  DessertFetcher
//
//  Created by Thomas Garayua on 11/28/23.
//

import Foundation

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var searchQuery = ""
    
    var filteredMealsVM: [Meal] {
        guard !searchQuery.isEmpty else {
            return meals
        }
        return meals.filter { $0.strMeal.contains(searchQuery)}
    }
    
    func fetchMealsVM() {
        NetworkManager.shared.fetchMealsNM { [weak self] fetchedMeals in
            DispatchQueue.main.async {
                self?.meals = fetchedMeals ?? []
            }
        }
    }
}
