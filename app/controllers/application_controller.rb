class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/bakeries' do
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])

    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    priced = BakedGood.all.order(price: :desc)

    priced.to_json
  end

  get '/baked_goods/most_expensive' do
    # expensive = BakedGood.all.where("price = ?", BakedGood.all.maximum(:price))
    expensive = BakedGood.all.order(price: :desc)[0]

    expensive.to_json(only: [:name, :price])
  end

end
