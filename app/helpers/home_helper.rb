module HomeHelper
  def changing_data_access(result)
    if result.respond_to?(:to_sql)
      ""
    else
      puts "e a requisicao da api =================="
    end
  end

  def format_text(text)
    return "" if text.blank?

    text
      .downcase          # deixa tudo minúsculo
      .delete('"\'')     # remove aspas simples e duplas
  end
end
