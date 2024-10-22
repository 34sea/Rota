//
//  DBHelperServicos.swift
//  MecanicApp
//
//  Created by Elisio Simao on 10/15/24.
//  Copyright © 2024 Cleyton&Samir. All rights reserved.
//DBHelperServicos

import Foundation
import SQLite3

class DBHelperRota {
    var db: OpaquePointer?
    
    // Inicializa o banco de dados e cria a tabela servicosMecanic
    init() {
        db = openDatabase()
        createServicosTable()
    }
    
    // Função para abrir o banco de dados
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("rotaDb.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
            return nil
        } else {
            print("Banco de dados aberto com sucesso")
            return db
        }
    }
    
    // Função para criar a tabela servicosMecanic com os campos nome e preco
    func createServicosTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS servicosMecanic (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            preco DOUBLE
        );
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela servicosMecanic criada com sucesso")
            } else {
                print("Erro ao criar a tabela servicosMecanic")
            }
        } else {
            print("Erro ao preparar a criação da tabela")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Função para adicionar um serviço na tabela servicosMecanic
    func insertServico(nome: String, preco: Double) {
        let insertQuery = "INSERT INTO servicosMecanic (nome, preco) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (nome as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 2, preco)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Serviço adicionado com sucesso")
            } else {
                print("Erro ao adicionar serviço")
            }
        } else {
            print("Erro ao preparar a inserção")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Função para atualizar o nome e o preço de um serviço
    func updateServico(id: Int, novoNome: String, novoPreco: Double) {
        let updateQuery = "UPDATE servicosMecanic SET nome = ?, preco = ? WHERE id = ?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (novoNome as NSString).utf8String, -1, nil)
            sqlite3_bind_double(updateStatement, 2, novoPreco)
            sqlite3_bind_int(updateStatement, 3, Int32(id))
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Serviço atualizado com sucesso")
            } else {
                print("Erro ao atualizar serviço")
            }
        } else {
            print("Erro ao preparar a atualização")
        }
        sqlite3_finalize(updateStatement)
    }
    
    // Função para listar todos os serviços
    func fetchAllServicos() -> [(Int, String, Double)] {
        let query = "SELECT id, nome, preco FROM servicosMecanic;"
        var fetchStatement: OpaquePointer? = nil
        var servicos: [(Int, String, Double)] = []
        
        if sqlite3_prepare_v2(db, query, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let nome = String(cString: sqlite3_column_text(fetchStatement, 1))
                let preco = sqlite3_column_double(fetchStatement, 2)
                
                servicos.append((id, nome, preco))
            }
        } else {
            print("Erro ao buscar serviços")
        }
        sqlite3_finalize(fetchStatement)
        return servicos
    }
    
    // Função para apagar um serviço pelo id
    func deleteServico(id: Int) {
        let deleteQuery = "DELETE FROM servicosMecanic WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Serviço apagado com sucesso")
            } else {
                print("Erro ao apagar serviço")
            }
        } else {
            print("Erro ao preparar a exclusão")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func countServicos() -> Int {
        let countQuery = "SELECT COUNT(*) FROM servicosMecanic;"
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
