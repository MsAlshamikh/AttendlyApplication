//
//  StudentViewExec.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 20/03/1444 AH.
//

import UIKit
import FirebaseFirestore

class StudentViewExec: UIViewController {

    @IBOutlet weak var titleOf: UILabel!
    @IBOutlet weak var resonOf: UILabel!
    
    
    
    var   datePreesed: String = ""
    var  sectionName: String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

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
          
                     
                     print("reson", resonn)
                     
                    titleOf.text = titlee
                      resonOf.text = resonn
            }
             }
         }
        
//      titleOf.text = titlee
//       reasonOf.text = reasonn

    }
    
    
    
    


}
