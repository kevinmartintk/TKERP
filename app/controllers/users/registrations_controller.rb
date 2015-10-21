class Users::RegistrationsController < Devise::RegistrationsController
  layout "application"
  add_breadcrumb "My Profile", :edit_user_registration_path

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end