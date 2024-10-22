//
//  HomeRotaViewController.swift
//  Rota
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class HomeAtividadeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dados = [(nome: String, nomeServico: String, preco: Double, status: String)]()
    let dbHelper = DBHelperUser()

    let tableView = UITableView()
    let lbn = UILabel()
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#203e63")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let homeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rotas", for: .normal)
        //button.background = UIColor.green
        //button.backgroundColor = UIColor(hex: "#00754c")
        button.layer.cornerRadius = 10
        //button.setTitleColor(.white, for: .normal)
        button.tintColor = UIColor(hex: "#203e63")
        return button
    }()
    
    let usersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Transporte", for: .normal)
        //button.setTitleColor(.green, for: .normal)
        button.tintColor = UIColor(hex: "#203e63")
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Atividade", for: .normal)
        //button.setTitleColor(.green, for: .normal)
        button.tintColor = UIColor(hex: "#203e63")
        //button.backgroundColor = .white
        return button
    }()
    
    let sairButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sair", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#203e63")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#f5f5f5")
        let usuarios = dbHelper.fetchAllUsers()
        sairButton.addTarget(self, action: #selector(sair), for: .touchUpInside)

        for usuario in usuarios {
            let nomeL = usuario.email
            let ferra = usuario.nomeServico
            let preco = usuario.PrecoServicos
            let st = usuario.StatusReserva
            if(st == "sem"){
                
                dados.append((nome: nomeL, nomeServico: ferra, preco: preco, status: "Sem inflacoes"))

            }else{
                dados.append((nome: nomeL, nomeServico: ferra, preco: preco, status: st))

            }
            
            //print(" \(usuario.1)")
            
            // print("Nome: \(usuario.4), Ferramenta: \(usuario.8), Preço: \(usuario.9)")
            
        }
        lbn.text = "Atividades"
        lbn.textColor = UIColor(hex: "#203e63")
        lbn.backgroundColor = .white
        lbn.textAlignment = .center
        lbn.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // Configuração da TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(lbn)
        telaConfig()
        homeButton.addTarget(self, action: #selector(homeRota), for: .touchUpInside)
        usersButton.addTarget(self, action: #selector(homeTransporte), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(homeAtividade), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func telaConfig(){
        
        let screenWidth = view.frame.size.width
        //let screenHeight = view.frame.size.height
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        view.addSubview(homeButton)
        view.addSubview(usersButton)
        view.addSubview(logoutButton)
        
        //view.addSubview(addButton)
        view.addSubview(sairButton)

        
        homeButton.frame = CGRect(x: (screenWidth-300)/2, y: 100, width: 80, height: 40)
        usersButton.frame = CGRect(x: ((screenWidth-80)/2), y: 100, width: 80, height: 40)
        
        logoutButton.frame = CGRect(x: ((screenWidth-300)/2)+210, y: 100, width: 80, height: 40)
        
        sairButton.frame = CGRect(x: (largura - (largura-50))/2, y: altura-100, width: largura-50, height: 40)

        lbn.frame = CGRect(x: (largura - (largura-100))/2, y: 180, width: largura-100, height: 70)
        tableView.frame = CGRect(x: 0, y: 250, width: largura, height: altura-150)
        //addButton.frame = CGRect(x: (largura - (largura-50))/2, y: altura-100, width: largura-50, height: 40)
        
    }
    
    @objc func homeRota(){
        let telas = HomeRotaViewController()
        telas.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(telas, animated: true)
    }
    
    @objc func homeTransporte(){
        let telas = HomeTransporteViewController()
        telas.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(telas, animated: true)
    }
    
    @objc func homeAtividade(){
        let telas = HomeAtividadeViewController()
        telas.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(telas, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    
    
    // Função que configura cada célula da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dado = dados[indexPath.row]
        cell.textLabel?.text = "\(dado.nome) -\(dado.status)"
        print(dado)
        return cell
    }
    
    // Função que trata o clique em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(dados[indexPath.row].status != "Sem inflacoes"){
            let detalheVC = DetalhesUserViewController()
            detalheVC.dadoSelecionado = dados[indexPath.row] // Passar os dados para o próximo ViewController
            navigationController?.pushViewController(detalheVC, animated: true) // Navegar para a nova tela

        }else{
            let detalheVC = AddAtividadeViewController()
            detalheVC.dadoSelecionado = dados[indexPath.row] // Passar os dados para o próximo ViewController
            navigationController?.pushViewController(detalheVC, animated: true) // Navegar para a nova tela

        }
    }
    
    @objc func sair(){
        let telas = ViewController()
        telas.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(telas, animated: true)
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
