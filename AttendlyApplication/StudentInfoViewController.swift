//
//  StudentInfoViewController.swift
//  AttendlyApplication
//
//  Created by Yumna Almalki on 15/03/1444 AH.
//

import UIKit
import FirebaseFirestore
import MessageUI

class StudentInfoViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avlabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    //@IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var scroll: UIView!
    var section: String = ""
    var titleB: String = ""
    var selectedIndex : Int = 0
    var name: String = ""
    var sections : [String] = []
    
    var student: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = student["Fullname"] as? String
        levelLabel.text = student["Level"] as? String
        //emailLabel.text = student["StudentEmail"] as? String
        let email = student["StudentEmail"] as? String ?? ""
        percentage(email: email)
        // Do any additional setup after loading the view.
        
        let emailBarButton = UIBarButtonItem(image: UIImage(systemName: "envelope"), style: .plain, target: self, action: #selector(emailButtonTouched(_:)))
        self.navigationItem.rightBarButtonItem = emailBarButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func percentage(email: String) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
//        dateUI.text = dateFormatter.string(from: date)
        let calunder = Calendar.current
        let day = calunder.component(.day , from: date)
        let month = calunder.component(.month , from: date)
        let year = calunder.component(.year , from: date)
        let thed = "\(day)-\(month)-\(year) "
        Task{
            
            let db = Firestore.firestore()
            
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: email).getDocuments()
            guard snapshot.documents.count > 0 else {
                
                return
                
            }
            let level = snapshot.documents.first!.get("Level")
//            levelUI.text = "Level \(level!) - Semester 1"
            let student_docID = snapshot.documents.first!.documentID
            guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }
            var abbsencest = snapshot.documents.first!.get("abbsencest") as! [String: Int]
            print("dict ", abbsencest)
            var i = 0
            for section in sectsChk {
                var globalAbbsencen = 0
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).getDocuments()
                print(t_snapshot.documents.count)
                
                print(t_snapshot.documents.count)
                for doc in t_snapshot.documents {
                    let documentID = doc.documentID
                    guard let date = doc.get("st") as? String else { continue }
                    print(date.split(separator: "-"))
                    let d = Int(date.split(separator: "-")[0])!
                    let m = Int(date.split(separator: "-")[1])!
                    let y = Int(date.split(separator: "-")[2])!
                    print(d, m, date, day)
                    if (d > day && m > month) {
                        print("skip")
                        continue
                    }
                    
                    let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo:  email).getDocuments()
                    
                    print(snp.documents.count)
                    guard let state  = snp.documents.first?.get("State") as? String else { continue }
                    print("state/",state)
                    if(state ==  "absent"){
                        print("hi")
                        globalAbbsencen = globalAbbsencen + 2 //from section take dureation
                        print("globalAbbsence/",globalAbbsencen)
                    }
                    else{
                        print("by")
                    }
                }
                
                
                
                abbsencest[section] = globalAbbsencen
                let data = [
                    "abbsencest": abbsencest
                ]
                try await db.collection("Unistudent").document(student_docID).setData(data, merge: true)
                
                db.collection("Unistudent").whereField("StudentEmail", isEqualTo: email).getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL ")
                    }
                    else{
                        guard let snapshot = snapshot, snapshot.documents.count > 0 else {
                            return
                        }

                        //
                        let total = snapshot.documents.first!.get("sectionH") as! [String: Double]
                   //     var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
                        
                        
                        for (key, value) in total {
                                   print(key)
                                   if ( key == section)
                            { print("LETS GOOOOO")
                                       
                                    var step1 = value * 0.25
                                       var step2 = ( Double(globalAbbsencen) /  step1 ) * 100
                                            var final = step2 * 0.25
                                       
                              //         totalp[section] = final
                                       
                                       print(final)
                                       
                                      
                                       
                                       
                                       
                                       let actual = snapshot.documents.first!.get("courses") as! [String]
                                        let sects = snapshot.documents.first!.get("Sections") as! [String]
                                   print(actual)
                                   //for i in 0..<actual.count {
                                       //design
                                      
                                       //all in box
                                       
                                       let box =  UIButton(frame: .init(x: Int(self.scroll.frame.midX)-150 , y: (10 +  Int((Double(i))) * 90 ), width: 370, height: 83))
                                       box.backgroundColor = .init(red: 242/255, green: 242/255, blue: 242/255, alpha: 2)
                                       box.layer.borderColor = .init(red: 231/255, green: 231/255, blue: 231/255, alpha: 2)
                                       box.layer.cornerRadius = 30
                                       box.layer.borderColor = .init(red: 231/255, green: 231/255, blue: 231/255, alpha: 2)
                                       box.layer.borderWidth = 4
                                       
                                       self.scroll.addSubview(box)
                                       
                                       let d =  UIButton(frame: .init(x: Int(self.scroll.frame.midX)-130 , y: (20 +  Int((Double(i))) * 90 ), width: 350, height: 15))
                                       
                                       let label = UIButton(frame: .init(x: self.scroll.frame.midX-198 , y: ( Double(i) * 90 ), width: 300, height: 60))
                                       label.setTitle(actual[i], for: .normal)
                                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                                      // label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                                       
                                       //line
                                       let line =  UIButton(frame: .init(x: Int(self.scroll.frame.midX)-108 , y: (50 +  Int((Double(i))) * 90 ), width: 250, height: 26))
                                
                                       //
                                       line.layer.cornerRadius = 0.04 * label.bounds.size.width
                                       line.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.3)
                                       
                                       //
                                     //  var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
                                   //    print("this ok up/" , totalp)
                                       //
                                       let z = final
                                       let after = final*10
                                      //
                                       let perc = UIButton(frame: .init(x: CGFloat(self.scroll.frame.midX)-108 , y: 50 + Double(( Int((Double(i))) * 90 )), width: after, height: 26))
                                       //
                                       perc.layer.cornerRadius = 0.04 * label.bounds.size.width
                                       print("ZZ… ", z)
                                       if (z>20)
                                       {perc.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) }
                                       else if (z>15)
                                           {  perc.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) }
                                       else if (z>10)
                                           {   perc.backgroundColor = #colorLiteral(red: 0.9632890821, green: 0.9198573232, blue: 0, alpha: 1) }
                                       else
                                           { perc.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) }
                                       
                    //
                                       let pt = UILabel(frame: .init(x: Int(self.scroll.frame.midX)+150 , y: 50 + ( Int((Double(i))) * 90 ), width: 70, height: 26))
                                       pt.textColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2)
                                       
                                     final = Double(round(10 * final) / 10)
                                       pt.font = UIFont(name: "systemFont", size: 22.0)
                                       
                                       pt.text = " " + String(final) + "%"
                                           
                                       
                                       self.scroll.addSubview(perc)
                                       self.scroll.addSubview(pt)

                                       self.scroll.addSubview(line)
                                           //
                                       //label.tag = Int(section) ?? 0
                                       label.tag = i;
                                       label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                                       label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
                                       label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
                                       label.layer.cornerRadius = 0.07 * label.bounds.size.width
                                       self.scroll.addSubview(label)
                                       
                                       i = i+1
                                       
                                   
     
                                   }
                            
                               }
                    }
                        
                    }
      
            }}}
    
    @objc func pressed1(sender:UIButton) {
        sender.setTitleColor(UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 2), for: .normal)
       // sender.backgroundColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 0.75)
        
    }
    
    @objc func pressed2(sender:UIButton) {
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
      //  sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
    }
    
    @objc func pressed(sender:UIButton) {
       
        
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        //sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
        //1
        titleB = sender.title(for: .normal)!
        //2
        section = self.sections[sender.tag]
        selectedIndex = sender.tag
        
        
        let db = Firestore.firestore()
        db.collection("Sections").whereField("section", isEqualTo: section).getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL2 ")
            }
            else{
                print("SUCCESS2")
                let id = snapshot!.documents.first!.get("lecturerID") as! String
                print(id)
                
                db.collection("Lecturer").whereField("id", isEqualTo: id).getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL3 ")
                    }
                    else{
                        print("SUCCESS 3")
                        self.name = snapshot!.documents.first!.get("name") as! String
                        self.performSegue(withIdentifier: "s1", sender: self)
                        //3
                        //print(name)
                       
                    }
                }
            }
        }
    }
    
    @objc func emailButtonTouched(_ sender: Any) {
        
        guard let email = student["StudentEmail"] as? String else {return}
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients([email])
            self.present(mailVC, animated:true)
        }
    }
}

extension StudentInfoViewController : MFMailComposeViewControllerDelegate  {
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
