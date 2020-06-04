class PriceBoardsController < ApplicationController
  before_action :find_price_board, only: %i[edit update destroy]  

  def index
    @priceBoards = PriceBoard.all.order(price_date: :desc)
  end

  def new
    @price_board = PriceBoard.new
  end

  def create
    @price_board = PriceBoard.new(priceBoard_params)
    if @price_board.save
      redirect_to price_boards_path, notice: "新增成功"
    else
      render :new
    end
  end

  def update
    if @price_board.update(priceBoard_params)
      redirect_to price_boards_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @price_board.destroy
      redirect_to price_boards_path, notice: "刪除成功"
    end
  end

  def edit; end
  def show; end

  private

  def find_price_board
    @price_board = PriceBoard.find(params[:id])
  end

  def priceBoard_params
    params.require(:price_board).permit(:price_date, 
                                        :gold_selling,
                                        :gold_buying, 
                                        :platinum_selling,
                                        :platinum_buying, 
                                        :gold_price_buying, 
                                        :wholesale_gold_selling,
                                        :wholesale_gold_buying,
                                        :wholesale_platinum_selling,
                                        :wholesale_platinum_buying,
                                        :description,
                                        :online)
  end
end