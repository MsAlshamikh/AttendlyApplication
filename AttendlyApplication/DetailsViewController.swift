//
//  DetailsViewController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 10/09/2022.
//

import UIKit
import FirebaseFirestore
import SwiftUI

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate  {
    
    @IBOutlet weak var savePDF: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoo: UIImageView!
    @IBOutlet weak var courseLabel2: UILabel!
    
    
    @IBAction func savePDF(_ sender: UIButton) {
        backgroundImage.isHidden = true
        savePDF.isHidden = true
        courseLabel.isHidden = true
        courseLabel2.isHidden = false
        courseLabel2.textColor = #colorLiteral(red: 0.05490196078, green: 0.568627451, blue: 0.631372549, alpha: 1)
        logoo.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        
        let text1 = NSMutableAttributedString()

               text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));

               text1.append(NSAttributedString(string: Global.shared.name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))

               lecturerLabel.attributedText = text1

               let tg = UITapGestureRecognizer(target: self, action: #selector(lecturerNameTapped(_:)))

                      lecturerLabel.isUserInteractionEnabled = true

                      lecturerLabel.addGestureRecognizer(tg)
        
        
        

        let path = self.view.exportASPdfFromView()
            if(path.count > 0) {
                let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
                dc.delegate = self
                dc.presentPreview(animated: true)
            }
        
        
        backgroundImage.isHidden = false
        savePDF.isHidden = false
        courseLabel2.isHidden = true
        logoo.isHidden = true
        courseLabel.isHidden = false
        
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
           return self.navigationController!
           
       }
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var lecturerLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
  //  var WhatPressed: String = ""
   
    var stateAll = [String]()
    var  dateAll = [String]()
    var timeAll = [String]()
    var haveAll = [String]()
    
//    var section: String = ""
//    var titleB: String = ""
//    var name: String = ""
    var email: String = ""
    var adv: String = ""
   // var lecturerId : String?
  var haveExec = false
  //  var buttonTappedAction : ((UITableViewCell) -> Void)?
   // var buttonTappedAction : (() -> Void)? = nil

    var Takesection = ""
    
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print("now your exucetion absent // shamma")
    
   
    
    
       let imageF = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9"),UIImage(named: "10"),UIImage(named: "11"),UIImage(named: "12"),UIImage(named: "13"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2")]
    
       

      //  my.courseName.image = imageF[indexPath.row]
    
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.tintColor = .white
            // self.tabBarController?.tabBar.isHidden = false
        
        let text1 = NSMutableAttributedString()

               text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));

               text1.append(NSAttributedString(string: Global.shared.name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))

                  lecturerLabel.attributedText = text1


        
        
        
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        logoo.isHidden = true
        courseLabel2.isHidden = true
        //navigationItem.title = "Course Details"
        Takesection = courseLabel.text!
        Takesection = courseLabel2.text!
        
       print("Takesection is it  ", Takesection )

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = 60
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
        
        //
        let db = Firestore.firestore()
        Task {
         
            let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: Global.shared.WhatPressed).getDocuments()
           
           // dateAll.removeAll()
            
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                
                let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                print(snp.documents.count)
            //      let st = t_snapshot.documents.first?.data()["st"] as! String
                
                guard let st  = doc.get("st") as? String else { continue }

                print("st is :" , st)
//               stateAll.removeAll()
//              // dateAll.removeAll()
//                timeAll.removeAll()
//                haveAll.removeAll()
                for studentDoc in snp.documents {
                    
                   

                    guard let state  = studentDoc.get("State") as? String else { continue }

                    print("state of student/",state)
                    
                    guard let time  = studentDoc.get("time") as? String else { continue }

                    print("time of student/",time)
                    
                    guard let have  = studentDoc.get("have") as? String else { continue }

                    print("time of student/",have)
                    
                  
                    stateAll.append(state)
                    dateAll.append(st)
                    timeAll.append(time)
                    haveAll.append(have)
                   // self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
                
                
            }
            
            
            
        } //task
        
        
        //
        
        
        
        
        
        
        let text1 = NSMutableAttributedString()
        text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text1.append(NSAttributedString(string: Global.shared.name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))
      
        //  avlabel.attributedText = underlineAttribute‏
      //  avlabel.attributedText = underlineAttribute‏
        
        //
        
        let text2 = NSMutableAttributedString()
        text2.append(NSAttributedString(string: "Section: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text2.append(NSAttributedString(string: Global.shared.section, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))
        
        courseLabel.text = Global.shared.titleB
        courseLabel2.text = Global.shared.titleB
        
   
        
        sectionLabel.attributedText = text2

        
        lecturerLabel.attributedText = text1
        let tg = UITapGestureRecognizer(target: self, action: #selector(lecturerNameTapped(_:)))
               lecturerLabel.isUserInteractionEnabled = true
               lecturerLabel.addGestureRecognizer(tg)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        let db = Firestore.firestore()
        Task
        {
            logoo.isHidden = true
            courseLabel2.isHidden = true
            let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: Global.shared.WhatPressed).getDocuments()
            dateAll.removeAll()
            stateAll.removeAll()
          timeAll.removeAll()
          haveAll.removeAll()
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                print(snp.documents.count)
               
                
                guard let st  = doc.get("st") as? String else { continue }

                print("st is :" , st)
                
            for studentDoc in snp.documents {
                    guard let state  = studentDoc.get("State") as? String else { continue }

                    print("state of student/",state)
                    
                    guard let time  = studentDoc.get("time") as? String else { continue }
                    print("time of student/",time)
                    guard let have  = studentDoc.get("have") as? String else { continue }

                    print("time of student/",have)
                    stateAll.append(state)
                    dateAll.append(st)
                    timeAll.append(time)
                    haveAll.append(have)
                    
                }
           
            }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        logoo.isHidden = true
        courseLabel2.isHidden = true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        print("befor",stateAll.count)
        logoo.isHidden = true
        courseLabel2.isHidden = true
        return stateAll.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        logoo.isHidden = true
        courseLabel2.isHidden = true
    }
    
    @objc func didTapCellButton(sender: UIButton) {
   
      
        let tag = sender.tag
        let dateispreesed = dateAll[tag]

        print("wiich is now press?? number of row",tag)
        print("wiich is now press?? dateispreesed",dateispreesed)
        
        let stude = storyboard?.instantiateViewController(withIdentifier: "FormVC") as! FormVC
        stude.Takesection = Global.shared.WhatPressed
        stude.datePreesed = dateispreesed
        print("whatpressed ???" , Global.shared.WhatPressed)
        navigationController?.pushViewController(stude, animated: true)
        
    }
    
    @objc func viewexecu(sender: UIButton) {
   
      
        let tag = sender.tag
        let dateispreesed = dateAll[tag]

        print("wiich is now press?? number of row",tag)
        print("wiich is now press?? dateispreesed",dateispreesed)
        
        let stude = storyboard?.instantiateViewController(withIdentifier: "StudentViewExec") as! StudentViewExec
        stude.datePreesed = dateispreesed
        stude.sectionName = Global.shared.WhatPressed
      //  print("whatpressed ???" , WhatPressed)
        navigationController?.pushViewController(stude, animated: true)
        
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "newc") as! TableViewhistoryStu
        
         my.selectionStyle = .none
        logoo.isHidden = true
        courseLabel2.isHidden = true
        my.execution.isHidden = true
        my.havePending.isHidden = true
    
       my.execution.tag = indexPath.row
    my.execution.addTarget(self, action: #selector(didTapCellButton(sender:)),for: .touchUpInside)
        
        my.havePending.tag = indexPath.row
        my.havePending.addTarget(self, action: #selector(viewexecu(sender:)),for: .touchUpInside)

      //  my.state.text = stateAll[indexPath.row]
        if stateAll[indexPath.row] == "absent" && haveAll[indexPath.row] == "f"  {
            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.state.text = stateAll[indexPath.row]
            my.execution.isHidden = false
        }
        
        else if stateAll[indexPath.row] == "absent" && haveAll[indexPath.row] == "t"  {
            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.state.text = stateAll[indexPath.row]
            my.havePending.isHidden = false
        }
       else if stateAll[indexPath.row] == "late"  {
            my.state.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            my.state.text = stateAll[indexPath.row]
        }
        else if stateAll[indexPath.row] == "attend"  {
             my.state.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        else if stateAll[indexPath.row] == "excused"   {
             my.state.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
             my.state.text = stateAll[indexPath.row]
            my.havePending.isHidden = false

         }
        else if stateAll[indexPath.row] == "pending"  {
             my.state.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        
        
      
        my.date.text = dateAll[indexPath.row]
        my.time.text = timeAll[indexPath.row]

       my.imageNumber.image = imageF[indexPath.row]
        return my
    }
    
    
    
    
    @objc func lecturerNameTapped(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "si_courseDetailToLecturerProfile", sender: nil)
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "si_courseDetailToLecturerProfile" {
            if let vc = segue.destination as? LecturerProfileVC {
                vc.lecturerID = Global.shared.lecturerId;
            }
        }
    }
    
    struct ShareSheet: UIViewControllerRepresentable {
            var urls: [Any]
            func makeUIViewController(context: Context) -> UIActivityViewController {
                let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
                return controller
            }
            
            func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
            }
        }
    }

    extension UIView {
        func exportASPdfFromView() -> String {
            let pdfPageFrame = self.bounds
            let pdfData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
            UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
            guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
            self.layer.render(in: pdfContext)
            UIGraphicsEndPDFContext()
            return self.saveViewPdf(data: pdfData)
        }
        
        func saveViewPdf(data: NSMutableData) -> String {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docDirectoryPath = paths[0]
            let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
            if data.write(to: pdfPath, atomically: true) {
                return pdfPath.path
            } else {
                return ""
            }
        }
    }
