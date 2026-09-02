function validarChamado(titulo: string): boolean {
    if (!titulo) {
        throw new Error("O título do chamado não pode ser vazio.");
    }

    return true;
}

export default validarChamado;