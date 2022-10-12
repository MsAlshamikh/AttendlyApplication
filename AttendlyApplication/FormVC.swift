//
//  FormVC.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 09/03/1444 AH.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import FirebaseFirestore
var x = ""
class FormVC: UIViewController {

    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//
    @IBAction func openFile(_ sender: Any) {
        if let url = Bundle.main.url(forResource: x, withExtension: "pdf"){
            let webView = UIWebView (frame: self.view.frame)
            let urlr = URLRequest(url: url)
            webView.loadRequest(urlr as URLRequest)
            self.view.addSubview(webView)
        }
        
    }
    
    @IBAction func importFile(_ sender: Any) {
        let documentPicker  = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png, .pdf])
        //change the type ^^^^
        documentPicker.delegate = self
       
        documentPicker.allowsMultipleSelection = false // ease of use.only one doc
        documentPicker.shouldShowFileExtensions = true
        
 present(documentPicker, animated: true, completion: nil)
      
      //  print("")
      //  print(documentPicker)
        
        
    }
 
}
extension FormVC: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        label.text = url.lastPathComponent
       x = url.lastPathComponent
        print( url.lastPathComponent)
       // let ff = url.path
      //  label.text! += ff
        dismiss(animated: true)
        guard url.startAccessingSecurityScopedResource() != nil else {
            return
        }

        defer {
            url.stopAccessingSecurityScopedResource()
        }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {

    } //user closes the picker without making any selection
 
   
    }
    func spl(x:String) {
        var str = x
        var result = str.split(separator: "-")
        result.removeFirst()
        var str_arr: [String] = result.map { String($0) }
         let tag = str_arr[0]
        
        let db = Firestore.firestore()
        
        Task {
           
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
            let sections: [String] = snapshot.documents.first?.data()["Sections"] as! [String]
           var d = "30-9-2022"
           // let name: String = snapshot.documents.first?.data()["name"] as! String
            let email:String = snapshot.documents.first?.data()["StudentEmail"] as! String
            
            for section in sections {
                print(section, str_arr)
                if !str_arr.contains(section) { continue }
              //  print(thed)
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).whereField("st", isEqualTo: d).whereField("nameC", isEqualTo: "SWE381").getDocuments() //startDate
                
                let courseName = t_snapshot.documents.first?.data()["courseN"] as! String

                print("$$$$$$$$$$$$$")
                print(t_snapshot.documents.count)
               
                
              
            

                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                print("docID", documentID)

                
                let exist = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                
               
                guard let state  = exist.documents.first?.get("State") as? String else { continue }
                print("state/ +++++++++++++++ ",state)
                
                if (state == "absent" ){
                    
                   
                }
                
                else {
                
                var flag = ""
               
 
               
                
                
                let info =  db.collection("studentsByCourse").document(documentID)
                guard let student_id = try await info.collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments().documents.first?.documentID else { continue }
                
                try await info.collection("students").document(student_id).setData(["State": flag], merge: true)
                
            
                 
          
           
            
            // Create new Alert
          
          
        } // else
        }//loop
        }//task
    }// split

    
    
    
}
/* {
 
 let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: "SWE381").getDocuments()

//   let st = t_snapshot.documents.first?.data()["st"] as! String
 
//     print("st is :" , st)
 for doc in t_snapshot.documents {
     let documentID = doc.documentID
     
     let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
     print(snp.documents.count)
 //      let st = t_snapshot.documents.first?.data()["st"] as! String
     
     guard let st  = doc.get("st") as? String else { continue }

     print("st is :" , st)
     for studentDoc in snp.documents {
         
         
         guard let state  = studentDoc.get("State") as? String else { continue }

         print("state of student/",state)
         
         guard let time  = studentDoc.get("time") as? String else { continue }

         print("time of student/",time)
         
         
         stateAll.append(state)
         dateAll.append(st)
  
         self.tableView.reloadData()
     }
     
     
 }
 
 
 
}*/