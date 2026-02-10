class GlobalSummary
  include HTTParty
  base_uri "https://api.stackexchange.com/2.2/questions?site=stackoverflow"

  def initialize 
    @options = {}
  end

  def general 
    self.class.get('/', @options)
  end

  def movies
    self.class.get('/movies', @options)
  end
end