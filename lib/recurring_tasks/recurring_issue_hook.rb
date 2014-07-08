module RecurringTasks
  class RecurringIssueHook < Redmine::Hook::ViewListener          
    def controller_issues_edit_before_save(context={})
      if User.current.allowed_to?(:add_issue_recurrence, context[:issue].project)
        save_recurring_task(context) unless context[:issue].new_record?
      end      
    end
    
    def controller_issues_new_after_save(context={})
      if User.current.allowed_to?(:add_issue_recurrence, context[:issue].project)
        save_recurring_task(context)
      end
    end
      
    def save_recurring_task(context)
      params = context[:params]
      params[:recurring_task] ||= []
      if params && params[:issue] && (params[:recurring_task][:interval_number]).to_i > 0             
        params[:recurring_task][:fixed_schedule] = (params[:recurring_task][:fixed_schedule]).to_i > 0
        recurring_task = RecurringTask.new(params[:recurring_task])
        recurring_task.issue = context[:issue]
        recurring_task.save!
      end
    end
  end
end


