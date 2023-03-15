module LoginHelpers
  def login
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
  end

  def guest_login
    visit root_path
    page.first("#login_button").click
  end
end
