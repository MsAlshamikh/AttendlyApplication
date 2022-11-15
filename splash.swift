//
//  splash.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 18/04/1444 AH.
//

import SwiftUI
import UIKit

struct splash: View {
    
    @State private var size=0.8
        @State private var opacity=0.5
        @State private var isActive :Bool=false
        var body: some View {
            if isActive{
              //  ContentView()
            }else{
                
            
              
            VStack{
            VStack{
                Image("Att").resizable().scaledToFill()
                
                    .aspectRatio(contentMode: .fit)
            } //vstack
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.1)){
                    self.size=0.9
                    self.opacity=1.00
                }
            }
        }
            
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive=true
                    }
            }
            }
        }
        }
    }

struct splash_Previews: PreviewProvider {
    static var previews: some View {
     //   print("hhhi")
        splash()
    }
}

//struct storyboardview: UIViewControllerRepresentable{
//
//
//    func makeUIViewController(content: Context) -> UIViewController{
//        let storyboard = UIStoryboard(name:"" , bundle: Bundle.main)
//        let controller = storyboard.instantiateInitialViewController(identifier: "")
//        return controller
//    }
//}

struct StoryboardViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Main")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
