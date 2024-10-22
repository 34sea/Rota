//
//  AddSViewController.swift
//  MecanicApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Cleyton&Samir. All rights reserved.
//

import UIKit

class AddRotaViewController: UIViewController {
    
    let dbHelper = DBHelperRota()
    
    let label = UILabel()
    
    
    
    let nomeServicoField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let precoServicoFeld: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Preco"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let larguraTela = view.frame.size.width
        let alturaTela = view.frame.size.height
        
        
        label.textColor = .black
        label.text = "Adicionar rotas"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        //label.frame = CGRect(x: (screenWidth-100)/2, y: 400, width: 100, height: 100)
        view.addSubview(label)
        
        
        
        let btnLogin = UIButton(type: .custom)
        btnLogin.setTitle("Adicionar", for: .normal)
        btnLogin.backgroundColor = UIColor(hex: "#203e63")
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.layer.cornerRadius = 10
        btnLogin.frame = CGRect(x: (larguraTela - 300)/2, y: (alturaTela-150), width: 300, height: 40)
        view.addSubview(btnLogin)
        
        view.addSubview(nomeServicoField)
        view.addSubview(precoServicoFeld)
        
        btnLogin.addTarget(self, action: #selector(addServ), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            //label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nomeServicoField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            nomeServicoField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nomeServicoField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nomeServicoField.heightAnchor.constraint(equalToConstant: 44),
            
            precoServicoFeld.topAnchor.constraint(equalTo: nomeServicoField.bottomAnchor, constant: 10),
            precoServicoFeld.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            precoServicoFeld.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            precoServicoFeld.heightAnchor.constraint(equalToConstant: 44),
            
            ])
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addServ(){
        if let precoL = precoServicoFeld.text, let precoLl = Double(precoL){
            dbHelper.insertServico(nome: nomeServicoField.text!, preco: precoLl)
        }
        print("Nome: \(nomeServicoField.text!) preco: \(precoServicoFeld.text!)")
        
        let t = HomeRotaViewController()
        t.modalPresentationStyle = .fullScreen
        //t.escolha = "user"
        self.navigationController?.pushViewController(t, animated: true)
        
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
