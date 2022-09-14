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
           db.collection("classes").whereField("StudentEmail", isEqualTo: "123@student.ksu.edu.sa").getDocuments{
               (snapshot, error) in
               if let error = error {
                   print("FAIL ")
               }
               else{
                   print("SUCCESS")
                   let actual = snapshot!.documents.first!.get("coursess") as! [String]
                   //let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
                   print(actual)
                   for i in 0..<actual.count {

                       let label = UIButton(frame: .init(x: self.view.frame.midX-120 , y: 200 + ( Double(i) * 70 ), width: 250, height: 50))
                       label.setTitle(actual[i], for: .normal)
                       label.setTitleColor(UIColor(red: 55/255, green: 84/255, blue: 151/255, alpha: 2), for: .normal)
                       label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                       //label.params["course"] = actual[i]
                       //!!!!!!
                       //label.tag = Int(sects[i]) ?? 0

                       //label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
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
