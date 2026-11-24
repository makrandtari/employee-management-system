module ApplicationHelper
  include Pagy::Frontend
include EmployeeHelper

  def index
    @employees = filtered_employees
  end
end
