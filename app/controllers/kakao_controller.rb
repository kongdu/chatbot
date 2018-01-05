require 'parse'

class KakaoController < ApplicationController
  def keyboard
    home_keyboard = {
      :type => "text",
    }
    render json: home_keyboard
  end

  def message
    image = false
    user_message = params[:content]

    if user_message == '메뉴'
      menus = ["호반정", "시골집", "순남시래기", "양자강", "두부마을"]
      bot_message = menus.sample
    elsif user_message == '로또' || user_message == 'lotto'
      lotto = (1..45).to_a.sample(6).to_s
      bot_message = lotto
    elsif user_message == '고양이' || user_message == 'ㄱㅇㅇ'
      image = true
      parser = Parse::Animal.new
      bot_message = parser.cat[0]
      img_url = parser.cat[1]

    elsif user_message == '영화'
      image = true
      parser = Parse::Movie.new
      one_movie = parser.naver
      bot_message = one_movie[0]
      img_url = one_movie[1]


    else
      bot_message = "사용 가능한 명령어: 메뉴, 로또, 고양이, 영화"
    end

    return_message = {
      :message => {
        :text => bot_message
      },
      :keyboard =>{
        :type => "text"
      }
    }
    return_message_with_img = {
      :message =>{
        :text => bot_message,
        :photo=> {
          :url =>img_url,
          :width => 640,
          :height => 480
        }
      },
      :keyboard =>{
        :type=> "text"
      }
    }
    if image
      render json: return_message_with_img
    else
      render json: return_message
    end
  end
end
