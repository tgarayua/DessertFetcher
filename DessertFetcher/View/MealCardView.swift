//
//  MealCardView.swift
//  DessertFetcher
//
//  Created by Thomas Garayua on 11/28/23.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .clipped()
                        .cornerRadius(30)
                        .shadow(radius: 10)
                case .empty:
                    ProgressView("Loading...")
                case .failure(_):
                    Image(systemName: "photo")
                        .frame(width: 300, height: 300)
                    Text("Failed to load image")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                @unknown default:
                    ProgressView("Error...")
                }
            }
            Text(meal.strMeal)
                .font(Font.custom("Baskerville-Bold", size: 26))
        }
    }
}

struct MealCardView_Previews: PreviewProvider {
    static var previews: some View {
        MealCardView(meal: Meal(strMeal: "Strawberry Rhubarb Pie", strMealThumb: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg", idMeal: "53005"))
    }
}
