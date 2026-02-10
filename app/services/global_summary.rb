class GlobalSummary
  include HTTParty
  base_uri "https://api.tvmaze.com"

  def general 
    self.class.get("/shows?page=0")
  end
  
  def search(query)
    self.class.get("/search/shows", query: { q: query })
  end

  def shows(page = 1)
    self.class.get("/shows", query: { page: page })
  end

  def show(id)
    self.class.get("/shows/#{id}")
  end
end