require 'spec_helper'

describe 'Applications' do
  before { login_as :user }

  describe :index do
    before do
      visit applications_path
    end

    it { page.should have_content 'Listing applications' }
  end

  describe :new do
    before do
      visit applications_path
      within '.title-container' do
        click_link 'New Application'
      end
    end

    it { page.should have_field 'Title' }
    it { page.should have_field 'Url' }
  end

  describe :create do
    before do
      visit new_application_path

      fill_in 'Title', with: 'GMail'
      click_button 'Create'
    end

    it { current_path.should == application_path(Application.last) }
    it { page.should have_content 'Application was successfully created.' }
  end

  describe :show do
    let(:application) { FactoryGirl.create(:application, user: @user) }
    before do
      visit application_path(application)
    end

    it { within('h2') { page.should have_content application.title } }
    it { page.should have_content 'Passwords' }
  end
end
