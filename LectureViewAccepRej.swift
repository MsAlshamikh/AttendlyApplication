//
//  LectureViewAccepRej.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 21/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import PDFKit

class LectureViewAccepRej: UIViewController {

//    @IBOutlet weak var stateEXec: UILabel!
//
//   @IBOutlet weak var resonOf: UILabel!
//    @IBOutlet weak var titleoF: UILabel!
//
//    @IBOutlet weak var viewFile: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var acceptbutton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var nameOf: UILabel!
    @IBOutlet weak var dateOf: UILabel!
    
    @IBOutlet weak var viewFile: UIButton!
    
    @IBOutlet weak var titleoF: UILabel!
    @IBOutlet weak var stateEXec: UILabel!
    
    @IBOutlet weak var resonOf: UILabel!
    var sectionNmae: String = ""
    var   datePreesed: String = ""
    var  namepressed: String = ""
    
    var fileURL: String = ""
    var FormStatetake: String = ""
   //   let FormState = ""
    override func viewDidLoad() {
        
        nameOf.text = namepressed
        dateOf.text = datePreesed
        super.viewDidLoad()
        acceptbutton.isHidden = true
        rejectButton.isHidden = true
        
        navigationItem.title = "Absence excuse"
        print("sectionNmae",sectionNmae)
        print("datePreesed",sectionNmae)
        print("namepressed",namepressed)
        
        let db = Firestore.firestore()
      Task  {
           
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
                      FormStatetake = FormState
                     
                      
                      
                      guard let file = studentDoc.get("file") as? String else { continue }
                      self.fileURL = file
                      
                   titleoF.text = titlee
                      resonOf.text = resonn
                      if FormState == "Rejected" {
                          stateEXec.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                          stateEXec.text = FormState
                      }
                      else if FormState == "Accepted" {
                          stateEXec.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                          stateEXec.text = FormState
                      }
                     // stateEXec.text = FormState
             }
              }
          }
    }
    
    
//    @IBAction func pressViewfile(_ sender: UIButton) {
//        let vc = ViewController()
//        let pdfView = PDFView(frame: self.view.bounds)
//        vc.view.addSubview(pdfView)
//        pdfView.document = PDFDocument(url: URL(string: fileURL)!)
//     present(vc, animated: true)
//        return
//    }
    
    @IBAction func pressViewfile(_ sender: UIButton) {
        let vc = ViewController()
               let pdfView = PDFView(frame: self.view.bounds)
               vc.view.addSubview(pdfView)
               pdfView.document = PDFDocument(url: URL(string: fileURL)!)
            present(vc, animated: true)
               return
        
    }
    
    @IBAction func pressEditbutton(_ sender: UIButton) {
        print(FormStatetake)
        if (FormStatetake == "Rejected" ){
            acceptbutton.isHidden = false

        }
        else if (FormStatetake == "Accepted"){
            rejectButton.isHidden = false
        }
        
    }
    
    @IBAction func rejectpressed(_ sender: UIButton) {
        
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
    
    
    
    
    @IBAction func acceptpressed(_ sender: Any) {
        
        
            
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
    
    
}
