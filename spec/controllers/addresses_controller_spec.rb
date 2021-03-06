require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  login_user
  let(:user) { FactoryGirl.create(:user) }
  let(:address) { FactoryGirl.create(:address, user: user)}
 
  it "should have a current user" do 
    expect(subject.current_user).not_to be_nil
  end

  it "should have an address that is a string" do 
    expect(address.street_address).to include("Market")
  end

  describe "creating a new address" do 

    context "with a valid address" do 

      let(:address_attributes) { FactoryGirl.attributes_for(:address, :user_id => user) }

      it "creates a new address" do 
        expect{
          post :create, :user_id => user, :address => address_attributes
        }.to change(Address, :count).by(1)
      end

      it "redirects to the new address" do 
        expect{
          post :create, :user_id => user, :address => address_attributes
          response.should redirect_to Address.last
        }
      end
    end
  end
end
