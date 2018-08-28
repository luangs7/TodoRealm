//
//  RoutesResource.swift
//  Ninky
//
//  Created by Squarebits on 19/07/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

class RoutesResource: NSObject {
    static internal let endpoint = "https://ninky.herokuapp.com/api/v1"
    
    
    //    POST REQUEST
    static internal let login = "/login"
    static internal let cadastro = "/cadastrar"
    static internal let favoritos = "/favoritos"
    static internal let search = "/buscar"
    static internal let updateUser = "/atualizar"
    static internal let updateImage = "/atualizar"
    static internal let createAutoral = "/autorais/register"
    static internal let createPortifolio = "/portifolios/register"
    
    //    GET REQUEST
    static internal let session = "/perfil"
    static internal let getEstilos = "/estilos"
    static internal let home = "/home"
    static internal let getPortifolios = "/portifolios"
    static internal let getAutorais = "/autorais"
    static internal let getFiltro = "/filtro"
    static internal let getTatuador = "/tatuadores"
    
    //    DELETE REQUEST
    static internal let delPortifolio = "/portifolios"
    static internal let delAutoral = "/autorais"
    
    
    
}

