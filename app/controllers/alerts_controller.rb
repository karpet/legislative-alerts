class AlertsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.create(alert_params.merge(user: current_user))
    redirect_to alert
  end

  def show
    alert
  end

  def edit
    alert
  end

  def update
    alert.update!(alert_params)
    redirect_to alert
  end

  private

  def alert_params
    params.require(:alert).permit(:name, :description, :query)
  end

  def alert
    @alert ||= Alert.find_by(uuid: params[:id])
  end
end
