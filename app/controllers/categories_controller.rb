class CategoriesController < ApplicationController
  before_action :set_global_summary_service


  def index
    @movies = @summary_service.categories(10751)
    transform_requests_result(@movies)
  end



  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
