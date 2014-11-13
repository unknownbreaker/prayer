# AUTHENTICATION -----------------------

def current_user
  if session[:id]
    return User.find(session[:id])
  else
    return nil
  end
end



# ERROR HANDLING -----------------------

def set_error(error)
  session[:error] = error
end

def display_error
  if session[:error]
    error = session[:error]
    session[:error] = nil
    return "<p>Error: #{error}</p>"
  end
end


# VIEW STUFF -------------------------

def myself?(user)
  if current_user == user
    @myself = true
  else
    @myself = false
  end
end

def is_prayerrequest?(entry)
  if entry.class.to_s == "Prayerrequest"
    true
  else
    false
  end
end

def stay_or_leave_comment_show_page
  if session[:comment_show_page]
    redirect to ("/prayerrequests/#{session[:comment_show_page]}")
  else
    redirect to ("/prayerrequests")
  end
end
