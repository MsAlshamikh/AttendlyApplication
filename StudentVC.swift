//
//  StudentVC.swift
//  AttendlyApplication
//
//  Created by Rania Alageel on 16/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import MessageUI

class StudentVC: UIViewController , UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SecName: UILabel!
    @IBOutlet weak var StudnetName: UILabel!
    @IBOutlet weak var StudentEmail: UILabel!
    
    
    let imageF = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2")]
 
    
    
    
    var WhatPressed: String = ""
    var stateAll = [String]()
    var  dateAll = [String]()
    var timeAll = [String]()
    
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    var email: String = ""
    var adv: String = ""
    var lecturerId : String?
    var v : String = "" // student id
    var sectionName = ""
    var SingleEmail: String = ""
    var SingleName: String = ""
    var FullEmail : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Course details" 

        print("sectionName" , sectionName )
        print("SingleName" , SingleName )
        print("SingleEmail" , SingleEmail )
        
        SecName.text = sectionName
        StudnetName.text = SingleName
        StudentEmail.text = SingleEmail
        
        
            print("here course is ", sectionName)
            print("here id is ", v)

        
        
        
        let emailBarButton = UIBarButtonItem(image: UIImage(systemName: "envelope"), style: .plain, target: self, action: #selector(emailButtonTouched))
        self.navigationItem.rightBarButtonItem = emailBarButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = 60
            //
            let db = Firestore.firestore()
            Task {
             
                let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionName).getDocuments()
               
           
                    for doc in t_snapshot.documents {
                    let documentID = doc.documentID
                    
                    let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("id", isEqualTo: v).getDocuments()
                    print(snp.documents.count)
              
                    
                    guard let st  = doc.get("st") as? String else { continue }

                    print("st is :" , st)
                    for studentDoc in snp.documents {
                        
                        
                        guard let state  = studentDoc.get("State") as? String else { continue }

                        print("state of student/",state)
                        
                        guard let time  = studentDoc.get("time") as? String else { continue }

                        print("time of student/",time)
                        
                        
                        stateAll.append(state)
                        dateAll.append(st)
                        timeAll.append(time)
                        self.tableView.reloadData()
                    }
                    
                    
                }
                
                
                
            } //task
            
            
            //
            
            
            
            
            
            
//            let text1 = NSMutableAttributedString()
//            text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
//            text1.append(NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))
//
//            //  avlabel.attributedText = underlineAttribute‏
//          //  avlabel.attributedText = underlineAttribute‏
//
//            //
//
//            let text2 = NSMutableAttributedString()
//            text2.append(NSAttributedString(string: "Section: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
//            text2.append(NSAttributedString(string: section, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))
//
//            courseLabel.text = titleB
//            sectionLabel.attributedText = text2
//            lecturerLabel.attributedText = text1
//            let tg = UITapGestureRecognizer(target: self, action: #selector(lecturerNameTapped(_:)))
//                   lecturerLabel.isUserInteractionEnabled = true
//                   lecturerLabel.addGestureRecognizer(tg)
//            //
//            // Do any additional setup after loading the view.
//
       
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        print("befor",stateAll.count)
        return stateAll.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let my = tableView.dequeueReusableCell(withIdentifier: "newc") as! StudentCellVC
        
        
        
    
        if stateAll[indexPath.row] == "absent" {
            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.state.text = stateAll[indexPath.row]
           
        }
       else if stateAll[indexPath.row] == "late" {
            my.state.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            my.state.text = stateAll[indexPath.row]
        }
        else if stateAll[indexPath.row] == "attend" {
             my.state.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        
        
      
        my.date.text = dateAll[indexPath.row]
        my.time.text = timeAll[indexPath.row]

       my.imageNumber.image = imageF[indexPath.row]
        return my
    }
    

    
    @objc func emailButtonTouched(_sender: Any){
        
        let email = FullEmail
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([email])
            self.present(mailVC, animated:true)
        }
    }
}

//extension StudentVC : MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        if let error = error {
//            print("Mail sending error" , error.localizedDescription)
//            controller.dismiss(animated: true)
//        } else {
//            controller.dismiss(animated: true)
//        }
//    }
//}
