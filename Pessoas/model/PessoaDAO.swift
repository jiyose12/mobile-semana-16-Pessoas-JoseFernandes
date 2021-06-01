//
//  PessoaDAO.swift
//  Pessoas
//
//  Created by Valéria Cavalcanti on 25/05/21.
//

import Foundation
import UIKit
import CoreData

class PessoaDAO {
    var delegate: AppDelegate!
    
    init() {
        self.delegate = (UIApplication.shared.delegate as! AppDelegate)
    }
    
    func add(nome: String, idade: Int16) {
        let pessoa = Pessoa(context: self.delegate.persistentContainer.viewContext)
        pessoa.nome = nome
        pessoa.idade = idade
        self.delegate.saveContext()
    }
    
    func get() -> Array<Pessoa> {
        let requisicao:NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        do {
            let pessoas = try self.delegate.persistentContainer.viewContext.fetch(requisicao)
            return pessoas
        } catch {
            return Array<Pessoa>()
        }
    }
    
    func findByName(nome: String) -> Array<Pessoa> {
        let requisicao:NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        let predicate = NSPredicate(format: "nome CONTAINS[c] %@", nome)
        requisicao.predicate = predicate
        do {
            let pessoas = try self.delegate.persistentContainer.viewContext.fetch(requisicao)
            return pessoas
        } catch {
            return Array<Pessoa>()
        }
    
    }
    
    func del(pessoa: Pessoa){
        self.delegate.persistentContainer.viewContext.delete(pessoa)
        self.delegate.saveContext()
    }
    
    func update(){
        self.delegate.saveContext()
    }
}
