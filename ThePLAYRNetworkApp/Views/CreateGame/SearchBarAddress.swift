//
//  SwiftUIView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/6/23.
//

import SwiftUI

struct SearchBarAddress: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBarAddress.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBarAddress>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Ex. Courts"
        searchBar.searchTextField.clearButtonMode = .never
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarAddress>) {
        uiView.text = text
    }
}
