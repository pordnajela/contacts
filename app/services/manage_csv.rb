require 'csv'

class ManageCsv

  def initialize(params={})
    # @csv_file_path = params[:file_path]
    # @admin = params[:admin]
  end

  def call
    begin
      return_message(true, {})
    rescue => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      return_message(false, {error: I18n.t("onboarding_wizard.upload_users_csv.error")})
    end
  end

  private

  def return_message(success, payload={})
    OpenStruct.new({success?: success, payload: payload})
  end
  
end