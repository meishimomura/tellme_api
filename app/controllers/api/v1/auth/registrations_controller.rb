class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

    def sign_up_params
      params.permit(:user_name, :user_image, :school_id, :group_id, :user_is_student, :email, :password, :password_confirmation, :name)
    end

    def account_update_params
      params.permit(:user_name, :user_image, :email, :school_id, :group_id, :user_is_student)
    end

end
