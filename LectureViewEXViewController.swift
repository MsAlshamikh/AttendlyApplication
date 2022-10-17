//
//  LectureViewEXViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 19/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import PDFKit

class LectureViewEXViewController: UIViewController {
    
    @IBOutlet weak var titleOf: UILabel!
    
    @IBOutlet weak var reasonOf: UILabel!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var accapetButton: UIButton!
    
    
    @IBOutlet weak var stateExc: UILabel!
    var sectionNmae: String = ""
    var   datePreesed: String = ""
    var  namepressed: String = ""
   
    var titlee:String = ""
    var   reasonn :String = ""
    
    var fileURL: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "View Absence Excuse"

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
    
    
    
    @IBAction func pressView(_ sender: UIButton) {
        let vc = ViewController()
        let pdfView = PDFView(frame: self.view.bounds)
        vc.view.addSubview(pdfView)
        pdfView.document = PDFDocument(url: URL(string: fileURL)!)
     present(vc, animated: true)
        return
    }
    
    
    
    @IBAction func pressRej(_ sender: UIButton) {
        
        let db = Firestore.firestore()

      Task  {
          
          guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
            //  SendBtn.isEnabled = true
              return
          }
                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("name", isEqualTo:  namepressed).getDocuments().documents.first?.documentID else {
                      return
                  }
          
          try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
             
            "FormState": "rejected"
            //  "State": ""
              
              
          ],merge: true) { err in
              if let err = err {
                  print("Error adding Lecturer  : \(err)")
              } else {
                  print("Lecturer added sucsseful ")
              }
              
          }
                  
         
          }
        
    }
    
    @IBAction func pressAccept(_ sender: UIButton) {
        // create the alert
//               let alert = UIAlertController(title: "UIAlertController", message: "Would you like to continue learning how to use iOS alerts?", preferredStyle: UIAlertController.Style.alert)
//
//               // add the actions (buttons)
//               alert.addAction(UIAlertAction(title: "yes", style: UIAlertAction.Style.default, handler: nil))
//               alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))

               // show the alert
              
        
        
        let db = Firestore.firestore()

      Task  {
          
          guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionNmae).whereField("email", isEqualTo: Global.shared.useremailshare).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
            //  SendBtn.isEnabled = true
              return
          }
                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("name", isEqualTo:  namepressed).getDocuments().documents.first?.documentID else {
                      return
                  }
          
          try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
             
            "FormState": "accepted" ,
             "State": "execues"
              
              
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
    }
    
}
