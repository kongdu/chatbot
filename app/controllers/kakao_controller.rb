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
      bot_message = "콩두 보고싶당"
      url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      cat_xml = RestClient.get(url)
      doc = Nokogiri::XML(cat_xml)
      img_url = doc.xpath("//url").text
    elsif user_message == '영화'
      image = true
      url = "http://movie.naver.com/movie/running/current.nhn?view=list&tab=normal&order=reserve#"
      movie_html = RestClient.get(url)
      doc = Nokogiri::HTML(movie_html)

      movie_list = Array.new
      movies = Hash.new #movies = {}

      doc.css('ul.lst_detail_t1 li').each do |movie|
        movie_title = movie.css('dt a').text
        movie_list << movie_title
        # 배열 # movie_list = ["신과함께", "1987", "쥬만지"]
        movies[movie_title] = {
          :rank => movie.css('dl.info_star span.num').text,
          :url => movie.css('div.thumb img').attribute('src').to_s
        }
        # 해쉬 # movies =
        # :신과함께 => {
        #   :star =>"10"
        # }
      end

      sample_movie = movie_list.sample
      bot_message = sample_movie+" : "+movies[sample_movie][:rank]
      img_url = movies[sample_movie][:url]


    else
      bot_message = "사용 가능한 명령어: '메뉴', '로또(lotto)', '고양이(ㄱㅇㅇ)'"
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
