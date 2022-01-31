require 'rails_helper'

RSpec.describe "clients/edit", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      slug: "my-string",
      name: "MyString",
      email: "email-update@test.com",
      password: "my-password"
    ))
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(@client), "post" do

      assert_select "input[name=?]", "client[slug]"

      assert_select "input[name=?]", "client[name]"

      assert_select "input[name=?]", "client[email]"

      assert_select "input[name=?]", "client[password]"
    end
  end
end
