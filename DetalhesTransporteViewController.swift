//
//  DetalhesUserViewController.swift
//  Rota
//
//  Created by Elisio Simao on 10/21/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import UIKit

class DetalhesTransporteViewController: UIViewController {
    
    let dbHelper = DBHelperUser()
    var dadoSelecionado: (nome: String, ferramenta: String, preco: Double)?
    var nome: String?
    var inflacao: String?
    var preco: Double?
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
        txt.text = "Rota:"
        return txt;
    }()
    
    let precolabel: UILabel = {
        let txt = UILabel()
        txt.text = ""
        return txt;
    }()
    
    let precoL: UILabel = {
        let txt = UILabel()
        txt.text = "Preco:"
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
    
    let linha2: UILabel = {
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
        inflacao = dadoSelecionado?.ferramenta
        preco = dadoSelecionado?.preco
        //print(dadoSelecionado);
        layout()
        // Do any additional setup after loading the view.
    }
    
    func layout(){
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        view.addSubview(nomelabel);
        view.addSubview(nomeL);
        view.addSubview(linha)
        view.addSubview(linha2)
        view.addSubview(inflacaolabel)
        view.addSubview(inflacaoL)
        view.addSubview(precolabel)
        view.addSubview(precoL)
        
        nomelabel.text = nome!
        inflacaolabel.text = inflacao!
        precolabel.text = "\(preco!)"
        
        nomelabel.frame = CGRect(x: 100, y: (altura - 100)/2, width: 200, height: 30)
        nomeL.frame = CGRect(x: 40, y: (altura - 100)/2, width: 80, height: 30)
        linha.frame = CGRect(x: 0, y: (altura - 32)/2, width: largura, height: 0.5)
        
        inflacaolabel.frame = CGRect(x: 90, y: (altura - 30)/2, width: 200, height: 30)
        inflacaoL.frame = CGRect(x: 40, y: (altura - 30)/2, width: 80, height: 30)
        linha2.frame = CGRect(x: 0, y: (altura + 40)/2, width: largura, height: 0.5)
        
        precolabel.frame = CGRect(x: 100, y: (altura + 50)/2, width: 200, height: 30)
        precoL.frame = CGRect(x: 40, y: (altura + 50)/2, width: 80, height: 30)
        
        
        
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
