class BillsController < ApplicationController
  include BillFinder

  before_action :authenticate_user!, only: [:follow, :unfollow]

  def show
    @bill = bill_details
  end

  def follow
    find_or_create_alert
    render json: @alert, status: 201
  end

  def unfollow
    find_and_delete_alert
    render json: @alert, status: 202
  end

  private

  def find_or_create_alert
    @alert = current_user.find_alert_for_bill(bill_id)
    @alert ||= current_user.create_alert_for_bill(bill_params)
  end

  def find_and_delete_alert
    @alert = current_user.find_alert_for_bill(bill_id)
    @alert.destroy! if @alert.present?
  end

  def bill_params
    params.permit(:billId, :billName, :billDescription)
  end 
end
