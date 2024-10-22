//
//  LoginViewController.swift
//  Stunna
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Elisio Simao. All rights reserved.
//

import UIKit

//cores


class LoginViewController: UIViewController {
    
    var fullChoose: String = ""
    let dbHelperAdmin = DatabaseHelper()
    let dbHelper = DBHelperUser()

    
    //Campos botoes da UI
    
    let userField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let senhaField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    
    let tituloLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Sistema de gestao de rotas"
        textLbn.textColor = UIColor(hex: "#203e63")
        //textLbn.font = UIFont.systemFont(ofSize: 25)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        textLbn.font = UIFont.boldSystemFont(ofSize: 27)
        return textLbn
    }()
    
    let subTituloLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        //textLbn.textAlignment = .center
        return textLbn
    }()
    
    let conta: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Nao tens uma conta?"
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        //textLbn.textAlignment = .center
        return textLbn
    }()
    
    
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        //button.background = UIColor.green
        button.backgroundColor = UIColor(hex: "#203e63")
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let btnConta: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Criar", for: .normal)
        //button.setTitleColor(.green, for: .normal)
        button.tintColor = UIColor(hex: "#203e63")
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        
       
        loginButton.addTarget(self, action: #selector(loginBtn), for: .touchUpInside)
        btnConta.addTarget(self, action: #selector(screenSigUpAdmin), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        view.addSubview(tituloLbn)
        view.addSubview(subTituloLbn)
        view.addSubview(userField)
        view.addSubview(senhaField)
        view.addSubview(loginButton)
        view.addSubview(conta)
        view.addSubview(btnConta)
        
        tituloLbn.frame = CGRect(x: (screenWidth-(screenWidth - 100))/2, y: 150, width: screenWidth - 100, height: 80)
        
        subTituloLbn.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)-120, width: screenWidth - 20, height: 80)
        
        userField.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)-50, width: screenWidth - 60, height: 60)
        
        senhaField.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)+20, width: screenWidth - 60, height: 60)
        
        loginButton.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)+120, width: screenWidth - 60, height: 50)
        
        conta.frame = CGRect(x: (screenWidth - 200)/2, y: (screenHeight-80), width: 180, height: 50)
        
        btnConta.frame = CGRect(x: (screenWidth + 100)/2, y: (screenHeight-65), width: 70, height: 20)
        
        
        
    }
    
    func screenHomeAdmin(){
        let users = dbHelperAdmin.fetchAllAdmins()
        
        for user in users {
            print("Nome: \(user.0), Senha: \(user.1)")
            if let nomeUsuario = userField.text, let senhaUsuario = senhaField.text {
                if(user.0 == nomeUsuario){
                    if(user.1 == senhaUsuario){
                        
                        let goToScreen = HomeRotaViewController()
                        //goToScreen.nameAdmin = nomeUsuario
                        goToScreen.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(goToScreen, animated: true)
                    }
                }
            }
            
        }
    }
    
    func userLayout(){
        let users = dbHelper.fetchAllUsers();
        for user in users {
            print("nome: \(user.email)")
            if let  nomeUser = userField.text {
                if(nomeUser == user.email){
                    let goToScreen = UserViewController()
                    //goToScreen.nameAdmin = nomeUsuario
                    goToScreen.nomeUser = nomeUser
                    goToScreen.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(goToScreen, animated: true)

                }
            }
        }
    }
    
    @objc func loginBtn(){
        if let senha = senhaField.text {
            if(senha == "root"){
                userLayout()
            }else{
                screenHomeAdmin()
            }
        }
    }
    
    
    
    @objc func screenSigUpAdmin(){
        let goToScreen = CriarContaAdminViewController()
        goToScreen.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(goToScreen, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
