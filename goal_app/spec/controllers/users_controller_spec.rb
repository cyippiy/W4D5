require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#index" do 
    
    it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe "#show" do
    
    it "renders the show view" do 
      user = FactoryBot.create(:user, password: "123456")
      get :show, params: {id:user.id}
      expect(response).to render_template(:show)
    end
  end  
  
  describe "#create" do
    
    it "renders the create view" do
      post :create, params: {users: {username: "test",password: "123456"}}
      expect(response).to render_template(:index) 
    end 
  end
  
end
