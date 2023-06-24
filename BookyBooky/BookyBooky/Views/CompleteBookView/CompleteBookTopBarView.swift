//
//  TargetBookDetailHeaderView.swift
//  BookyBooky
//
//  Created by 김건우 on 2023/05/01.
//

import SwiftUI
import RealmSwift

struct CompleteBookTopBarView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isPresentingEditBookInformationSheet = false
    @State private var isPresentingDeleteConfirmationDialog = false
    @State private var isPresentingAddSentenceSheet = false
    
    // MARK: - PROPERTIES
    
    let completeBook: CompleteBook
    @Binding var scrollYOffset: CGFloat
    
    // MARK: - INTIALIZER
    
    init(_ completeBook: CompleteBook, scrollYOffset: Binding<CGFloat>) {
        self.completeBook = completeBook
        self._scrollYOffset = scrollYOffset
    }
    
    // MARK: - BODY
    
    var body: some View {
        navigationTopBar
            .sheet(isPresented: $isPresentingEditBookInformationSheet) {
                CompleteBookEditView(completeBook)
            }
            .sheet(isPresented: $isPresentingAddSentenceSheet) {
                AddSentenceSheetView(completeBook, type: .new)
            }
            .confirmationDialog("도서를 삭제하시겠습니까?", isPresented: $isPresentingDeleteConfirmationDialog, titleVisibility: .visible) {
                Button("삭제", role: .destructive) {
                    realmManager.deleteReadingBook(completeBook)
                    dismiss()
                }
            }
    }
}

// MARK: - EXTENSIONS

extension CompleteBookTopBarView {
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
        .overlay(alignment: .bottom) {
            Divider()
                .opacity(scrollYOffset > 10.0 ? 1 : 0)
        }
    }
    
    var navigationTopBarTitle: some View {
        Group {
            if scrollYOffset > 30 {
                Text(completeBook.title)
                    .frame(width: mainScreen.width * 0.65)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .navigationTitleStyle()
            } else {
                Text("도서 정보")
                    .navigationTitleStyle()
            }
        }
    }
    
    var navigationTopBarButtonGroup: some View {
        HStack {
            backButton
            
            Spacer()
            
            Menu {
                Section {
                    addSentenceButton
                    
                    Divider()
                    
                    editButton

                    deleteButton
                } header: {
                    Text("도서 편집")
                }
            } label: {
                ellipsisSFSymbolsImage
            }
        }
    }
    
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .navigationBarItemStyle()
        }
    }
    
    var editButton: some View {
        Button {
            isPresentingEditBookInformationSheet = true
        } label: {
            Label("편집", systemImage: "square.and.pencil")
        }
    }
    
    var deleteButton: some View {
        Button(role: .destructive) {
            isPresentingDeleteConfirmationDialog = true
        } label: {
            Label("삭제", systemImage: "trash")
        }
    }
    
    var addSentenceButton: some View {
        Button {
            isPresentingAddSentenceSheet = true
        } label: {
            Label("문장 추가", systemImage: "bookmark.fill")
        }
    }
    
    var ellipsisSFSymbolsImage: some View {
        Image(systemName: "ellipsis")
            .navigationBarItemStyle()
    }
}

// MARK: - PREVIEW

struct CompleteBookTopBarView_Preview: PreviewProvider {    
    static var previews: some View {
        CompleteBookTopBarView(
            CompleteBook.preview,
            scrollYOffset: .constant(0.0)
        )
        .environmentObject(RealmManager())
    }
}
