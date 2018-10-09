# frozen_string_literal: true
# todo: project limitation at : https://docs.google.com/document/d/128QlWRbpKavWIGBwq1zc4BUGBfW8S0b535kLORIHn4Y/edit?usp=sharing
# todo : Restrict - Househunter login gives access to realtor pages too.

class LoginController < ApplicationController
  def new
    if session[:role] != nil && session[:role] == "admin"
      redir = admin_path
      fl = true
    end
    if session[:user_id] != nil
      redir = user_path(session[:user_id])
      fl = true
    end
    if fl == true
      redirect_to redir
    end
  end

  def create
    puts "--------------------------------------------1"
    # Verify if admin
    if params[:login][:email] == 'admin@admin' && params[:login][:password] == 'admin'
      session[:is_admin] = true
      session[:role] = 'admin'
      session[:logged_in] = true
      redir = admin_path
    else
      # If not admin, set appropriate levels
      puts "--------------------------------------------Else"
      user = User.find_by(email_id: params[:login][:email].downcase)
      puts "--------------------------------------------Found user"
      if user && user.password == params[:login][:password]
        session[:user_id] = user.id
        session[:logged_in] = true
        if params[:login][:role] == 'realtor'

          puts "--------------------------------------------Rel"
          if user.is_realtor != nil && user.is_realtor == true
            session[:is_realtor] = true
            session[:role] = 'realtor'
            redir = realtor_path(Realtor.find_by(users_id: user.id).id)
          end
        elsif params[:login][:role] == 'househunter'
          if user.is_househunter != nil && user.is_househunter == true
            session[:is_househunter] = true
            session[:role] = 'househunter'
            redir = househunter_path(Househunter.find_by(users_id: user.id).id)
          end
        end
      else
        redirect_to login_path, notice: 'Invalid Credentials' and return
      end
    end

    if session[:role] == nil
      redir = login_path
      reset_session
      flash.notice = 'Please select a role that you are registered for.'
    end
    puts "---------------------------------------------"
    puts redir.inspect
    redirect_to redir
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
