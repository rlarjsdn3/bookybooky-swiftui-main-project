//
//  SearchView.swift
//  BookyBooky
//
//  Created by 김건우 on 2023/03/28.
//

import SwiftUI

struct SearchView: View {
    @State private var startOffset: CGFloat = .zero  // 스크롤 뷰의 시작점 Y 좌표값을 저장하는 변수
    @State private var scrollOffset: CGFloat = .zero // 스크롤 시 변화되는 Y 좌표값을 저장하는 변수
    
    var body: some View {
        VStack {
            SearchHeaderView()
            
            ScrollView(showsIndicators: false) {
                
            }
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
