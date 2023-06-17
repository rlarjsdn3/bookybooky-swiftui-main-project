//
//  SearchHeaderView.swift
//  BookyBooky
//
//  Created by 김건우 on 2023/03/29.
//

import SwiftUI

struct SearchListTopBarView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @State private var isPresentingSearchSheetView = false
    
    // MARK: - BODY
    
    var body: some View {
        navigationTopBar
            .sheet(isPresented: $isPresentingSearchSheetView) {
                SearchSheetView()
            }
    }
}

// MARK: - EXTENSIONS

extension SearchListTopBarView {
    var navigationTopBar: some View {
        HStack {
            Spacer()
            
            navigationTopBarTitle
            
            Spacer()
        }
        .overlay {
            navigationTopBarButtonGroup
        }
        .padding(.vertical)
    }
    
    var navigationTopBarTitle: some View {
        Text("검색")
            .navigationTitleStyle()
    }
    
    var navigationTopBarButtonGroup: some View {
        HStack {
            Spacer()
            
            Button {
                isPresentingSearchSheetView = true
            } label: {
                searchSFSymbolsImage
            }
        }
    }
    
    var searchSFSymbolsImage: some View {
        Image(systemName: "magnifyingglass")
            .navigationBarItemStyle()
    }
}

// MARK: - PREVIEW

struct SearchListTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListTopBarView()
    }
}