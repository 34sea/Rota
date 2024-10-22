//
//  ViewController.swift
//  Rota
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(hex: String, alpha: CGFloat = 1.0){
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexColor = hexColor.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexColor).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8)/255.0
        let blue = CGFloat((rgb & 0x0000FF))/255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class ViewController: UIViewController {

    let nomeAppField: UILabel = {
        let txt = UILabel()
        txt.text = "ROTA"
        txt.textColor = UIColor(hex: "#15345b")
        //txt.font = UIFont.systemFont(ofSize: 25)
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.textAlignment = .center
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        return txt
    }()
    
    let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Iniciar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#203e63")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        telaConfig()
        
        enterButton.addTarget(self, action: #selector(telaLogin), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func telaConfig(){
        let larguraTela = view.frame.size.width
        let alturaTela = view.frame.size.height
        
        view.addSubview(nomeAppField)
        view.addSubview(enterButton)


        nomeAppField.frame = CGRect(x: (larguraTela-150)/2, y: (alturaTela-60)/2, width: 150, height: 20)
        enterButton.frame = CGRect(x: (larguraTela-(larguraTela-50))/2, y: (alturaTela+10)/2, width: larguraTela-50, height: 40)

    }
    
    @objc func telaLogin(){
        let telas = LoginViewController()
        telas.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(telas, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

