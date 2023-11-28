//
//  SearchBar.swift
//  DessertFetcher
//
//  Created by Thomas Garayua on 11/28/23.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    // Coordinator class to handle search bar delegate methods
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        // Initialize the coordinator with the binding
        init(text: Binding<String>) {
            _text = text
        }

        // Called when the search bar text changes
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText // Update the binding with the new search text
        }

        // Called when the search bar text field begins editing
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true // Show the cancel button
            searchBar.placeholder = "" // Remove the placeholder text
        }

        // Called when the search bar text field ends editing
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false // Hide the cancel button
            searchBar.placeholder = "Search" // Set the placeholder text to "Search"
        }

        // Called when the cancel button is clicked
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = "" // Clear the search bar text
            searchBar.showsCancelButton = false // Hide the cancel button
            searchBar.endEditing(true) // End editing of the search bar
        }
    }

    // Create and return a coordinator instance
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    // Create and return the underlying UISearchBar
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator // Set the coordinator as the search bar's delegate
        searchBar.placeholder = "Search" // Set the initial placeholder text
        return searchBar
    }

    // Update the search bar's text when the binding value changes
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}


