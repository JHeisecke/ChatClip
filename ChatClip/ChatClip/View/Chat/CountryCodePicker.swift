//
//  CountryCodePicker.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2025-11-20.
//

import SwiftUI

struct CountryCodePicker: View {
    let countries: [CountryPhone]
    @Binding var selectedCountryCode: String
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""

    var filteredCountries: [CountryPhone] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
                    || $0.dialCode.contains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if !searchText.isEmpty {
                    Button {
                        selectedCountryCode = searchText
                        dismiss()
                    } label: {
                        HStack {
                            Text(searchText)
                            Spacer()
                            Text("Use this code")
                                .foregroundStyle(Color.tealGreenDark)
                        }
                    }
                    .foregroundStyle(Color.primaryBackground)
                }

                ForEach(filteredCountries, id: \.code) { country in
                    Button {
                        selectedCountryCode = country.dialCode
                        dismiss()
                    } label: {
                        HStack {
                            Text(country.emoji)
                            Text(country.name)
                            Spacer()
                            Text(country.dialCode)
                                .foregroundStyle(Color.tealGreenDark)
                        }
                    }
                    .foregroundStyle(Color.primaryBackground)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
