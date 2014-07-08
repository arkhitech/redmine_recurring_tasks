module RecurringTasks
  class Hooks < Redmine::Hook::ViewListener
    # view issue
    render_on :view_issues_show_description_bottom, :partial => 'issues/show_recurrence'
    render_on :view_issues_form_details_bottom, :partial => 'issues/update_recurrence'  
  end
end