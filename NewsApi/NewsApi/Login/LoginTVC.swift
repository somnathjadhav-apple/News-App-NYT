//
//  LoginTVC.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/20/22.
//

import UIKit

class LoginTVC: UITableViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //NewsListViewController
    @IBAction func btnLogin(_ sender: Any) {
        validationMethod()
        
        if let NewsList = self.storyboard?.instantiateViewController(withIdentifier: "NewsListViewController") as? NewsListViewController {
            self.navigationController?.pushViewController(NewsList, animated: true)
        }
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        if let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupTVC") as? SignupTVC {
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
        
    }
    
}

extension LoginTVC{
    
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

extension LoginTVC{
    
    fileprivate func validationMethod() {
        if let userName = txtUsername.text, let password = txtPassword.text {
            if !userName.validateUsername(){
                openAlert(title: "Alert", message: "Username is not correct", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                    print("Okay clicked!")
                }])
            } else if !password.validatePassword() {
                
                openAlert(title: "Alert", message: "Password is invalid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                    print("Okay clicked!")
                }])
                
            } else{
                // Navigation - Home Screen
            }
        }
        else{
            
            openAlert(title: "Alert", message: "Please fill the details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                print("Okay clicked!")
            }])
        }
    }
}
