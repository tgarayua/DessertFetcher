//
//  ContentView.swift
//  DessertFetcher
//
//  Created by Thomas Garayua on 11/28/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                    .padding(.vertical, -7.7)
                List(viewModel.filteredMealsVM, id: \.idMeal) { meal in
                    VStack{
                        NavigationLink(destination: MealDetailView(meal: meal)) {
                            MealCardView(meal: meal)
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                viewModel.fetchMealsVM()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
