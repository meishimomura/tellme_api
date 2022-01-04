class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

    def sign_up_params
      params.permit(:user_name, :user_image, :school_id, :group_id, :user_is_student, :email, :password, :password_confirmation, :name)
    end
end
