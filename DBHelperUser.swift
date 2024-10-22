//
//  DBHelperUser.swift
//  MecanicApp
//
//  Created by Elisio Simao on 10/15/24.
//  Copyright © 2024 Cleyton&Samir. All rights reserved.
//DBHelperUser

import Foundation
import SQLite3

class DBHelperUser {
    var db: OpaquePointer?
    
    init() {
        db = openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer? {
        let dbPath = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("transporteRota.sqlite").path
        
        var db: OpaquePointer? = nil
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database.")
            return db
        } else {
            print("Unable to open database.")
            return nil
        }
    }
    
    // Criando a tabela 'userMecanic'
    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS userMecanic(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        senha TEXT,
        nomeServico TEXT,
        PrecoServicos DOUBLE,
        StatusReserva TEXT);
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table created.")
            } else {
                print("Table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Função para inserir dados no banco
    func insertUser(email: String, senha: String, nomeServico: String, PrecoServicos: Double, StatusReserva: String) {
        let insertStatementString = "INSERT INTO userMecanic (email, senha, nomeServico, PrecoServicos, StatusReserva) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (senha as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (nomeServico as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 4, PrecoServicos)
            sqlite3_bind_text(insertStatement, 5, (StatusReserva as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Função para atualizar os campos 'nomeServico', 'PrecoServicos', e 'StatusReserva'
    func updateUser(email: String, nomeServico: String, PrecoServicos: Double, StatusReserva: String) {
        let updateStatementString = "UPDATE userMecanic SET nomeServico = ?, PrecoServicos = ?, StatusReserva = ? WHERE email = ?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (nomeServico as NSString).utf8String, -1, nil)
            sqlite3_bind_double(updateStatement, 2, PrecoServicos)
            sqlite3_bind_text(updateStatement, 3, (StatusReserva as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (email as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
    
    // Função para buscar todos os usuários
    func fetchAllUsers() -> [(email: String, senha: String, nomeServico: String, PrecoServicos: Double, StatusReserva: String)] {
        let queryStatementString = "SELECT * FROM userMecanic;"
        var queryStatement: OpaquePointer? = nil
        var users: [(email: String, senha: String, nomeServico: String, PrecoServicos: Double, StatusReserva: String)] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let email = String(cString: sqlite3_column_text(queryStatement, 1))
                let senha = String(cString: sqlite3_column_text(queryStatement, 2))
                let nomeServico = String(cString: sqlite3_column_text(queryStatement, 3))
                let PrecoServicos = sqlite3_column_double(queryStatement, 4)
                let StatusReserva = String(cString: sqlite3_column_text(queryStatement, 5))
                
                users.append((email: email, senha: senha, nomeServico: nomeServico, PrecoServicos: PrecoServicos, StatusReserva: StatusReserva))
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        sqlite3_finalize(queryStatement)
        return users
    }
    
    func countUser() -> Int {
        let countQuery = "SELECT COUNT(*) FROM userMecanic;"
        var countStatement: OpaquePointer? = nil
        var count: Int = 0
        
        if sqlite3_prepare_v2(db, countQuery, -1, &countStatement, nil) == SQLITE_OK {
            if sqlite3_step(countStatement) == SQLITE_ROW {
                count = Int(sqlite3_column_int(countStatement, 0))
            } else {
                print("Erro ao contar os serviços")
            }
        } else {
            print("Erro ao preparar a contagem")
        }
        sqlite3_finalize(countStatement)
        return count
    }
}
