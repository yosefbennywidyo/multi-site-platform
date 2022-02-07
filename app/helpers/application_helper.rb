module ApplicationHelper
  include Tenantable

  def check_client
    if logged_in?
      capture do
        concat link_to("Enqueue", enqueue_cart_path, method: :get, class: "block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700")
        concat " "
        concat link_to("Cart", shopping_cart_path, method: :get, class: "block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700")
        concat " "
        concat link_to('Logout', sessions_path, data: { turbo_method: :delete}, class: "block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700")
      end
    else
      link_to('Login', login_path, method: :get, class: "block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700")
    end
  end
end