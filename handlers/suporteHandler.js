function suporteN1(chamado){
    console.log("N1 recebeu chamado")
    if(chamado.prioridade == "normal"){
        console.log("N1 assumiu chamado")
        return "Suporte N1 atendeu o chamado"
    } 
    console.log("N1 não conseguiu resolver")
    console.log("Encaminhado para N2")
    return suporteN2(chamado)
}
function suporteN2(chamado){
    console.log("N2 recebeu chamado")
    if(chamado.prioridade == "media"){
        console.log("N2 assumiu chamado")
        return "Suporte N2 atendeu o chamado"
    } 
    console.log("N2 não conseguiu resolver")
    console.log("Encaminhado para especialista")
    return especialista(chamado)
}
function especialista(chamado){
    console.log("especialista recebeu chamado")
    if(chamado.prioridade == "alta"){
        console.log("especialista assumiu chamado")
        return "Suporte especialista atendeu o chamado"
    } 

    throw new Error("Nenhum especialista encontrado")
}

module.exports = {
    suporteN1
}