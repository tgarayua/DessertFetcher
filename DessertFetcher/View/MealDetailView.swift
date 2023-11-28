//
//  MealDetailView.swift
//  DessertFetcher
//
//  Created by Thomas Garayua on 11/28/23.
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    @State private var mealDetail: MealDetail?
    
    var body: some View {
        ScrollView {
            VStack {
                MealCardView(meal: meal)
                if let mealDetail = mealDetail {
                    Text("Instructions:")
                        .font(.headline)
                        .padding()

                    Text(mealDetail.strInstructions ?? "Not Available")
                        .padding()

                    // Display unique ingredients and measurements
                    
                    ZStack {
                        HStack(alignment: .center) {
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Ingredients:")
                                    .font(.headline)
                                    .padding()
                                
                                ForEach(1...20, id: \.self) { index in
                                    Text(mealDetail["strIngredient\(index)"] ?? "")
                                }
                            }
                            Spacer()
                            
                            VStack(alignment: .center) {
                                Text("Measurement:")
                                    .font(.headline)
                                    .padding()
                                
                                ForEach(1...20, id: \.self) { index in
                                    Text(mealDetail["strMeasure\(index)"] ?? "")
                                }
                            }
                            Spacer()
                        }
                    }
                    
//                    Text("\(mealDetail.strIngredient1 ?? "N/A") : \(mealDetail.strMeasure1 ?? "N/A")")
//                    Text("\(mealDetail.strIngredient2 ?? "N/A") : \(mealDetail.strMeasure2 ?? "N/A")")
//                    Text("\(mealDetail.strIngredient3 ?? "N/A") : \(mealDetail.strMeasure3 ?? "N/A")")
//                    Text("\(mealDetail.strIngredient4 ?? "N/A") : \(mealDetail.strMeasure4 ?? "N/A")")
//                    Text("\(mealDetail.strIngredient5 ?? "N/A") : \(mealDetail.strMeasure5 ?? "N/A")")
//                    Text("\(mealDetail.strIngredient6 ?? "N/A") : \(mealDetail.strMeasure6 ?? "N/A")")
//                    Text("\(mealDetail.strIngredient7 ?? "N/A") : \(mealDetail.strMeasure7 ?? "N/A")")
                    
                } else {
                    ProgressView("Error loading Details...")
                }
            }
        }
        .onAppear {
            NetworkManager.shared.fetchMealDetailsNM(with: meal.idMeal) {  fetchedMealDetails in
                DispatchQueue.main.async {
                    self.mealDetail = fetchedMealDetails
                }
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: Meal(strMeal: "Strawberry Rhubarb Pie", strMealThumb: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg", idMeal: "53005"))
    }
}
