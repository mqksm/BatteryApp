//
//  LoginViewController.swift
//  BatteryApp
//
//  Created by Maks on 10.05.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginField.text = ""
        passwordField.text = ""
    }
    
    @IBAction func login() {
        guard let login = loginField.text, let password = passwordField.text, loginField.text != "", passwordField.text != ""
            else { getAlert(message: "Fill all fields")
                return }
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicates = NSPredicate(format: "%K == %@ AND %K == %@", argumentArray: ["login", login, "password", password])
        request.predicate = predicates
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            print(result)
            if result.count == 1 {
                performSegue(withIdentifier: "segueTableView", sender: self)
            } else {
                getAlert(message: "Incorrect login or password")
                
            }
        } catch {
            getAlert(message: "Incorrect login or password")
        }
    }
    
    
    
    func getAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
