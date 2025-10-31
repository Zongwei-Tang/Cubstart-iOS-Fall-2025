//
//  ContentView.swift
//  Stickies
//
//  Created by Justin Wong on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = StickiesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ForEach(viewModel.stickies) { stickie in
                    StickieView(stickie: stickie)
                        .zIndex(stickie.zIndex)
                        .environment(viewModel)
                }
            }
            .toolbar {
                addStickieToolbarButton
            }
        }
    }
    
    private var addStickieToolbarButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                withAnimation {
                    viewModel.createStickie()
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.gray)
                    .font(.system(size: 30))
            }
        }
    }
}


// MARK: - StickieView

struct StickieView: View {
    @Environment(StickiesViewModel.self) private var viewModel
    
    var stickie: Stickie
    
    @State private var text = ""
    @State private var position: CGSize = .zero
    @State private var dragOffset: CGSize = .zero
    @State private var isHolding = false
    
    var body: some View {
        mainView
            .shadow(color: .gray.opacity(0.5), radius: 10)
            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        viewModel.changeStickieZIndex(for: stickie)
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        position.width += value.translation.width
                        position.height += value.translation.height
                        dragOffset = .zero
                    }
            )
    }
    
    private var mainView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.yellow)
                .frame(width: 150, height: 150)
                .scaleEffect(isHolding ? 1.2 : 1)
                .overlay(
                    VStack {
                        TextField("Type Here", text: $text)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
                )
            // TODO: Add onLongPressGesture view modifier here. We want to "expand" the view with animation and change the current holding stickie's zIndex
            .onLongPressGesture(
                minimumDuration: 0.5,
                maximumDistance: 50
            ) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isHolding.toggle()
                    if isHolding {
                        viewModel.changeStickieZIndex(for: stickie)
                    }
                }
            }
        
            headerView
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                deleteButton
                Spacer()
            }
            .padding(7)
            Spacer()
        }
        .frame(width: 150, height: 150)
    }
    
    private var deleteButton: some View {
        Button(action: {
            viewModel.removeStickie(for: stickie)
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.regularMaterial)
        }
        .opacity(isHolding ? 0 : 1)
        .disabled(isHolding)
    }
}

#Preview {
    let viewModel = StickiesViewModel()
    viewModel.createStickie()
    viewModel.createStickie()
    
    return ContentView()
        .environment(viewModel)
}
