class HomeController < ApplicationController
  before_action :set_global_summary_service

  def index
    @movies = @summary_service.general
  end

  def movies
    @movies = @summary_service.movies
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
