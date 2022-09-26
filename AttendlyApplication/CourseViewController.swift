//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class CourseViewController: UIViewController {
    
    
    @IBOutlet weak var noC: UILabel!
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        get()
    }
    /*  func loadStats(){
     let db = Firestore.firestore()
     db.collection("Unistudent").addDocument(data: ["advisorID" : "441111111", "major" : "SWE","sFirstN" : "Amani","sLastN" : "Aldahmash","studentID" : "441204066"])
     {error in
     if let error = error {
     print("FAAAAAIIIIILLLLLL ")
     }
     else{
     print("YESSSSSSSSSSS")
     }
     }}}*/
    func get(){
        let db = Firestore.firestore()
        db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL ")
            }
            else{
                print("SUCCESS")
                print(Global.shared.useremailshare)
                let actualChk = snapshot!.documents.first!.get("courses") as! [String]
                let sectsChk = snapshot!.documents.first!.get("Sections") as! [String]
                if((actualChk.count == 1 && actualChk[0] == "" ) || (sectsChk.count == 1 && sectsChk[0] == "" ) )
                {
                    print("IT WOOOORKED")
                    
                    self.noC.text = "No courses \n registered!"
                    
                }
                
                //
                else{
                    let actual = snapshot!.documents.first!.get("courses") as! [String]
                     let sects = snapshot!.documents.first!.get("Sections") as! [String]
                print(actual)
                for i in 0..<actual.count {
                    let label = UIButton(frame: .init(x: self.view.frame.midX-238 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                    label.setTitle(actual[i], for: .normal)
                    label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                    label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                   // label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                    
                    //line
                    let line =  UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 333 + ( Int((Double(i))) * 90 ), width: 250, height: 26))
             
                    //
                    line.layer.cornerRadius = 0.04 * label.bounds.size.width
                    line.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.75)
                    
                    
                    //
                    let z = 17
                    let after = z*10
                   //
                    
                    
                    let perc = UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 333 + ( Int((Double(i))) * 90 ), width: after, height: 26))
                    //
                    perc.layer.cornerRadius = 0.04 * label.bounds.size.width
                    if (z>20)
                    {perc.backgroundColor = UIColor(red: 355/255, green: 0/255, blue: 0/255, alpha: 0.75)}
                    else if (z>15)
                    {  perc.backgroundColor = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 0.75)}
                    else if (z>10)
                    {   perc.backgroundColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 0.75)}
                    else
                    { perc.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.75)}
 //
                    let pt = UILabel(frame: .init(x: Int(self.view.frame.midX)+105 , y: 333 + ( Int((Double(i))) * 90 ), width: 70, height: 26))
                    pt.textColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2)
                    
                  
                    pt.font = UIFont(name: "systemFont", size: 27.0)
                    
                    pt.text = " " + String(z) + "%"
                    
                    self.view.addSubview(line)
                    self.view.addSubview(perc)
                    self.view.addSubview(pt)


                        //
                    label.tag = Int(sects[i]) ?? 0
                    label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                    label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
                    label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
                    label.layer.cornerRadius = 0.07 * label.bounds.size.width
                    self.view.addSubview(label)
                    
                    
                }}
                
               //
                //Vstack
                // coursesT.text = actual
                //     print((actual).count)
            }
        }
        
    }
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
        section = String(sender.tag)
        
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "s1" {
            if let controller = segue.destination as? DetailsViewController {
                controller.section = section
                controller.name = name
                controller.titleB = titleB
            }
        }
    }
    
  
}
/*
func checkCoursesExist(email: String, collection: String, field: String) async -> Bool {

    let db = Firestore.firestore()

    do {

        let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
        let scs = snapshot.documents.first!.get("lecturerID") as! String
        
        return scs.count != 0

    } catch {

        print(error.localizedDescription)

    }

    return false

}
 }*/

/*
 func get(){
     let db = Firestore.firestore()
     Task{
         do{
     db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "322@student.ksu.edu.sa").getDocuments{
         (snapshot, error) in
         if let error = error {
             print("FAIL ")
         }
         else{
             print("SUCCESS")
             if await self.checkCoursesExist(email: "322@student.ksu.edu.sa", collection: "Unistudent", field: "StudentEmail"){
             let actual = snapshot!.documents.first!.get("courses") as! [String]
             let sects = snapshot!.documents.first!.get("Sections") as! [String]
             print(actual)
             for i in 0..<actual.count {
                 
                 let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                 label.setTitle(actual[i], for: .normal)
                 label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                 label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                 label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                 //label.params["course"] = actual[i]
                 //!!!!!!
                 label.tag = Int(sects[i]) ?? 0
                 label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                 label.layer.cornerRadius = 0.07 * label.bounds.size.width
                 self.view.addSubview(label)
             }
             //Vstack
             // coursesT.text = actual
             //     print((actual).count)
         }
             else
             {let c = UILabel(frame: .init(x: self.view.frame.midX-120 , y: 200 , width: 250, height: 50))
                 c.title = "No courses"}
                 //
             }}}
         catch {
         }}}
 */


/*
 //PERCENTAGE TRYING
 var temp = 0
let abs_snapshot =  db.collection("studentsByCourse").whereField("tag", isEqualTo: sects[0])
     .getDocuments{
     (snapshot1, error) in
     if let error = error {
         print("FAIL ")
     }
     else{
      
     }
     }}
 
/*   abs_snapshot.data("students").whereField("EmailStudent", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments{
     (snapshot1, error) in
     if let error = error {
         print("FAIL ")
     }
     else{
         
         let state = snapshot!.documents.first!.get("State") as! String
         if state == "absent"
         { temp = temp + 1
             print(temp)
         }
         
         /*
          let state = snapshot!.documents.get("State") as! [String]
          for i in 0..<state.count {
          if stateA[i] == "absent"
          { temp = temp + 1
              print(temp)
          }
          */*/
         
     }}
 */

