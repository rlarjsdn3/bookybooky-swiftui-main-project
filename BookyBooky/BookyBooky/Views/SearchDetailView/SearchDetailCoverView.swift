//
//  SearchDetailCoverView.swift
//  BookyBooky
//
//  Created by 김건우 on 2023/04/03.
//

import SwiftUI

struct SearchDetailCoverView: View {
    // MARK: - WRAPPER PROPERTIES
    
    @EnvironmentObject var bookViewModel: BookViewModel
    
    // MARK: - PROERTIES
    
    var bookInfo: BookDetail.Item
    @Binding var isbn13: String
    
    // MARK: - BODY
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(.gray.gradient)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                isbn13 = ""
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding()
                
                AsyncImage(url: URL(string: bookInfo.cover)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                        )
                } placeholder: {
                    // 로딩 이미지 추가
                }
                
            }
            .frame(height: 230)
    }
}

struct SearchDetailCoverView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailCoverView(bookInfo: BookDetail.Item.preview[0], isbn13: .constant("9788994492049"))
            .environmentObject(BookViewModel())
    }
}
