RSpec.describe Mailinabox::Api::Client do
  describe :users, vcr: {cassette_name: 'users'} do
    let(:response) { Mailinabox::Api::Client.new.users }
    let(:users) { response.first.fetch("users", []) }
    
    it { expect(response).to be_a_kind_of(Array) }
    it { expect(response.first.fetch("domain", nil)).to eq("testdomain.com") }
    
    it { expect(users).to be_a_kind_of(Array) }
    it { expect(users.size).to eq 2 }
  end
  
  describe :add_user, vcr: {cassette_name: 'add_user'} do
    let(:response) { Mailinabox::Api::Client.new.add_user(email: "user@testdomain.com", password: "12345678") }
    it { expect(response).to eq true }
  end
  
  describe :remove_user, vcr: {cassette_name: 'remove_user'} do
    let(:response) { Mailinabox::Api::Client.new.remove_user(email: "user@testdomain.com") }
    it { expect(response).to eq true }
  end
  
  describe :add_user_privilege, vcr: {cassette_name: 'add_user_privilege'} do
    let(:response) { Mailinabox::Api::Client.new.add_user_privilege(email: "user@testdomain.com", privilege: :admin) }
    it { expect(response).to eq true }
  end
  
  describe :remove_user_privilege, vcr: {cassette_name: 'remove_user_privilege'} do
    let(:response) { Mailinabox::Api::Client.new.remove_user_privilege(email: "user@testdomain.com", privilege: :admin) }
    it { expect(response).to eq true }
  end
end
