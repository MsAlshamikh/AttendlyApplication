//
//  StudentInfoViewController.swift
//  AttendlyApplication
//
//  Created by Yumna Almalki on 15/03/1444 AH.
//

import UIKit

class StudentInfoViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sid: UILabel!
    @IBOutlet weak var majorlabel: UILabel!
    @IBOutlet weak var avlabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    var student: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = student["name"] as? String
        emailLabel.text = student["StudentEmail"] as? String
        majorlabel.text = student["Major"] as? String
        sid.text = student["studentID"] as? String
        levelLabel.text = student["Level"] as? String
        // Do any additional setup after loading the view.
    }
}
