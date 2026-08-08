module ApplicationHelper
  # metodo para formatar o email do usuario, pegando apenas a parte antes do @ e capitalizando a primeira letra
  def format_email(email)
    email.split('@').first.capitalize 
  end
end
