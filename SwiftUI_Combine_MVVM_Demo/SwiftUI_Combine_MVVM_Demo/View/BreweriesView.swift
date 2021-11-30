//
//  BreweriesView.swift
//  SwiftUI_Combine_MVVM_Demo
//
//  Created by 여정수 on 2021/11/30.
//

import Foundation
import SwiftUI

struct BreweriesView: View {

    // MARK: - Properties


    @ObservedObject var viewModel = BreweriesViewModel()
    let breweries: [Brewery] = []

    var body: some View {
        NavigationView(content: {
            List(viewModel.breweries, id: \.self) {
                BreweryView(brewery: $0)
            }.navigationBarTitle("Breweries")
            .onAppear(perform: {
                self.viewModel.fetchBreweries()
            })
        })
    }
}
