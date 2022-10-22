//
//  LectureViewEXViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 19/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import PDFKit
import UserNotifications //##

class LectureViewEXViewController: UIViewController {
    
    @IBOutlet weak var nameOf: UILabel!
    
    //    @IBOutlet weak var titleOf: UILabel!
//
//    @IBOutlet weak var reasonOf: UILabel!
//
//    @IBOutlet weak var rejectButton: UIButton!
//
//    @IBOutlet weak var accapetButton: UIButton!
//
//
//    @IBOutlet weak var stateExc: UILabel!
    
    @IBOutlet weak var reasonOf: UILabel!
    @IBOutlet weak var dateOF: UILabel!
    
    @IBOutlet weak var stateExc: UILabel!
    @IBOutlet weak var accapetButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var titleOf: UILabel!
    
    var fileURL: String = ""
    var sectionNmae: String = ""
    var   datePreesed: String = ""
    var  namepressed: String = ""
   
    var titlee:String = ""
    var   reasonn :String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Absence excuse"
        nameOf.text = namepressed
        dateOF.text = datePreesed
       // self.tabBarController?.tabBar.isHidden = true
        print("sectionNmae",sectionNmae)
        print("datePreesed",sectionNmae)
        print("namepressed",namepressed)
        
     
        let db = Firestore.firestore()

       Task {
          
           let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments()
          //   let st = t_snapshot.documents.first?.data()["st"] as! String
             
        //     print("st is :" , st)
             for doc in t_snapshot.documents {
                 let documentID = doc.documentID
                 
                 let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("name", isEqualTo: namepressed).getDocuments()
            
            
                 
                 for studentDoc in snp.documents {
//
                     guard let titlee = studentDoc.get("Title") as? String else { continue }
                     print("tit" , titlee)
                     
                     guard let resonn = studentDoc.get("reason") as? String else { continue }
          
                     
                     guard let FormState = studentDoc.get("FormState") as? String else { continue }
                     
                    
                     
                     
                     guard let file = studentDoc.get("file") as? String else { continue }
                     self.fileURL = file
                     
                     titleOf.text = titlee
                      reasonOf.text = resonn
                     stateExc.text = FormState
            }
             }
         }
        
//      titleOf.text = titlee
//       reasonOf.text = reasonn

    }
    
    
    
//    @IBAction func pressView(_ sender: UIButton) {
//        let vc = ViewController()
//        let pdfView = PDFView(frame: self.view.bounds)
//        vc.view.addSubview(pdfView)
//        pdfView.document = PDFDocument(url: URL(string: fileURL)!)
//     present(vc, animated: true)
//        return
//    }
    
    @IBAction func pressView(_ sender: UIButton) {
        let vc = ViewController()
              let pdfView = PDFView(frame: self.view.bounds)
              vc.view.addSubview(pdfView)
              pdfView.document = PDFDocument(url: URL(string: fileURL)!)
           present(vc, animated: true)
              return
    }
    
    
//    @IBAction func pressRej(_ sender: UIButton) {
//
//        let db = Firestore.firestore()
//
//      Task  {
//
//          guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
//            //  SendBtn.isEnabled = true
//              return
//          }
//                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("name", isEqualTo:  namepressed).getDocuments().documents.first?.documentID else {
//                      return
//                  }
//
//          try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
//
//            "FormState": "Rejected"
//            //  "State": ""
//
//
//          ],merge: true) { err in
//              if let err = err {
//                  print("Error adding Lecturer  : \(err)")
//              } else {
//                  print("Lecturer added sucsseful ")
//              }
//
//          }
//
//
//          }
//
//    }
    
    @IBAction func pressRej(_ sender: UIButton) {
        let db = Firestore.firestore()
        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to reject the excuse?", preferredStyle: .alert)
        // Create OK button with action handler
       let ok = UIAlertAction(title: "Yes", style: .default, handler: { [self] (action) in
            print("Ok button tapped")
           
        Task {
            
            guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
              //  SendBtn.isEnabled = true
                return
            }
                  guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("name", isEqualTo:  namepressed).getDocuments().documents.first?.documentID else {
                        return
                    }
            
            try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
               
              "FormState": "Rejected"
              //  "State": ""
                
                
            ],merge: true) { err in
                if let err = err {
                    print("Error adding Lecturer  : \(err)")
                } else {
                    print("Lecturer added sucsseful ")
                }
                
            }
//            //######################
//            let center = UNUserNotificationCenter.current()
//            let content = UNMutableNotificationContent()
//            content.title = "Absence excuse answer"
//            content.body = "Sorry your absence excuse was Rejected ! "
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: false)
//            let uuid = UUID().uuidString
//            let result = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
//
//            center.add(result) {(error) in
//                //
//            }

            }
           
           let storyboard = UIStoryboard(name: "Main", bundle: .main)
           let vc = storyboard.instantiateViewController(identifier: "StudentHaveExecution") as! StudentHaveExecution
           vc.popTwice = true
           self.navigationController?.popViewController(animated: false)
//           DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//               self.navigationController?.pushViewController(vc, animated: true)
//           }
       })
       //Add OK button to a dialog message
       dialogMessage.addAction(ok)
        dialogMessage.addAction(UIAlertAction(title: "No",
                                              style: .cancel,
                                              handler: { _ in print("Cancel tap") })
        )
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    
    @IBAction func pressAccept(_ sender: UIButton) {
        
        let db = Firestore.firestore()
        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to accept the excuse?", preferredStyle: .alert)
        // Create OK button with action handler
       let ok = UIAlertAction(title: "Yes", style: .default, handler: { [self] (action) in
            print("Ok button tapped")
           
        Task{
        
                  guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
                    //  SendBtn.isEnabled = true
                      return
                  }
                        guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("name", isEqualTo:  namepressed).getDocuments().documents.first?.documentID else {
                              return
                          }
        
                  try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
        
                    "FormState": "Accepted" ,
                     "State": "excused"
        
        
                  ],merge: true) { err in
                      if let err = err {
                          print("Error adding Lecturer  : \(err)")
                      } else {
                          print("Lecturer added sucsseful ")
                      }
        
                  }
                 // self.present(alert, animated: true, completion: nil)
        
               //   self.performSegue(withIdentifier: "gotoLecturers", sender: self)
                  }
           let storyboard = UIStoryboard(name: "Main", bundle: .main)
           let vc = storyboard.instantiateViewController(identifier: "StudentHaveExecution") as! StudentHaveExecution
           vc.popTwice = true
           self.navigationController?.popViewController(animated: false)
//           DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//               self.navigationController?.pushViewController(vc, animated: true)
//           }
           //self.navigationController?.pushViewController(vc, animated: true)
       })
        
       //Add OK button to a dialog message
       dialogMessage.addAction(ok)
        dialogMessage.addAction(UIAlertAction(title: "No",
                                              style: .cancel,
                                              handler: { _ in print("Cancel tap") })
        )
        self.present(dialogMessage, animated: true, completion: nil)

    }
    
//    @IBAction func pressAccept(_ sender: UIButton) {
//
//
//
//        let db = Firestore.firestore()
//
////      Task  {
////
////          guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
////            //  SendBtn.isEnabled = true
////              return
////          }
////                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("name", isEqualTo:  namepressed).getDocuments().documents.first?.documentID else {
////                      return
////                  }
////
////          try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
////
////            "FormState": "Accepted" ,
////             "State": "excused"
////
////
////          ],merge: true) { err in
////              if let err = err {
////                  print("Error adding Lecturer  : \(err)")
////              } else {
////                  print("Lecturer added sucsseful ")
////              }
////
////          }
////         // self.present(alert, animated: true, completion: nil)
////
////       //   self.performSegue(withIdentifier: "gotoLecturers", sender: self)
////          }
//    }
    
}
