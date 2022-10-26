//
//  Extensions.swift
//  AttendlyApplication
//
//  Created by Modhy Abduallh on 01/04/1444 AH.
//

import SwiftUI
extension View {
    
    func convertToScrollView<Content: View>(@ViewBuilder content: @escaping()->Content)->UIScrollView{
        
        let scrollView = UIScrollView()
        
        //
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        //
        let constraints = [
        
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            //
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
        
        scrollView.addSubview(hostingController)
        scrollView.addConstraint(constraints)
        
        return scrollView
        
    }
    
    func screenBounds()->CGRect{
        return UIScreen.main.bounds
    }
}
