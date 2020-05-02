//
//  SecondScreen.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/2/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import UIKit

class New_ControllerViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!{
        didSet{
            self.welcomeLabel.text = "Welcome to New_Controller 😊😊"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New_Controller"
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

}
