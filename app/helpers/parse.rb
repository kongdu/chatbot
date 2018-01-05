module Parse
  class Movie
    def naver
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

      return [bot_message, img_url]

    end
  end

  class Animal
    def cat
      bot_message = "나만 고양이 없엉"
      url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      cat_xml = RestClient.get(url)
      doc = Nokogiri::XML(cat_xml)
      img_url = doc.xpath("//url").text

      return [bot_message, img_url]

    end
  end
end
