//
//  ThemeColorPaletteView.swift
//  ClassPlannerFinished
//
//  Created by Justin Wong on 2/23/24.
//

import SwiftUI

struct ThemeColorPaletteView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var ViewModel: viewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                selectedColorHeader
                colorGrid
            }
            .navigationTitle("Set Theme Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                }
            }
        }
    }
    
    private var selectedColorHeader: some View {
        HStack(spacing: 20) {
            Text("Selected Theme Color:")
                .font(.title).bold()
            RoundedRectangle(cornerRadius: 10)
                .fill(ViewModel.themeColor)
                .frame(width: 50, height: 50)
        }
    }
    
    private var colorGrid: some View {
        Grid(horizontalSpacing: 30) {
            GridRow {
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .red)
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .green)
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .blue)
            }
            GridRow {
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .purple)
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .yellow)
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .black)
            }
            GridRow {
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .brown)
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .cyan)
                ColorCircleView(selectedColor: $ViewModel.themeColor, color: .indigo)
            }
        }
    }
}

//MARK: - ColorCircleView
struct ColorCircleView: View {
    @Binding var selectedColor: Color
    var color: Color
    
    var body: some View {
        Circle()
            .fill(selectedColor == color ? .indigo.opacity(0.3) : .clear)
            .frame(width: 100, height: 100)
            .overlay(
                Circle()
                    .fill(color)
                    .frame(width: 80, height: 80)
            )
            .onTapGesture {
                selectedColor = color
            }
    }
}

