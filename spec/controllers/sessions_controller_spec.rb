# -*- encoding : utf-8 -*-
require "spec_helper"

describe SessionsController do
  render_views

  describe "GET create" do
    def do_action
      get :create, provider: "facebook"
    end

    before(:each) do
      @user = create(:omniauth_user, :provider => "facebook", :uid => "100003045769261")
      request.env["omniauth.auth"] = {"provider"=>"facebook", "uid"=>"100003045769261", "credentials"=>{"token"=>"AAADvZADZBnlLABAMVZAUX1s7ptC0m9HZCaaIkMw8AMxFBtV3uZCmjflQDKba5PPt3kqZAgVlmZCeA6tXAUaBlLEInggas8lAGIzXzP4azfrsgZDZD"}, "info"=>{"nickname"=>nil, "email"=>"contato@startupdev.com.br", "first_name"=>"Dejurema", "last_name"=>"Jockifort", "name"=>"Dejurema Jockifort", "image"=>"http://graph.facebook.com/100003045769261/picture?type=square", "urls"=>{"Facebook"=>"http://www.facebook.com/profile.php?id=100003045769261", "Website"=>nil}}, "extra"=>{"user_hash"=>{"id"=>"100003045769261", "name"=>"Dejurema Jockifort", "first_name"=>"Dejurema", "last_name"=>"Jockifort", "link"=>"http://www.facebook.com/profile.php?id=100003045769261", "gender"=>"male", "email"=>"contato@startupdev.com.br", "timezone"=>-2, "locale"=>"pt_BR", "updated_time"=>"2011-10-18T15:01:20+0000"}}}
    end

    it "set user id on session" do
      do_action
      expect(session[:user_id]).to eq(@user.id)
    end

    it "displays success message" do
      do_action
      flash[:notice].should == "Bem Vindo! Você agora está logado."
    end

    describe "redirect" do
      context "no return_path" do
        before do
          session[:return_path] = nil
          do_action
        end
        it { should redirect_to(root_path) }
      end

      context "return_path" do
        before do
          session[:return_path] = "/this/path"
          do_action
        end
        it { should redirect_to("/this/path") }
      end
    end
  end

  describe "GET failure" do
    def do_action
      get :failure
    end

    it "displays alert message" do
      do_action
      flash[:alert].should == 'Não foi possível autenticar, tente novamente.'
    end

    describe "redirect" do
      context "no return_path" do
        before do
          session[:return_path] = nil
          do_action
        end
        it { should redirect_to(root_path) }
      end

      context "return_path" do
        before do
          session[:return_path] = "/this/path"
          do_action
        end
        it { should redirect_to("/this/path") }
      end
    end
  end

  describe "GET destroy" do
    def do_action
      get :destroy
    end

    it "nuliffy user_id on sessions" do
      session[:user_id] = "1"
      do_action
      expect(session[:user_id]).to be_nil
    end

    it "displays success message" do
      do_action
      expect(flash.notice).to eq("Obrigado! Volte em breve.")
    end

    it "redirect to root_path" do
      do_action
      expect(response).to redirect_to(root_path)
    end
  end
end