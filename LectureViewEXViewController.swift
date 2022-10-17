//
//  LectureViewEXViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 19/03/1444 AH.
//

import UIKit
import FirebaseFirestore
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
            
             //      let st = t_snapshot.documents.first?.data()["st"] as! String
                 
 //                guard let st  = doc.get("st") as? String else { continue }
 //
 //                print("st is444444 :" , st)
               //  guard let tit = snp.("title") as? String else { continue }
                
//                 let tit: String = snp.documents.first?.data()["Title"] as! String
//          print("tit" , tit)
                

             //    self.titlee = snp.documents.first!.get("title") as! String; else { continue }
//                 self.reasonn = snp.documents.first!.get("reason") as! String
//
                 
                 for studentDoc in snp.documents {
//
                     guard let titlee = studentDoc.get("Title") as? String else { continue }
                     print("tit" , titlee)
                     
                     guard let resonn = studentDoc.get("reason") as? String else { continue }
          
                     
                     print("reson", resonn)
                     
                     titleOf.text = titlee
                      reasonOf.text = resonn
            }
             }
         }
        
//      titleOf.text = titlee
//       reasonOf.text = reasonn

    }
    
    
    



}
