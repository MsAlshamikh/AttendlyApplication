//
//  StudentViewExec.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 20/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import PDFKit

class StudentViewExec: UIViewController {

    @IBOutlet weak var titleOf: UILabel!
    @IBOutlet weak var resonOf: UILabel!
    
    @IBOutlet weak var dateOF: UILabel!
    
    @IBOutlet weak var stateOfex: UILabel!
    @IBOutlet weak var viewSection: UILabel!
    
    @IBOutlet weak var viewExecution: UIButton!
    
    var   datePreesed: String = ""
    var  sectionName: String = ""
    var fileURL: String = ""
        //sss
    @IBAction func pressView(_ sender: UIButton) {
        let vc = ViewController()
        let pdfView = PDFView(frame: self.view.bounds)
        vc.view.addSubview(pdfView)
        pdfView.document = PDFDocument(url: URL(string: fileURL)!)
     present(vc, animated: true)
        return
    }
    
    fileprivate func extractedFunc(_ FormState: String) {
        if FormState == "Rejected" {
            stateOfex.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            stateOfex.text = FormState
        }
        else if FormState == "Accepted" {
            stateOfex.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            stateOfex.text = FormState
        }
        else if FormState == "Pending" {
            stateOfex.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            stateOfex.text = FormState
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        viewSection.text = sectionName
      //  navigationItem.title = "Absence Excuse"
        dateOF.text = datePreesed
        print("wiich is now press?? number of row",datePreesed)
        print("wiich is now press?? dateispreesed",sectionName)
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        

       Task {
          
           let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: sectionName).whereField("st", isEqualTo: datePreesed).getDocuments()
          //   let st = t_snapshot.documents.first?.data()["st"] as! String
             
        //     print("st is :" , st)
             for doc in t_snapshot.documents {
                 let documentID = doc.documentID
                 
                 let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
            
    
                 
                 for studentDoc in snp.documents {
//
                     guard let titlee = studentDoc.get("Title") as? String else { continue }
                     print("tit" , titlee)
                     
                     guard let resonn = studentDoc.get("reason") as? String else { continue }
                     guard let FormState = studentDoc.get("FormState") as? String else { continue }
                     
                     guard let file = studentDoc.get("file") as? String else { continue }
                     self.fileURL = file
                     print("reson", resonn)
                     
                     extractedFunc(FormState)
                    titleOf.text = titlee
                      resonOf.text = resonn
                    
            }
             }
         }
        
//      titleOf.text = titlee
//       reasonOf.text = reasonn

    }
    
    
    
    


}
