//
//  lunchScreen.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 18/04/1444 AH.
//

import UIKit

class lunchScreen: UIViewController {
    
private let imageView : UILabel = {
       
//        let imageView = UIImageView(frame: CGRect(x:0 , y:0, width: 150 , height: 150))
        
        
        let imageView = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
     imageView.center = CGPoint(x: 100, y: 205)
      imageView.textAlignment = .center
//        let imageView = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

        imageView.text = "Attendly "
        imageView.textColor = #colorLiteral(red: 0.05053991079, green: 0.5733678937, blue: 0.6324701905, alpha: 1)
      //  imageView.
    // imageView.font = UIFont.systemFont(ofSize: 20.0)
    imageView.font = UIFont.boldSystemFont(ofSize: 49.0)
     //   imageView.font = UIFont.boldSystemFont(ofSize: 20.0)
     //   imageView.font = UIFont.italicSystemFont(ofSize: 20.0)
//    imageView.image = UIImage(named: "logow")
    
    return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
           imageView .center = CGPoint(x: 160, y: 284)
       // view.backgroundColor = .link

    }
    
    override func viewDidLayoutSubviews() {
       // imageView.center = view.center
        imageView .center = CGPoint(x: 160, y: 1000)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
                                      }
                                      
    
private func animate(){
    print("hello")
    
            UIView.animate(withDuration: 1, animations: {
        let size = self.view.frame.size.width * 2
                
        let diffx = size - self.view.frame.size.width
                
    let diffy = self.view.frame.size.height - size
               
                
                
                self.imageView.frame = CGRect (
                    x: -(diffx/2)   ,
                    y: diffy/2 ,
                    width: size  ,
                    height:  size
                        
                )
            
                
            })
    UIView.animate(withDuration: 1.5, animations: {
   // self.imageView.alpha = 0
    
    
},completion: { done in
    if done {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            
//           let viewcontoller = loginController()
//            viewcontoller.modalTransitionStyle = .crossDissolve
//            viewcontoller.modalPresentationStyle = .fullScreen
//            self.present(viewcontoller, animated: true)
            
            
            
            let Lecture = self.storyboard?.instantiateViewController(withIdentifier: "loginController") as! loginController
           
            self.navigationController?.pushViewController(Lecture, animated: true)
            
        })
        
    }
    })
    
}
        }
    

