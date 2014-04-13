require 'spec_helper'

describe UsersController do
  describe 'for not admin' do
    login_user
    describe "GET index" do
      it "redirects to root" do
        get :index
        expect(response).to redirect_to root_url
      end
    end

    describe "GET show" do
      it "redirects to root" do
        user = create :user
        get :show, {:id => user.to_param}
        expect(response).to redirect_to root_url
      end
    end

    describe "GET new" do
      it "redirects to root" do
        get :new
        expect(response).to redirect_to root_url
      end
    end

    describe "GET edit" do
      it "redirects to root" do
        user = create :user
        get :edit, {:id => user.to_param}
        expect(response).to redirect_to root_url
      end
    end

    describe "POST create" do
      it "redirects to root" do
        post :create, {:user => attributes_for(:user)}
        expect(response).to redirect_to root_url
      end
    end

    describe "PUT update" do
      it "redirects to root" do
        user = create :user
        put :update, {:id => user.to_param, :user => { "name" => "New name" }}
        expect(response).to redirect_to root_url
      end
    end

    describe "DELETE destroy" do
      it "redirects to root" do
        user = create :user
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'for admin' do
    login_admin
    describe "GET index" do
      it "assigns all users as @users" do
        user = create :user
        get :index
        assigns(:users).should eq(User.all)
      end
    end

    describe "GET show" do
      it "assigns the requested user as @user" do
        user = create :user
        get :show, {:id => user.to_param}
        assigns(:user).should eq(user)
      end
    end

    describe "GET new" do
      it "assigns a new user as @user" do
        get :new
        assigns(:user).should be_a_new(User)
      end
    end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        user = create :user
        get :edit, {:id => user.to_param}
        assigns(:user).should eq(user)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new User" do
          expect {
            post :create, {:user => attributes_for(:user)}
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          post :create, {:user => attributes_for(:user)}
          assigns(:user).should be_a(User)
          assigns(:user).should be_persisted
        end

        it "redirects to the created user" do
          post :create, {:user => attributes_for(:user)}
          response.should redirect_to(User.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => { "name" => "invalid value" }}
          assigns(:user).should be_a_new(User)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => { "name" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:valid_attributes) { { "name" => "New name" } }
        it "updates the requested user" do
          user = create :user
          put :update, {:id => user.to_param, :user => { "name" => "New name" }}
          user.reload
          expect(user.name).to eq("New name")
        end

        it "assigns the requested user as @user" do
          user = create :user
          put :update, {:id => user.to_param, :user => valid_attributes}
          assigns(:user).should eq(user)
        end

        it "redirects to the user" do
          user = create :user
          put :update, {:id => user.to_param, :user => valid_attributes}
          response.should redirect_to(user)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          user = create :user
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = create :user
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested user" do
        user = create :user
        expect {
          delete :destroy, {:id => user.to_param}
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = create :user
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(users_url)
      end
    end
  end
end
