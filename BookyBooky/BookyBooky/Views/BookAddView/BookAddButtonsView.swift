//
//  BookAddButtonsView.swift
//  BookyBooky
//
//  Created by 김건우 on 2023/04/17.
//

import SwiftUI

struct BookAddButtonsView: View {
    
    let bookInfoItem: BookInfo.Item
    @Environment(\.dismiss) var dismiss
    
    @State private var isPresentingDateDescSheet = false
    @State private var isPresentingConfirmDialog = false
    
    var body: some View {
        VStack {
            howToCalculateTimeButton
            
            bottomButtons
        }
        .confirmationDialog("목표 도서에 추가하시겠습니까?", isPresented: $isPresentingConfirmDialog, titleVisibility: .visible) {
            Button("확인") {
                // do something...
            }
            
            Button("취소", role: .destructive) {
                // nothing to do...
            }
        }
        .sheet(isPresented: $isPresentingDateDescSheet) {
            DateDescSheetView(bookInfo: bookInfoItem)
        }
    }
}

extension BookAddButtonsView {
    var howToCalculateTimeButton: some View {
        Button {
            isPresentingDateDescSheet = true
        } label: {
            Text("날짜 계산은 어떻게 하나요?")
                .font(.caption)
        }
        .padding(.top, 10)
    }
    
    var bottomButtons: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                backLabel
            }
            
            Button {
                isPresentingConfirmDialog = true
            } label: {
                addLabel
            }
        }
        .padding(.horizontal)
    }
    
    var backLabel: some View {
        Text("돌아가기")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.2))
            .cornerRadius(15)
    }
    
    var addLabel: some View {
        Text("추가하기")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(bookInfoItem.categoryName.refinedCategory.accentColor)
            .cornerRadius(15)
    }
}

struct BookAddButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        BookAddButtonsView(bookInfoItem: BookInfo.Item.preview[0])
    }
}