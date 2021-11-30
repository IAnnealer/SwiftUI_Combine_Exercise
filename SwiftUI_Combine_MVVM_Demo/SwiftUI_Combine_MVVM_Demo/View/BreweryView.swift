//
//  BreweryView.swift
//  SwiftUI_Combine_MVVM_Demo
//
//  Created by 여정수 on 2021/11/30.
//

import Foundation
import SwiftUI

struct BreweryView: View {

    // MARK: - Properties

    private let brewery: Brewery

    init(brewery: Brewery) {
        self.brewery = brewery
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15, content: {
                Text(brewery.name)
                    .font(.system(size: 18))
                    .foregroundColor(.blue)

                Text("\(brewery.city) - \(brewery.street)")
                    .font(.system(size: 14))
            })
        }
    }
}
