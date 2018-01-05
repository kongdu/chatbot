class KakaoController < ApplicationController
  def keyboard
    home_keyboard = {
      :type => "text",
    }
    render json: home_keyboard
  end

  def message
    user_message = params[:content]

    if user_message == '메뉴'
      menus = ["20층", "시골집", "순남시래기", "양자강", "두부마을"]
      user_message = menus.sample
    end

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
