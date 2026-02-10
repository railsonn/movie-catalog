class HomeController < ApplicationController
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    title = params[:q]
    @movies = @summary_service.general(title, page)
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
