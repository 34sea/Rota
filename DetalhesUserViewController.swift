//
//  DetalhesUserViewController.swift
//  Rota
//
//  Created by Elisio Simao on 10/21/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import UIKit

class DetalhesUserViewController: UIViewController {
    
    let dbHelper = DBHelperUser()
    var dadoSelecionado: (nome: String, nomeServico: String, preco: Double, status: String)?
    var nome: String?
    var inflacao: String?
    let nomelabel: UILabel = {
        let txt = UILabel()
        txt.text = ""
        return txt;
    }()
    
    let nomeL: UILabel = {
        let txt = UILabel()
        txt.text = "Nome:"
        return txt;
    }()
    
    let inflacaolabel: UILabel = {
        let txt = UILabel()
        txt.text = ""
        return txt;
    }()
    
    let inflacaoL: UILabel = {
        let txt = UILabel()
        txt.text = "Inflacao:"
        return txt;
    }()
    
    let linha: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let alugarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retirar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#203e63")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white;
        nome = dadoSelecionado?.nome
        inflacao = dadoSelecionado?.status
        print(dadoSelecionado);
        
        layout()
        
        alugarButton.addTarget(self, action: #selector(retirar), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func layout(){
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        view.addSubview(nomelabel);
        view.addSubview(nomeL);
        view.addSubview(linha)
        view.addSubview(inflacaolabel)
        view.addSubview(inflacaoL)
        view.addSubview(alugarButton)

        nomelabel.text = nome!
        inflacaolabel.text = inflacao!
        
        nomelabel.frame = CGRect(x: 100, y: (altura - 100)/2, width: 200, height: 30)
        nomeL.frame = CGRect(x: 40, y: (altura - 100)/2, width: 80, height: 30)
        linha.frame = CGRect(x: 0, y: (altura - 32)/2, width: largura, height: 0.5)
        
        inflacaolabel.frame = CGRect(x: 110, y: (altura - 30)/2, width: 200, height: 30)
        inflacaoL.frame = CGRect(x: 40, y: (altura - 30)/2, width: 80, height: 30)
       // linha.frame = CGRect(x: 0, y: (altura - 38)/2, width: largura, height: 0.5)
        if(inflacao != "Sem inflacoes"){
            alugarButton.frame = CGRect(x: (largura - (largura-50))/2, y: altura - 100, width: largura-50, height: 50)
        }

        
    }
    
    @objc func retirar(){
        let users = dbHelper.fetchAllUsers();
        for user in users {
            print("nome: \(user.email)")
            if(nome == user.email){
                dbHelper.updateUser(email: nome!, nomeServico: user.nomeServico, PrecoServicos: user.PrecoServicos, StatusReserva: "Sem inflacoes")
                let tela = HomeAtividadeViewController()
                tela.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(tela, animated: true)
            }
        }
       //
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
