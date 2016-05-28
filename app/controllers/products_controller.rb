class ProductsController < RankingController

  def index
    @products = Products.order('id ASC').limit(20)
  end


end
