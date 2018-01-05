class KakaoController < ApplicationController
  def keyboard
    home_keyboard = {
      :type => "text",
    }
    render json: home_keyboard
  end

  def message
    user_message = params[:content]
    return_message = {
      :message => {
        :text => user_message
      },
      :keyboard =>{
        :type => "text"
      }
    }
    render json: return_message
  end
end
