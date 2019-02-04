class BillsController < ApplicationController
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

  def bill_details
    # for backcompat, test if we are base64 encoded
    Rails.logger.debug("bill id #{bill_id}")
    OpenStates::Bill.try_find_by_os_bill_id(bill_id, current_user, Rails.logger)
  end

  def find_or_create_alert
    @alert = current_user.find_alert_for_bill(bill_id)
    @alert ||= current_user.create_alert_for_bill(bill_params)
  end

  def find_and_delete_alert
    @alert = current_user.find_alert_for_bill(bill_id)
    @alert.destroy! if @alert.present?
  end

  def bill_id
    params.require(:id)
  end

  def bill_params
    params.permit(:billId, :billName, :billDescription)
  end 
end
