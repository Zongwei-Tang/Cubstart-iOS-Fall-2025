//
//  ContentView.swift
//  ClassPlanner
//
//  Created by Justin Wong on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentingAddClassSheet = false
    @State private var isPresentingThemeColorSheet = false
    @State private var isInEditMode = false
    @State var ViewModel: viewModel = viewModel(yearPlans: CPSampleData.yearPlans, themeColor: Color.blue)
    
    var body: some View {
        NavigationStack {
            VStack {
                yearTimelineView
                
                TabView(selection: $ViewModel.currentYearPlanIndex,
                        content:  {
                    ForEach(Array(ViewModel.sortedYearPlans.enumerated()), id: \.offset) { index, yearPlan in
                        SemesterListView(yearPlan: yearPlan, isInEditMode: isInEditMode)
                            .tag(index)
                            .environment(ViewModel)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                })
                .padding()
                .tabViewStyle(.page)
            }
            .navigationTitle("My Plan")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresentingAddClassSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .bold()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isInEditMode.toggle()
                        }
                    }) {
                        Text(isInEditMode ? "Done" : "Edit")
                            .bold()
                    }
                    Button(action: {
                        isPresentingThemeColorSheet.toggle()
                    }) {
                        Circle()
                            .fill(ViewModel.themeColor.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .fill(ViewModel.themeColor)
                                    .frame(width: 30, height: 30)
                            )
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingThemeColorSheet) {
                ThemeColorPaletteView(ViewModel: $ViewModel)
            }
            .sheet(isPresented: $isPresentingAddClassSheet) {
                AddClassView(yearPlans: ViewModel.yearPlans)
            }
            .tint(ViewModel.themeColor)
        }
    }
    
    private var yearTimelineView: some View {
        HStack {
            yearTimelineLeftButton
            
            Spacer()
            Text(ViewModel.currentYearString)
                .font(.system(size: 35))
                .fontWeight(.heavy)
                .contentTransition(.numericText(value: Double(ViewModel.currentYearString)!))
            Spacer()
            
            yearTimelineRightButton
        }
        .padding()
    }
    
    private var yearTimelineLeftButton: some View {
        Button(action: {
            withAnimation {
                ViewModel.yearlineleftbutton()
            }
        }) {
            if ViewModel.currentYearPlanIndex - 1 < 0 {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(Color.green)
            } else {
                Image(systemName: "chevron.left.circle.fill")
            }
        }
        .font(.system(size: 30))
    }
    
    private var yearTimelineRightButton: some View {
        Button(action: {
            withAnimation {
                ViewModel.yearlinerightbutton()
            }
        }) {
            if ViewModel.currentYearPlanIndex + 1 >= ViewModel.yearPlans.count {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(Color.green)
  
            } else {
                Image(systemName: "chevron.right.circle.fill")
            }
            
        }
        .font(.system(size: 30))
    }
}


#Preview {
    ContentView()
}
