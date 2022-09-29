//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore
class SectionsVC: UIViewController {
   var Sectionss: String = ""
   var coursess: String = ""
   func get(){
           let db = Firestore.firestore()
           db.collection("classes").whereField("LecturerEmail", isEqualTo: Global.shared.useremailshare ).getDocuments{
               (snapshot, error) in
               if let error = error {
                   print("FAIL ")
               }
               else{
                   print("SUCCESS")
                   let actual = snapshot!.documents.first!.get("coursess") as! [String]
                   print(actual)
                   for i in 0..<actual.count {

                       let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                       label.setTitle(actual[i], for: .normal)
                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                       label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                       label.layer.cornerRadius = 0.07 * label.bounds.size.width
                       self.view.addSubview(label)
                   }
                   //Vstack
                   // coursesT.text = actual
                   //     print((actual).count)
               }
           }

       }

   override func viewDidLoad() {
       super.viewDidLoad()
       get()
       // Do any additional setup after loading the view.

   }


}
