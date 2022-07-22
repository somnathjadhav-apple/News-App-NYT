//
//  SignupTVC.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import UIKit

class SignupTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func buttonSignup(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}

extension SignupTVC {
    // To adjust the height on large screen
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight=self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top:topInset,
                                                   left: 0.0, bottom: 0.0, right: 0.0)
    }
}
