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

  def destroy
    Alert.delete(alert.id) # avoid the generated where(alert_type: ...)
    flash[:notice] = "Deleted alert #{alert.name}"
    redirect_to alerts_path
  end

  def send_mail
    AlertMailer.user_alert(alert).deliver_later
    alert.mark_as_sent
    flash[:notice] = 'Email alert is on its way'
    redirect_to alert_path(alert)
  end

  private

  def alert_params
    params.require(:alert).permit(:name, :description, :query, :alert_type)
  end

  def alert
    @alert ||= Alert.find_by(uuid: params[:id])
  end
end
