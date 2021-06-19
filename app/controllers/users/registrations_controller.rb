# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :ensure_normal_user, only: %i[update destroy]

  def new
    @user = User.new
    @study_abroad_expectation = @user.study_abroad_expectations.build
    @study_abroad_target = @user.study_abroad_targets.build
  end

  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーの更新・削除はできません。"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:username,
                                              { study_abroad_expectations_attributes: [:expected_country, :expected_state],
                                                study_abroad_targets_attributes: [:target_country, :target_state] }])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:image, :username,
                                              { study_abroad_expectations_attributes: [:expected_country, :expected_state, :id],
                                                study_abroad_targets_attributes: [:target_country, :target_state, :id] }])
  end
end
