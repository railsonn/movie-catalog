  def general(title, page)
    results = []

    if title.blank?
      CURRENT_TITLES.each do |search_term|
        response = TmdbService.search_recent(search_term, page)
        results += response["results"] if valid_response?(response)
      end
    else
      response = TmdbService.search(title, page)
      results += response["results"] if valid_response?(response)
    end

    unique_results = results.uniq { |movie| movie["id"]}

    # funcao para atribuir os generos em string para cada id do genre_ids
    unique_results.each{ |result| format_genres(result) }
  end