class SearchController < ApplicationController
  include FormHelper

  def index
    Rails.logger.debug("query:#{query.inspect}")
    return unless text_query.present?

    @bills = OpenStates::Bill.where(query)
  end

  def show
    query
    @bills = [OpenStates::Bill.find_by_openstates_id(params[:id])]
    render :index
  end

  private

  def search_params
    return {} unless params[:search]
    params.require(:search).permit(:q, :state, :page, :per_page)
  end

  def text_query
    search_params[:q]
  end

  def state_filter
    search_params[:state]
  end

  def page
    search_params[:page] || '1'
  end

  def per_page
    search_params[:per_page] || '10'
  end

  def query
    @query ||= build_query
  end

  def build_query
    query = {}
    query[:state] = state_filter if state_filter.present?
    query[:q] = text_query if text_query.present?
    query[:page] = page if page.present?
    query[:per_page] = per_page if per_page.present?
    query
  end
end
