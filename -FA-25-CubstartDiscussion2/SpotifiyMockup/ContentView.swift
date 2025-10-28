//
//  ContentView.swift
//  discussion3
//
//  Created by Dylan Chhum on 7/26/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            albumView()
                
            
            BlurView(style: .systemMaterialDark)
                .ignoresSafeArea(.all)
//           
            VStack {
                extraView()
                albumView()
                titleView()
                timeView()
                playbackView()
            }
        }
    }
     
}

// Do not worry about this
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}


struct titleView: View {
    var body: some View {
        HStack{
            Image(systemName: "plus.circle")
                .foregroundColor(.white)
                .offset(x: 250)
                .frame(width: 10, height: 20)
            VStack{
                Text("Espresso")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Sabrina Carpenter")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .offset(x: -140, y: 0)
        }
    }
}

struct timeView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(height:10)
                    .foregroundColor(.white)
                    .padding([.trailing], 370)
                Rectangle()
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .frame(height: 5)
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(.white)
                    .opacity(0.3)
            }
            
            HStack {
                Text("0:00")
                    .opacity(0.6)
                    .foregroundColor(.white)
                Spacer()
                Text("-2:53")
                    .opacity(0.6)
                    .foregroundColor(.white)
            }
            .padding([.trailing, .leading], 10)
        }
    }
}

struct playbackView: View {
    var body: some View {
        VStack(alignment: .center){
            HStack {
                Image(systemName: "shuffle")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "backward.end.fill")
                    .foregroundColor(.white)
                Image(systemName: "play.circle")
                    .font(.title)
                    .foregroundColor(.white)
                Image(systemName: "forward.end.fill")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "repeat")
                    .foregroundColor(.white)
            }
            HStack {
                Spacer()
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.white)
            }
            .padding(15)
        }
    }
}

struct albumView : View {
    var body: some View {
        Image("Espresso")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .cornerRadius(50)
    }
}

struct extraView : View {
    var body: some View {
        VStack {
            Image(systemName: "chevron.down")
                .offset(x: -170)
                .foregroundColor(.white)
            Image(systemName: "ellipsis")
                .foregroundColor(.white)
                .offset(x: 170)
        }
    }
}

#Preview {
    ContentView()
}
