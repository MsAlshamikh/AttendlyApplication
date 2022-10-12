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
class FormVC: UIViewController , UITextFieldDelegate , UITextViewDelegate{
    @IBOutlet weak var TitleTixtFeild: UITextField!
    
    @IBOutlet weak var messR: UILabel!
    @IBOutlet weak var messT: UILabel!
    @IBOutlet weak var imp: UIButton!
    @IBOutlet weak var ReasonTextFeild: UITextField!
    @IBOutlet weak var reasonText: UITextView!
    @IBOutlet weak var titleView: UITextView!
    
    @IBOutlet weak var cnacelBtn: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var SendBtn: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        reasonText.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        reasonText.layer.borderWidth = 1.0
        reasonText.layer.cornerRadius = 5
        titleView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        titleView.layer.borderWidth = 1.0
        titleView.layer.cornerRadius = 5
        self.titleView.delegate = self
        self.reasonText.delegate = self

       
        let db = Firestore.firestore()
        Task {
         
            let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: "").getDocuments()
           
         //   let st = t_snapshot.documents.first?.data()["st"] as! String
            
       //     print("st is :" , st)
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                
                let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).whereField("State", isEqualTo: "absent").getDocuments()
                print(snp.documents.count)
            //      let st = t_snapshot.documents.first?.data()["st"] as! String
                
                 let st  = doc.get("st") as? String

                print("st is :" , st)
                for studentDoc in snp.documents {
                    
                    
                    guard let state  = studentDoc.get("State") as? String else { continue }

                    print("state of student/",state)
                    
                    guard let time  = studentDoc.get("time") as? String else { continue }

                    print("time of student/",time)
                    
                    
                   // stateAll.append(state)
                   // dateAll.append(st)
                    //timeAll.append(time)
                   // self.tableView.reloadData()
                }
                
                
            }
            
            
            
        } //task

        // Do any additional setup after loading the view.
    }
    func textUITextViewShouldReturn(_ textField: UITextView) -> Bool {
        textField.resignFirstResponder()
 
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func isValid() -> (Bool, String, String) {
        messT.isHidden = true   // not show
        messR.isHidden = true
        
      
        guard let res = reasonText.text, !res.isEmpty else {
            messR.isHidden = false
            messR.text = "Can not be empty!"
            reasonText.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            return (false, "", "")
        }
        guard let tit = titleView.text?.trimmingCharacters(in: .whitespaces).lowercased() , !tit.isEmpty else {
            messT.isHidden = false
            messT.text = "Can not be empty!"
            titleView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            messR.isHidden = false
            return (false, "", "")
        }
        guard let tit = titleView.text?.trimmingCharacters(in: .whitespaces).lowercased() , !tit.isEmpty, let res = reasonText.text?.trimmingCharacters(in: .whitespaces).lowercased(), !res.isEmpty
        else {
            messT.isHidden = false
            messT.text = "Can not be empty!"
            titleView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            messR.isHidden = false
            messR.text = "Can not be empty!"
            reasonText.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            return (false, "", "")
        }
        
        
        
        return (true, tit, res)
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
  
    @IBAction func sendPressed(_ sender: Any) {
        let res = isValid()
        if res.0 == false {
            return
        }
    //   code
        let title = res.1
        let reason = res.2
        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to send the form?", preferredStyle: .alert)
         // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        dialogMessage.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap") }))

         
        // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
      
    }
    @IBAction func cancelPressed(_ sender: Any) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to cancel ", preferredStyle: .alert)
         // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        dialogMessage.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap") }))

         
        // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
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
        imp.backgroundColor = UIColor( white: 0xD6D6D6, alpha: 0.5)
       
    } //user closes the picker without making any selection
 
        imp.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }

   /* func spl(x:String) {
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
    */

  
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
