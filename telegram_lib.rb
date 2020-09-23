require 'http'
require 'json'

class Telegram
  def initialize(token)
    @token = token
    @endpoint = 'https://api.telegram.org/'
  end

  def send_request(method, params: nil)
    if params == nil
      request = HTTP.get(@endpoint + "bot" + @token + "/" + method)
    else
      request = HTTP.get(@endpoint + "bot" + @token + "/" + method, :params => params)
    end
    # puts request.body
    JSON.parse(request.body)
  end

  def send_message(chat_id, text)
    self.send_request("sendMessage", params: {chat_id: chat_id, text: text})
  end

  def send_photo(chat_id, photo)
    HTTP.post(@endpoint + "bot" + @token + "/" + "sendPhoto", :form => { :chat_id => chat_id,
                                                                                   :photo => HTTP::FormData::File.new(photo)
    })

  end
end
