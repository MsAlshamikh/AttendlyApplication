//
//  DetailsViewController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 10/09/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var lecturerLabel: UILabel!
    
//    @IBOutlet weak var title1: UILabel!
//
//    @IBOutlet weak var name1: UILabel!
//
//    @IBOutlet weak var id1: UILabel!
//
//    var title1 = [String]()
//    var name1 = [String]()
//    var id1 = [String]()
    
    
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    var email: String = ""
    var adv: String = ""
    var lecturerId : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //
//        title1.text =  "HELLO"
//        name1.text = "HISTORY"
//        id1.text = "ADAD"
        //
//        var str = "heellllooooo"
//        var myMutableString = NSMutableAttributedString(string: str)
//        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:2,length:4))
        let text1 = NSMutableAttributedString()
        text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text1.append(NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue])) 
      
        //  avlabel.attributedText = underlineAttribute‏
      //  avlabel.attributedText = underlineAttribute‏
        
        //
        
        let text2 = NSMutableAttributedString()
        text2.append(NSAttributedString(string: "Section: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text2.append(NSAttributedString(string: section, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))
        
        courseLabel.text = titleB
   
        
        sectionLabel.attributedText = text2

        
        lecturerLabel.attributedText = text1
        let tg = UITapGestureRecognizer(target: self, action: #selector(lecturerNameTapped(_:)))
               lecturerLabel.isUserInteractionEnabled = true
               lecturerLabel.addGestureRecognizer(tg)
        //
        // Do any additional setup after loading the view.
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
                vc.lecturerID = lecturerId;
            }
        }
    }
}
//
