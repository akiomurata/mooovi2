class ProductsController < RankingController

  def index
    @products = Products.order('id ASC').limit(20)
  end

  def show
    @product = Products.find(params[:id])
  end

end
