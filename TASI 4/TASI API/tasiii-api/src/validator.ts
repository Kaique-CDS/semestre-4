function validarChamado(titulo: string): boolean {
  if (!titulo || titulo.trim() === "") {
    throw new Error("O título do chamado não pode ser vazio.");
  }

  return true;
}

export default validarChamado;