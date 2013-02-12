
class MyProjects < Redmine::Hook::ViewListener
  def view_welcome_index_right(context={})
    load_projects()
  end

  def load_projects()
      html = '<div class="box projects" id="statuses">'
      html += '<h3 class="">' + l(:label_my_projects) + '</h3>'

      all_projects  = Project.visible().find(:all, :order => "projects.name")
      admin_projects = []
      my_projects = []

      all_projects.each do |project|
        if User.current.member_of?(project)
          my_projects << project
        else
          admin_projects << project
        end
      end

      if my_projects.first
        html += '<ul>'
        my_projects.each do |project|
          html += link_to_project(project)
        end
        html += '</ul>'
      else
        html += '<p class="nodata">' + l(:label_no_data) + '</p>'
      end

      if User.current.admin? && admin_projects.first
        html += '<h3>' + l(:label_admin_projects) + '</h3>'
        html += '<ul>'
        admin_projects.each do |project|
          html += link_to_project(project)
        end
        html += '</ul>'
      end
      html += '</div>'
      
      html += "<div> #{User.current.projects_by_role}</div>"
      
      return html
  end
  
  def link_to_project(project)
    html = '<li>'
    html += "#{link_to h(project.name), :controller => 'projects', :action => 'show', :id => project }"
    html += " | #{link_to l(:label_issue_plural), :controller => 'issues', :action=>'index', :project_id => project } "
    html += " | #{link_to l(:label_wiki), :controller => 'wiki', :action=>'show', :project_id => project } "
    html += '</li>'
    
    return html
  end
    
end

