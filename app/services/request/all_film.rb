module Request
  class AllFilm

    # Termos utilizados para realizar buscas gerais quando o usuário
    # não informa um título específico.
    CURRENT_TITLES = ["movie", "man", "the"]

    # Mapeamento dos IDs de gêneros utilizados pela API do TMDB
    # para seus respectivos nomes em português.
    TMDB_MOVIE_GENRES = {
      28 => "Ação",
      12 => "Aventura",
      16 => "Animação",
      35 => "Comédia",
      80 => "Crime",
      99 => "Documentário",
      18 => "Drama",
      10751 => "Família",
      14 => "Fantasia",
      36 => "História",
      27 => "Terror",
      10402 => "Música",
      9648 => "Mistério",
      10749 => "Romance",
      878 => "Ficção científica",
      10770 => "Cinema TV",
      53 => "Thriller",
      10752 => "Guerra",
      37 => "Faroeste"
    }

    # Realiza uma busca por filmes utilizando o título informado.
    # Caso nenhum título seja informado, realiza buscas utilizando
    # os termos definidos em CURRENT_TITLES.
    def general(title, page)
      # Array que armazenará os resultados encontrados nas buscas.
      results = []

      # Verifica se o usuário não informou um título para pesquisa.
      if title.blank?
        # Percorre cada termo definido em CURRENT_TITLES
        # para realizar buscas recentes no TMDB.
        CURRENT_TITLES.each do |search_term|
          response = TmdbService.search_recent(search_term, page)

          # Adiciona os filmes encontrados ao array de resultados
          # somente quando a resposta da API é válida.
          results += response["results"] if valid_response?(response)
        end
      else
        # Caso o usuário informe um título, realiza uma busca
        # diretamente pelo título informado.
        response = TmdbService.search(title, page)

        # Adiciona os resultados somente se a resposta da API for válida.
        results += response["results"] if valid_response?(response)
      end

      # Remove filmes duplicados utilizando o ID do filme como referência.
      unique_results = results.uniq { |movie| movie["id"]}

      # Percorre os resultados únicos para converter os IDs dos gêneros
      # retornados pela API em seus respectivos nomes.
      unique_results.each{ |result| format_genres(result) }
    end

    private 

    # Verifica se a resposta da API existe, possui a chave "results"
    # e contém pelo menos um resultado.
    def valid_response?(response)
      response && response["results"] && !response["results"].empty?
    end

    # Converte os IDs dos gêneros retornados pelo TMDB
    # para seus respectivos nomes em português.
    def format_genres(result)
      # Percorre os IDs dos gêneros do filme e substitui cada ID
      # pelo nome correspondente encontrado no hash TMDB_MOVIE_GENRES.
      result["genre_ids"].each_with_index do |genre_id, i| 
        result["genre_ids"][i] = TMDB_MOVIE_GENRES[genre_id]
      end

      # Remove valores nulos e junta os nomes dos gêneros
      # em uma única string, separados por vírgula.
      .compact
      .join(", ")
    end
  end
end
