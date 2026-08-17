module Request
  class CategoryFilm

    # Mapeamento dos IDs de gêneros utilizados pela API do TMDB
    # para os respectivos nomes dos gêneros em português.
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

    # Lista de gêneros que serão disponibilizados para o usuário
    # como opções de filtro ou categorias de filmes.
    CATEGORIES_GENRES = [
      "Ação",
      "Aventura",
      "Comédia",
      "Crime",
      "Drama",
      "Fantasia",
      "Terror",
      "Mistério",
      "Romance",
      "Ficção científica",
      "Guerra",
      "Faroeste"
    ]

    # Retorna a lista de gêneros disponíveis para serem exibidos
    # nas categorias de filmes.
    def categories_genres
      @movie_genres = CATEGORIES_GENRES
    end

    # Busca filmes pertencentes a um determinado gênero.
    # Recebe o nome do gênero e o número da página desejada.
    def categories_list_movies(genre, page)

      # Converte o nome do gênero informado para o ID correspondente
      # utilizado pela API do TMDB.
      genre_id = format_genre_to_id(genre)

      # Realiza a busca dos filmes através do serviço responsável
      # pela comunicação com a API do TMDB.
      response = TmdbService.search_categories(genre_id, page)
      
      # Verifica se a resposta da API é válida e possui resultados.
      if valid_response?(response)

        # Remove filmes duplicados utilizando o ID do filme
        # como identificador único.
        unique_results = response["results"].uniq { |movie| movie["id"]}

        # Percorre os filmes encontrados para converter os IDs
        # dos gêneros em seus respectivos nomes.
        unique_results.each { |result| format_genres(result)}
      end
    end

    private 

    # Verifica se a resposta da API existe, possui a chave "results"
    # e contém pelo menos um filme.
    def valid_response?(response)
      response && response["results"] && !response["results"].empty?
    end

    # Converte os IDs dos gêneros retornados pela API
    # para os nomes dos gêneros em português.
    def format_genres(result)
      binding.irb
      # Percorre cada ID de gênero presente no filme.
      result["genre_ids"].each_with_index do |genre_id, i| 
        # Substitui o ID pelo nome correspondente no hash
        # TMDB_MOVIE_GENRES.
        result["genre_ids"][i] = TMDB_MOVIE_GENRES[genre_id]
      end
      .compact
      .join(", ")
    end

    # Converte o nome de um gênero para o ID correspondente
    # utilizado pela API do TMDB.
    def format_genre_to_id(genre)

      # Inverte o hash para que seja possível encontrar o ID
      # utilizando o nome do gênero como chave.
      genres_invert = TMDB_MOVIE_GENRES.invert

      # Retorna o ID correspondente ao gênero informado.
      genres_invert[genre]
    end
  end
end
