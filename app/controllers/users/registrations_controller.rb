# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :ensure_normal_user, only: %i[update destroy]

  def new
    @user = User.new
    @study_abroad_expectation = @user.study_abroad_expectations.build
    @study_abroad_target = @user.study_abroad_targets.build
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
 
    #if update_resource(resource, account_update_params)
    if resource.update_without_current_password(account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーの更新・削除はできません。"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:image, :username,
                                              { study_abroad_expectations_attributes: [:expected_country, :expected_state],
                                                study_abroad_targets_attributes: [:target_country, :target_state] }])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:image, :username,
                                              { study_abroad_expectations_attributes: [:expected_country, :expected_state, :id],
                                                study_abroad_targets_attributes: [:target_country, :target_state, :id] }])
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  # end
end
