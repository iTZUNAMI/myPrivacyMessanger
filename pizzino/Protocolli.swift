//
//  Protocolli.swift
//  pizzino
//
//  Created by PERSEO on 09/06/16.
//  Copyright © 2016 Mattia Azzena. All rights reserved.
//

import Foundation

//delegato per tutte le impostazioni della table alla view principale
protocol OpzioniDelegate {
    func dataChanged(impo: OpzioniModel)
}


//delegato utilizzato per le celle password e url che riportano i dati sulla table

protocol SetPasswordDelegate {
    func aggiornaSetPasswordDelegate (valore : String)
}

protocol SetRedirectDelegate {
    func aggiornaSetRedirectDelegate (valore : String)
}


protocol SetRedirectWebViewDelegate {
   // func aggiornaSetRedirectDelegate (valore : String)
}

protocol SetShowMessageDelegate {
    func aggiornaSetShowMessageDelegate (valore : String)
}

protocol SetMaskingDelegate {
    func aggiornaSetMaskingDelegate (valore : String)
}
