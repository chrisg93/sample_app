require 'spec_helper'

describe "Microposts" do
  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end
  
  describe "creation" do
    describe "failure" do
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
    end
    
    describe "success" do
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end
    end
  end
  
  describe "pluralization" do
    it "should have correct display without microposts" do
      visit root_path
      response.should have_selector("span.microposts", :content => "0 microposts")
    end
    
    it "should have correct display with 1 micropost" do
      visit root_path
      fill_in :micropost_content, :with => "Message 1"
      click_button
      visit root_path
      response.should have_selector("span.microposts", :content => "1 micropost")
      response.should_not have_selector("span.microposts", :content => "microposts")
    end
    
    it "should have correct display with 2 or more microposts" do
      visit root_path
      fill_in :micropost_content, :with => "Message 1"
      click_button
      visit root_path
      fill_in :micropost_content, :with => "Message 2"
      click_button
      visit root_path
      response.should have_selector("span.microposts", :content => "microposts")
    end
  end
end
