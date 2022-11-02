//
//  StudentVC.swift
//  AttendlyApplication
//
//  Created by Rania Alageel on 16/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import MessageUI
import SwiftUI

class StudentVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var backgroundimg: UIImageView!
    @IBOutlet weak var saveAsPdf: UIButton!
    @IBOutlet weak var logoo1: UIImageView!
    
    @IBOutlet weak var SecName1: UILabel!
    
    @IBAction func saveAsPdf(_ sender: UIButton) {
        backgroundimg.isHidden = true
        saveAsPdf.isHidden = true
        SecName.isHidden = true
        SecName1.isHidden = false
        SecName1.textColor = #colorLiteral(red: 0.05490196078, green: 0.568627451, blue: 0.631372549, alpha: 1)
        logoo1.isHidden = false
            let path = self.view.exportASPdfFromView()
                if(path.count > 0) {
                    let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
                    dc.delegate = self
                    dc.presentPreview(animated: true)
                }
        backgroundimg.isHidden = false
        saveAsPdf.isHidden = false
        SecName.isHidden = false
        SecName1.isHidden = true
        logoo1.isHidden = true
        }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
           return self.navigationController!
           
       }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SecName: UILabel!
    @IBOutlet weak var StudnetName: UILabel!
    @IBOutlet weak var StudentEmail: UILabel!
    
    let refreshControl = UIRefreshControl()

    
    let imageF = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9"),UIImage(named: "10"),UIImage(named: "11"),UIImage(named: "12"),UIImage(named: "13"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2")]
 
    
    
    
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
        
       
        
        SecName1.isHidden = true
        logoo1.isHidden = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
        
       // navigationItem.title = "Course details"

        print("sectionName" , sectionName )
        print("SingleName" , SingleName )
        print("SingleEmail" , SingleEmail )
        
        SecName.text = sectionName
        SecName1.text = sectionName
        StudnetName.text = SingleName
        StudentEmail.text = SingleEmail
        
        
            print("here course is ", sectionName)
            print("here id is ", v)

        
        // ##########
        
        let emailBarButton = UIBarButtonItem(image: UIImage(systemName: "envelope"), style: .plain, target: self, action: #selector(emailButtonTouched))
        self.navigationItem.rightBarButtonItem = emailBarButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // ############
        
        
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = 60
            //
            let db = Firestore.firestore()
        print("hi")
            Task {
                print("hi2222 ")
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
                
                
                
            }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        let db = Firestore.firestore()
        Task {
            SecName1.isHidden = true
            logoo1.isHidden = true
            let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: sectionName).getDocuments()
           
            dateAll.removeAll()
            
            stateAll.removeAll()
            timeAll.removeAll()
            
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
                   // self.tableView.reloadData()
                }
                
                
            }
            
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        print("befor",stateAll.count)
        SecName1.isHidden = true
        logoo1.isHidden = true
        return stateAll.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        SecName1.isHidden = true
        logoo1.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        SecName1.isHidden = true
        logoo1.isHidden = true
        let my = tableView.dequeueReusableCell(withIdentifier: "newc") as! StudentCellVC
        
        
        my.selectionStyle = .none

    
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
        
        else if stateAll[indexPath.row] == "excused"   {
             my.state.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        else if stateAll[indexPath.row] == "pending"   {
             my.state.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        
      
        my.date.text = dateAll[indexPath.row]
        my.time.text = timeAll[indexPath.row]

       my.imageNumber.image = imageF[indexPath.row]
        return my
    }
    

    // #############
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
extension StudentVC : MFMailComposeViewControllerDelegate  {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("Mail sending error", error.localizedDescription)
            controller.dismiss(animated: true)
        } else {
            controller.dismiss(animated: true)
            //SHOW and alert that mail was sent
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
// #########################
