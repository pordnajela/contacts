require 'csv'

class ManageCsv

  def initialize(params={})
    @csv_file_path = params[:file_path]
  end

  def call
    begin

      # Detect file encoding
      detection = CharlockHolmes::EncodingDetector.detect(File.read(@csv_file_path))
      encoding = (detection[:encoding] == 'UTF-8') ? detection[:encoding].downcase : "#{detection[:encoding].downcase}:utf-8"
      # Read file and transform encoding to UTF-8
      file_content = File.open(@csv_file_path, "r:#{encoding}"){|f| f.read}
      # Replace semicolon separator for comma
      file_content = file_content.gsub(';', ',')

      # 

      return_message(true, {})
    rescue => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      return_message(false, {})
    end
  end

  private

  def return_message(success, payload={})
    OpenStruct.new({success?: success, payload: payload})
  end
  
end