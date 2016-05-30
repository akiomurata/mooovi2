require 'mechanize'

class Scraping

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.moveInfoBox h1').inner_text
    image_url = page.at('.pictBox img')[:src] if page.at('.pictBox img')
    director = page.at('.staffBox a span').inner_text if page.at('.staffBox a span')
    detail = page.at('.outline p').inner_text if page.at('.outline p').inner_text
    open_date = page.at('.opn_date strong').inner_text if page.at('.opn_date strong')

    product = Product.where(title: title, image_url: image_url, director: director, detail: detail, open_date: open_date).first_or_initialize
    product.save
  end

  def self.movie_urls
    links = []
    next_page = "/now/"

    while true do
      agent = Mechanize.new
      current_page = agent.get("http://eiga.com" + next_page)
      elements = current_page.search('.m_unit h3 a')

      elements.each do |ele|
        links << ele[:href]
      end

      next_page = current_page.at('.pagination .next_page')[:href]
    break unless next_page
    end

    links.each do |link|
      Scraping.get_product("http://eiga.com" + link)
    end

  end

end
    # links.each do |link|
    #   product_url = link.get_attribute('href')
    #   puts product_url
    #   # Scraping.get_product("http://eiga.com" + product_url)
    # end




    # while true do
    #   agent = Mechanize.new
    #   current_page = agent.get("http://eiga.com" + next_page)
    #   elements = current_page.search('.m_unit h3 a')
    #     elements.each do |link|
    #       product_url = link[:href]
    #       Scraping.get_product("http://eiga.com" + product_url)
    #     end
    #   next_page = current_page.at('.pagination .next_page')[:href]

    #   break unless
    # end




