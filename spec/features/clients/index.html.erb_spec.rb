require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(slug: "my-string-1", name: "MyString1", email: "email-1@test.com", password: "my-password"),
      Client.create!(slug: "my-string-2", name: "MyString2", email: "email-2@test.com", password: "my-password")
    ])
  end

  it "renders a list of clients" do
    render
    puts "response.body: #{response.body}"
    assert_select "p>strong", text: "Slug:".to_s, count: 2
    assert_select "p>strong", text: "Name:".to_s, count: 2
  end
end
