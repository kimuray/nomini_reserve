class Admin::SystemSettingsController < AdminController
  before_action :set_system_settings

  def index
  end

  def update
    @system_setting = SystemSetting.find(params[:id])

    if @system_setting.update(system_setting_params)
      redirect_to admin_system_settings_url, notice: t("system_setting.#{@system_setting.config_name}") + "を修正しました"
    else
      render :index
    end
  end

  private

  def set_system_settings
    @system_settings = SystemSetting.all
  end

  def system_setting_params
    params.fetch(:system_setting, {}).permit(:value)
  end
end
