//
//  LoginViewController.swift
//  Stunna
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Elisio Simao. All rights reserved.
//

import UIKit
import SQLite3

//cores


class AddTransporteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    //let dbHelper = DatabaseHelper()
    let dbHelper = DBHelperUser()

    var fullChoose: String = ""
    var genderOptions: [String] = []
    let genderPicker = UIPickerView()
    let rotaDb = DBHelperRota()
    var c: Int = 0
    var emailTexto: String?
    var senhaTexto: String?
    //Campos botoes da UI
    
    let userField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome completo"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let senhaField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Matricula"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    
    let tituloLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Sistema de gestao de rotas"
        textLbn.textColor = UIColor(hex: "#203e63")
        textLbn.font = UIFont.systemFont(ofSize: 25)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
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
        textLbn.text = "Ja tens uma conta?"
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        //textLbn.textAlignment = .center
        return textLbn
    }()
    
    
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Criar", for: .normal)
        //button.background = UIColor.green
        button.backgroundColor = UIColor(hex: "#203e63")
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let btnConta: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        //button.setTitleColor(.green, for: .normal)
        button.tintColor = UIColor(hex: "#203e63")
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let rotas = rotaDb.fetchAllServicos()
        for rota in rotas {
            genderOptions.append(rota.1)
            c+=1
            print("ID: \(rota.0), Nome: \(rota.1), Preço: \(rota.2)")
        }
        c=0
        setupUI()
        loginButton.addTarget(self, action: #selector(criar), for: .touchUpInside)
        btnConta.addTarget(self, action: #selector(screenLoginAdmin), for: .touchUpInside)
       
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
       // view.addSubview(conta)
        //view.addSubview(btnConta)
        
        tituloLbn.frame = CGRect(x: (screenWidth-(screenWidth - 100))/2, y: 150, width: screenWidth - 100, height: 80)
        
        subTituloLbn.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)-120, width: screenWidth - 20, height: 80)
        
        userField.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)-50, width: screenWidth - 60, height: 60)
        
        senhaField.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight/2)+20, width: screenWidth - 60, height: 60)
        
        loginButton.frame = CGRect(x: (screenWidth-(screenWidth - 60))/2, y: (screenHeight-100), width: screenWidth - 60, height: 50)
        
        //conta.frame = CGRect(x: (screenWidth - 200)/2, y: (screenHeight-80), width: 180, height: 50)
        
       // btnConta.frame = CGRect(x: (screenWidth + 100)/2, y: (screenHeight-65), width: 70, height: 20)
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderPicker)
        genderPicker.frame = CGRect(x: (screenWidth-(screenWidth - 50))/2, y: screenHeight-310, width: screenWidth - 50, height: 60)

    }
    
   
    @objc func addTransporte(){
        let telas = HomeTransporteViewController()
        telas.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(telas, animated: true)
    }
    @objc func screenLoginAdmin(){
        let goToScreen = LoginViewController()
        //goToScreen.fullChoose = "Admin"
        goToScreen.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(goToScreen, animated: true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        return genderOptions.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return genderOptions[row]

    }
    
    @objc func criar(){
        emailTexto = userField.text
        senhaTexto = senhaField.text
        let genero = genderOptions[genderPicker.selectedRow(inComponent: 0)]
        
        //print(emailTexto!)
        let rotas = rotaDb.fetchAllServicos()
        for rota in rotas {
            if(genero == rota.1){
                dbHelper.insertUser(email: emailTexto!, senha: senhaTexto!, nomeServico: genero, PrecoServicos: rota.2, StatusReserva: "sem")
                print("Email: \(emailTexto!) Senha: \(senhaTexto!) Rota: \(genero) Preco: \(rota.2)")
            }
        }
        addTransporte()
        
        
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
