# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do
  describe ".find_or_create_with_omniauth" do
    let(:auth) { {"provider"=>"facebook", "uid"=>"123456", "credentials"=>{"token"=>"AAADv"}, "info"=>{"nickname"=>"sylvestre.mergulhao", "email"=>"mergulhao83@gmail.com", "first_name"=>"Sylvestre", "last_name"=>"Mergulhão", "name"=>"Sylvestre Mergulhão", "image"=>"http://graph.facebook.com/526830634/picture?type=square", "urls"=>{"Facebook"=>"http://www.facebook.com/sylvestre.mergulhao", "Website"=>nil}}, "extra"=>{"raw_info"=>{"id"=>"526830634", "name"=>"Sylvestre Mergulhão", "first_name"=>"Sylvestre", "last_name"=>"Mergulhão", "link"=>"http://www.facebook.com/sylvestre.mergulhao", "username"=>"sylvestre.mergulhao", "location"=>{"id"=>"110346955653479", "name"=>"Rio de Janeiro, Rio de Janeiro"}, "education"=>[{"school"=>{"id"=>"115555431792035", "name"=>"UniRio"}, "type"=>"College", "with"=>[{"id"=>"100001030509286", "name"=>"João Aguirre"}, {"id"=>"512001183", "name"=>"Marcos Brando Margulies"}, {"id"=>"100001650369677", "name"=>"Paulo Guilherme Ribeiro"}, {"id"=>"678564390", "name"=>"Duim Knurf"}]}, {"school"=>{"id"=>"109896575694939", "name"=>"Universidade Federal do Estado do Rio de Janeiro"}, "type"=>"College", "with"=>[{"id"=>"100000517388839", "name"=>"João Filho"}]}], "gender"=>"male", "email"=>"mergulhao83@gmail.com", "timezone"=>-2, "locale"=>"pt_BR", "verified"=>true, "updated_time"=>"2011-07-19T00:05:20+0000"}}} }
    context "user doesnt exists" do
      describe "creating a new user" do
        it "should create" do
          expect {
            User.find_or_create_with_omniauth(auth)
          }.to change(User, :count).by(1)
        end
      end
      describe "setting data on new user" do
        subject { User.find_or_create_with_omniauth(auth) }
        it { subject.provider.should == "facebook" }
        it { subject.uid.should == "123456" }
        it { subject.name.should == "Sylvestre Mergulhão" }
        it { subject.email.should == "mergulhao83@gmail.com" }
        it { subject.access_token.should == "AAADv" }
        it { subject.photo_url.should == "http://graph.facebook.com/526830634/picture?type=square" }
        it { subject.extra.should_not be_nil }
      end
    end
    context "user already exists" do
      let!(:existing_user) { create(:omniauth_user, :name => "My old name", :email => "my@old.me", :provider => "facebook", :uid => "123456")}
      describe "finding existing user" do
        it "should find" do
          User.find_or_create_with_omniauth(auth).should == existing_user
        end
        it "should not create" do
          expect {
            User.find_or_create_with_omniauth(auth)
          }.to_not change(User, :count)
        end
      end
      describe "updating existing user" do
        before do
          User.find_or_create_with_omniauth(auth)
        end
        subject { existing_user.reload }
        it { subject.provider.should == "facebook" }
        it { subject.uid.should == "123456" }
        it { subject.name.should == "Sylvestre Mergulhão" }
        it { subject.email.should == "mergulhao83@gmail.com" }
        it { subject.access_token.should == "AAADv" }
        it { subject.photo_url.should == "http://graph.facebook.com/526830634/picture?type=square" }
      end
    end
  end
end
