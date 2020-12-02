class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
  end

end
