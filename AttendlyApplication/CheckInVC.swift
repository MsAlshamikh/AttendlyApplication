//
//  CheckInVC.swift
//  AttendlyApp
//
//  Created by Yumna Almalki on 16/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class CheckInVC: UIViewController {
    @IBOutlet weak var selectCourseBtn: UIButton!
    
    @IBOutlet var butsection1Collection: [UIButton]!
    
    var students: [[String: Any]] = []
    var courseName: String?
    
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectCourseBtn.layer.cornerRadius = selectCourseBtn.frame.height / 2
        butsection1Collection.forEach{  (btn) in btn.layer.cornerRadius = btn.frame.height / 2
            btn.layer.cornerRadius = btn.frame.height / 2
            btn.isHidden = true
            btn.alpha = 0
        
    }
        addStudents()
    }
    

    
    func addStudents() {
        buttonsStackView.isUserInteractionEnabled = true
        
        buttonsStackView.arrangedSubviews.forEach { button in
            button.removeFromSuperview()
        }
        
       
        for (index, student) in students.enumerated() {
            let button = UIButton()
            let name = student["name"] as? String ?? "Unnamed"
            let attended = student["attended"] as? Bool ?? false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 1), for: .normal)
            button.backgroundColor = attended ? UIColor(red: 171/255, green: 200/255, blue: 148/255, alpha: 1) : UIColor(red: 255/255, green: 50/125, blue: 50/255, alpha: 1)
            button.setTitle(name, for: .normal)
            button.tag = index
            button.layer.cornerRadius = 25
            button.isEnabled = true
            button.addTarget(self, action: #selector(checkIn(sender:)), for: .touchUpInside)
            
            buttonsStackView.addArrangedSubview(button)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchStudents()
    }
   func fetchStudents() {
        guard let course = courseName else { return }
        let db = Firestore.firestore()
        db.collection("studentsByCourse/\(course)/students").getDocuments {[weak self] snapshot, error in
        
            guard let snapshot = snapshot else { return }
            
            var students: [[String: Any]] = []
            for document in snapshot.documents {
                var student = document.data()
                student["documentID"] = document.documentID
                
                print("STTTT ", students)
                students.append(student)
            }
            self?.students = students
            self?.addStudents()
        }
    }
    
    @objc func checkIn(sender: UIButton) {
        let tag = sender.tag
        let student = students[tag]
        
        guard let documentId = student["documentID"] as? String, let courseName = courseName else { return }
        
        let db = Firestore.firestore()
        db.collection("studentsByCourse/\(courseName)/students").getDocuments {[weak self] snapshot, error in
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents {
                if document.documentID == documentId {
                    document.reference.updateData([
                        "attended": true
                    ]) { error in
                        self?.fetchStudents()
                    }
                }
            }
        }
    }
    

    @IBAction func selectCourse(_ sender: UIButton) {
        butsection1Collection.forEach{ (btn) in UIView.animate(withDuration: 0.7){
            btn.isHidden = !btn.isHidden
            btn.alpha = btn.alpha == 0 ? 1 : 0
            btn.layoutIfNeeded()
            
        }
    }
    }
    @IBAction func butSection1(_ sender: UIButton) {
        if let btnLb1 = sender.titleLabel?.text{
            print(btnLb1)
            
        }
        
    }
    
   
}
