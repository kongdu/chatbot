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
    elsif user_message == '로또'
      lotto = (1..45).to_a.sample(6).to_s
      user_message = lotto
    else
      user_message = "사용 가능한 명령어 : '메뉴', '로또'를 입력해보세요"
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
