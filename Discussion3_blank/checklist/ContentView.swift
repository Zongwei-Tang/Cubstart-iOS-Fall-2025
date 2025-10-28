//
//  ContentView.swift
//  checklist
//
//  Created by Andy Huang on 7/16/23.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: ViewModel = ViewModel()
    var body: some View {
        HeaderView(viewModel: viewModel)
        ChecklistView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ContentView()
        }
    }
}

struct HeaderView: View {
    @Bindable var viewModel: ViewModel
    var body: some View {
        VStack{
            HStack{
                Image("milr969373561")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                Text("Zongwei Tang")
                    .bold()
                    .font(.system(size: 26))
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            HStack{
                TextField("Enter description", text: $viewModel.description)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .padding(.horizontal, 10)
                Button(action: {
                    viewModel.add()
                }) {
                    Text("Add")
                }
                    .buttonStyle(.bordered)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }
}

struct ChecklistView: View {
    @Bindable var viewModel: ViewModel
    var body: some View {
        List{
            Section{
                ForEach(viewModel.doing, id: \.self){item in
                    Button(action: {
                        viewModel.swapToC(task: item)
                    }){
                        Text("\(item)")
                    }
                }
            } header: {
                Text("In Progress Tasks")
            }
            Section {
                ForEach(viewModel.completed, id: \.self){item in
                    Button(action:{
                        viewModel.swapInPro(task: item)
                    }){HStack{
                        Image(systemName: "checkmark.circle")
                        Text("\(item)")
                    }}}
            } header: {
                Text("Completed Tasks")
            }
        }
    }
}
