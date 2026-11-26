class EmployeeController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:show]

  def dashboard
    @total_employees = Employee.count
    @total_departments = Department.count
    @recent_employees = Employee.order(created_at: :desc).limit(5)
  end

  def index
    @employee = Employee.new
    @departments = Department.all

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

    unless current_user.role == "admin" ||
           current_user.employee_id == @employee.id
      redirect_to login_path, alert: "Access denied"
    end
  end

  def new
    @employee = Employee.new

    @departments = Department.all
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee, notice: "Successfully created!"
    else
      @departments = Department.all
      @pagy, @employees = pagy(Employee.all, items: 5)

      Rails.logger.info("VALIDATION ERRORS: #{@employee.errors.full_messages}")

      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @departments = Department.all
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employee_index_path, notice: "Data successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employee_index_path, status: :see_other, notice: "Employee deleted."
  end

  private

  def employee_params
    params.require(:employee).permit(
      :name, :email, :phone, :designation, :profile_image, :department_id
    )
  end
end
