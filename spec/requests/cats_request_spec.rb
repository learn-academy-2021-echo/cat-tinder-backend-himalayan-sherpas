require 'rails_helper'

RSpec.describe "Cats", type: :request do
  cat_1 = {name: 'Felix', age: 2, enjoys: 'Eating and sleeping', image: 'https://static.wikia.nocookie.net/disneyfanon/images/e/e8/Felix_The_Cat.png'}
  cat_update = {name: 'Max', age: 3, enjoys: 'Moving and grooving', image: 'https://www.boredpanda.com/blog/wp-content/uploads/2018/11/funny-dancing-cats-101-5bf08f6996330__700.jpg'}
  bad_cat_data = {name: nil, age: nil, enjoys: nil, image: nil}
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create(cat_1)
      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end
  describe "POST /create" do
    it "creates a cat" do
      cat_params = {cat: cat_1}
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq cat_1[:name]
      expect(cat.age).to eq cat_1[:age]
      expect(cat.enjoys).to eq cat_1[:enjoys]
      expect(cat.image).to eq cat_1[:image]
    end
    it "doesn't create a cat without a name" do
      cat_params = {cat: {fake_params: "stuff"}}
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
      expect(json['age']).to include "can't be blank"
      expect(json['enjoys']).to include "can't be blank"
      expect(json['image']).to include "can't be blank"
    end
  end
  describe "PATCH /update" do
    it "updates a cat" do
      Cat.create(cat_1)
      felix = Cat.first
      new_cat_params = {cat: cat_update}
      patch "/cats/#{felix.id}", params: new_cat_params
      max = Cat.first
      max.update(cat_update)
      max = Cat.first
      expect(response).to have_http_status(200)
      expect(max.name).to eq cat_update[:name]
      expect(max.age).to eq cat_update[:age]
      expect(max.enjoys).to eq cat_update[:enjoys]
      expect(max.image).to eq cat_update[:image]
    end
    it "validates updated cat information is correct" do
      Cat.create(cat_1)
      felix = Cat.first
      new_cat_params = {cat: bad_cat_data}
      patch "/cats/#{felix.id}", params: new_cat_params
      felix.update(bad_cat_data)
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
      expect(json['age']).to include "can't be blank"
      expect(json['enjoys']).to include "can't be blank"
      expect(json['image']).to include "can't be blank"
    end
  end
  describe "DELETE /destroy" do
    it "delete a cat" do
      Cat.create(cat_1)
      felix = Cat.first
      cats = Cat.all
      expect(cats.length).to eq 1
      delete "/cats/#{felix.id}"
      felix.destroy
      expect(response).to have_http_status(200)
      cats = Cat.all
      expect(cats.length).to eq 0
    end
  end
end