require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      slug: "slug",
      name: "Name",
      email: "email@test.com",
      password: "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/slug/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/email@test.com/)
  end
end
