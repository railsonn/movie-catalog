class HomeController < ApplicationController
  before_action :set_global_summary_service

  def index
    page = params[:page] || 1
    @movies = @summary_service.general(params[:q], page)
  end

  private

  def set_global_summary_service
    @summary_service = GlobalSummary.new
  end
end
