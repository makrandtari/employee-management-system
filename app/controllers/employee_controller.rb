class EmployeeController < ApplicationController

    def index
      @employees=Employee.all
    end

    def show
        @employee =Employee.find(params[:id])
    end

    def new
    end

    def create
        @employee= Employee.new(employee_params)
        if @employee.save
            redirect_to employee_index_path, notice: "Data successfully create ho gaya!"

        else
            @employees = Employee.all
            render :index, status: :unprocessable_entity
        end
    end

  private

  def employee_params
params.require(:employee).permit(
  :name, :email, :phone, :designation, :profile_image
)  end
end
