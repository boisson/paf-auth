require 'httparty'
require 'json'

module ProtesteAuth
  class Consumers

    def self.user_by_id(id)
      get_json("/request_user", { id: id })
    end

    def self.get_json(path, query = nil)
      webservice_url = "#{Rails.application.config.acccess_control_2_api_url}" rescue "http://localhost:9999/api"
      begin
        response        = nil
        response = HTTParty.get("#{webservice_url}#{path}", :query => query )
        
        json = JSON.parse(response.body)
        if json.is_a?(Array) && json[0] == "error"
          raise 'error in webservice'
        end

        json
      rescue => exception
        message = []
        message << 'ACA2 webservice its off'
        message << 'The following request can\'t be accessed'
        message << "url: #{webservice_url}#{path}"
        message << "params: #{query}"
        e = Exception.new(message.join("\n"))
        e.set_backtrace(exception.backtrace)
        ErrorReportMailer.report(e).deliver
        raise 'error in webservice'
      end
    end
  end
end