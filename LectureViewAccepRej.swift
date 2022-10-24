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
    override func viewDidLoad() {
        
        nameOf.text = namepressed
        dateOf.text = datePreesed
        super.viewDidLoad()
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
    

}
