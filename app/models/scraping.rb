class Scraping

require 'mechanize'

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.moveInfoBox h1').inner_text
    image_url = page.at('.pictBox img')[:src]
    director = page.at('.staffBox a span').inner_text
    detail = page.at('.outline p').inner_text
    open_date = page.at('.opn_date strong').inner_text

    product = Products.where(title: title, image_url: image_url, director: director, detail: detail, open_date: open_date).first_or_initialize
    product.save
  end

  def self.movie_urls
    links = []
    agent = Mechanize.new
    page = agent.get("http://eiga.com/now/")
    elements = page.search('.m_unit h3 a')
    elements.each do |link|
      product_url = link[:href]
      Scraping.get_product("http://eiga.com" + product_url)
    end
  end

end



