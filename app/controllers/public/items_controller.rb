class Public::ItemsController < ApplicationController
  def item_search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
    @outdoors_items = RakutenWebService::Ichiba::Item.search(keyword: "登山調理")
  end
end
