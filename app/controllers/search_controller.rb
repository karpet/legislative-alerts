class SearchController < ApplicationController
  include FormHelper
  include BillFinder

  def index
    return unless query.present?
    return unless query?

    @bills = OpenStates::Bill.where(query)
  end

  def show
    query
    @bills = [bill_details]
    render :index
  end

  def follow
    find_or_create_alert
    render json: @alert, status: 201
  end

  def unfollow
    find_and_delete_alert
    render json: @alert, status: 202
  end

  def bill
    @bill = bill_details
    render json: @bill
  end

  private

  def find_or_create_alert
    @alert = current_user.find_alert_for_search(search_params)
    @alert ||= current_user.create_alert_for_search(search_params)
  end

  def find_and_delete_alert
    @alert = current_user.find_alert_for_search(search_params)
    @alert.destroy! if @alert.present?
  end

  def search_params
    return {} unless params[:search]
    params.require(:search).permit(:q, :state, :page, :per_page)
  end

  def text_query
    return unless search_params[:q].present?
    search_params[:q].split.join(' & ')
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

  def query?
    text_query.present? || state_filter.present?
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
