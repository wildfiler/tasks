require 'spec_helper'

describe WelcomeController do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'has to render index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
