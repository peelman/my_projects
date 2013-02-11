
class MyProjects < Redmine::Hook::ViewListener
  def view_welcome_index_right(context={})
    load_projects()
  end

  def load_projects()
      html = '<div class="box projects" id="statuses">'
      html += '<h3 class="">' + l(:label_my_projects) + '</h3><ul>'
      projects  = Project.visible(User.current).find(:all, :order => "projects.name")
      admin_projects = []
      projects.each do |project|
        if User.current.member_of?(project)
          html += '<li>'
          html += "#{link_to h(project.name), :controller => 'projects', :action => 'show', :id => project }"
          html += " | #{link_to l(:label_issue_plural), :controller => 'issues', :action=>'index', :project_id => project } "
          html += " | #{link_to l(:label_wiki), :controller => 'wiki', :action=>'show', :project_id => project } "
          html += '</li>'
        else
          admin_projects << project
        end
      end
      html += '</ul>'

      if User.current.admin?
        html += '<h3>' + l(:label_admin_projects) + '</h3><ul>'
        admin_projects.each do |project|
          html += '<li>'
          html += "#{link_to h(project.name), :controller => 'projects', :action => 'show', :id => project }"
          html += " | #{link_to l(:label_issue_plural), :controller => 'issues', :action=>'index', :project_id => project } "
          html += " | #{link_to l(:label_wiki), :controller => 'wiki', :action=>'show', :project_id => project } "
          html += '</li>'
        end
        html += '</ul>'
      end
      html += '</div>'
      return html
  end
end

