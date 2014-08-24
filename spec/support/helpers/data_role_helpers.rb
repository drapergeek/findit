module Features
  def have_data_role(role, text)
    have_css("[data-role='#{role}']", text: text)
  end
end
