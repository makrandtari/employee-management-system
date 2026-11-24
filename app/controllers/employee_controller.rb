class EmployeeController < ApplicationController
  def index
    @employee = Employee.new

    employees = Employee.all

    if params[:search].present?
      employees = employees.where(
        "name LIKE ? OR email LIKE ?",
        "%#{params[:search]}%",
        "%#{params[:search]}%"
      )
    end

    @pagy, @employees = pagy(employees, items: 5)
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to employee_index_path, notice: "Data successfully create ho gaya!"
    else
      @pagy, @employees = pagy(Employee.all, items: 5)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def employee_params
    params.require(:employee).permit(
      :name,
      :email,
      :phone,
      :designation,
      :profile_image
    )
  end
end
